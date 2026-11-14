"""One combined 'Overall' score per category per model (the first pill in each category).

Why not an average: raw averages reward models that only sat easy benchmarks, and
rank averages reward models that only competed against old rivals. Instead this
fits an item response theory (IRT) model, as Epoch does for its Capabilities Index:

    predicted share solved = sigmoid( slope_b * (skill_m - difficulty_b) )

Every model gets a skill, every benchmark a difficulty and a slope (how sharply it
separates models), all fitted together. Benchmarks are linked through the models
that sat several of them; a missing result is simply absent, never zero. The score
shown is the skill expressed as "share of tasks solved on a typical benchmark of
this category" (median difficulty, standard slope of 1), so it starts at 0 like
every other benchmark.

This is a Python model because the fit is an iterative optimisation (3,000 Adam
steps), which SQL can't express. It runs on Databricks serverless compute.
"""
import json

import numpy as np

MIN_RESULTS = 2  # one lucky score shouldn't top a category
STEPS, LEARNING_RATE = 3000, 0.05
# L2 penalties acting as gentle priors: skills and difficulties lean toward 0, slopes
# lean firmly toward 1 (log slope 0). The slope prior stops near-saturated benchmarks
# from becoming absurdly steep and pins the scale. The skill prior is deliberately
# weak: at 0.05 it pulled models with few results so hard that Fable 5.2 (2 coding
# results) ranked below Opus 5.5, a model it beat on every benchmark they share.
L2_SKILL, L2_DIFFICULTY, L2_LOG_SLOPE = 0.01, 0.01, 1.0


def sigmoid(z):
    return 1 / (1 + np.exp(-np.clip(z, -30.0, 30.0)))


def fit_irt(model_idx, bench_idx, share, n_models, n_bench):
    """Full-batch Adam on cross-entropy plus L2 priors. Returns (skill, difficulty, log_slope)."""
    params = [np.zeros(n_models), np.zeros(n_bench), np.zeros(n_bench)]
    l2 = (L2_SKILL, L2_DIFFICULTY, L2_LOG_SLOPE)
    m1 = [np.zeros_like(p) for p in params]
    m2 = [np.zeros_like(p) for p in params]
    for t in range(1, STEPS + 1):
        skill, difficulty, log_slope = params
        slope = np.exp(log_slope)[bench_idx]
        gap = skill[model_idx] - difficulty[bench_idx]
        g = sigmoid(slope * gap) - share          # d(cross-entropy)/d(logit), one per result
        grads = [
            2 * l2[0] * skill + np.bincount(model_idx, weights=g * slope, minlength=n_models),
            2 * l2[1] * difficulty - np.bincount(bench_idx, weights=g * slope, minlength=n_bench),
            2 * l2[2] * log_slope + np.bincount(bench_idx, weights=g * slope * gap, minlength=n_bench),
        ]
        for k in range(3):                        # Adam update
            m1[k] = 0.9 * m1[k] + 0.1 * grads[k]
            m2[k] = 0.999 * m2[k] + 0.001 * grads[k] ** 2
            params[k] = params[k] - LEARNING_RATE * (m1[k] / (1 - 0.9 ** t)) / (np.sqrt(m2[k] / (1 - 0.999 ** t)) + 1e-8)
    return params


def model(dbt, session):
    dbt.config(materialized="table", submission_method="serverless_cluster")

    from pyspark.sql.types import (BooleanType, DateType, DoubleType, IntegerType,
                                   StringType, StructField, StructType)

    benchmarks = (dbt.ref("dim_benchmarks").toPandas()
                  .query("unit != 'index'")
                  .sort_values("sort_order"))
    scores = dbt.ref("fct_benchmark_scores").toPandas()

    out = []
    for category, benches in benchmarks.groupby("category", sort=False):
        benches = benches.reset_index(drop=True)
        if len(benches) < 2:
            continue  # nothing to combine
        bench_pos = {b: i for i, b in enumerate(benches["benchmark_id"])}
        cat_scores = scores[scores["benchmark_id"].isin(bench_pos)].copy()
        if cat_scores.empty:
            continue
        cat_scores["bench_idx"] = cat_scores["benchmark_id"].map(bench_pos)
        cat_scores = cat_scores.sort_values(["bench_idx", "model_name"])
        unit_max = cat_scores["benchmark_id"].map(dict(zip(benches["benchmark_id"], benches["unit_max"])))

        names = sorted(cat_scores["model_name"].unique())
        model_pos = {n: i for i, n in enumerate(names)}
        skill, difficulty, _ = fit_irt(
            cat_scores["model_name"].map(model_pos).to_numpy(),
            cat_scores["bench_idx"].to_numpy(),
            np.clip(cat_scores["score"].to_numpy() / unit_max.to_numpy(), 0.0, 1.0),
            len(names), len(benches),
        )
        typical_difficulty = float(np.median(difficulty))
        components = json.dumps(list(benches["benchmark_id"]))

        for name, rows in cat_scores.groupby("model_name", sort=False):
            if len(rows) < MIN_RESULTS:
                continue
            first = rows.iloc[0]  # model details from its first benchmark in category order
            released = rows["released_date"].dropna()
            price = first["output_price_usd_per_mtok"]
            out.append((
                f"{category}|{first['model_key']}",
                category,
                name,
                round(float(sigmoid(skill[model_pos[name]] - typical_difficulty)), 4),
                len(rows),
                released.max() if len(released) else None,
                first["lab"],
                None if first["is_open_weights"] is None or first["is_open_weights"] != first["is_open_weights"] else bool(first["is_open_weights"]),
                None if price is None or price != price else float(price),
                json.dumps([[r.benchmark_id, float(r.score)] for r in rows.itertuples()]),
                components,
                MIN_RESULTS,
            ))

    schema = StructType([
        StructField("category_model_key", StringType(), False),
        StructField("category", StringType(), False),
        StructField("model_name", StringType(), False),
        StructField("score", DoubleType(), False),
        StructField("n_results", IntegerType(), False),
        StructField("released_date", DateType(), True),
        StructField("lab", StringType(), True),
        StructField("is_open_weights", BooleanType(), True),
        StructField("output_price_usd_per_mtok", DoubleType(), True),
        StructField("parts_json", StringType(), False),
        StructField("components_json", StringType(), False),
        StructField("min_results", IntegerType(), False),
    ])
    return session.createDataFrame(out, schema)
