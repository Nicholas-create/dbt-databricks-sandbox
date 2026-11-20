"""Combined scores: one per category per model (the first pill in each category), plus
the headline 'Overall' tab across every category.

Why not an average: raw averages reward models that only sat easy benchmarks, and
rank averages reward models that only competed against old rivals. Instead this
fits an item response theory (IRT) model:

    predicted share solved = sigmoid( slope_b * (skill_m - difficulty_b) )

Every model gets a skill, every benchmark a difficulty and a slope (how sharply it
separates models), all fitted together. Benchmarks are linked through the models
that sat several of them; a missing result is simply absent, never zero. A
saturated benchmark (everyone near 100%) carries little information in this model,
so it barely moves anyone's skill. The score shown is the skill expressed as
"share of tasks solved on a typical benchmark" (median difficulty, standard slope
of 1), so it reads like every other benchmark.

Weights (computed in SQL in dim_benchmarks, where they can be read and tested):
each result counts in proportion to its benchmark's weight. Newer benchmarks weigh
more (half-life var benchmark_half_life_years), versions of one benchmark share one
benchmark's weight, and for the Overall every category gets the share set in the
seed benchmark_categories (equal by default), however many benchmarks it has.

The Overall is one pooled fit across all categories, not an average of the
category scores. One fit puts every model on one scale even when it was only tested
in some categories; that works because benchmark results are dominated by one
general factor (a model strong on one hard benchmark is usually strong on others).

This is a Python model because the fit is an iterative optimisation (3,000 Adam
steps), which SQL can't express. It runs on Databricks serverless compute.
"""
import json

import numpy as np

MIN_RESULTS = 2               # per category: one lucky score shouldn't top a category
MIN_RESULTS_OVERALL = 3       # the headline needs a little more evidence,
MIN_CATEGORIES_OVERALL = 2    # from at least two skill areas, or it's a category score
STEPS, LEARNING_RATE = 3000, 0.05
# L2 penalties acting as gentle priors: skills and difficulties lean toward 0, slopes
# lean firmly toward 1 (log slope 0). The slope prior stops near-saturated benchmarks
# from becoming absurdly steep and pins the scale. The skill prior is deliberately
# weak: at 0.05 it pulled models with few results so hard that Fable 5.2 (2 coding
# results) ranked below Opus 5.5, a model it beat on every benchmark they share.
L2_SKILL, L2_DIFFICULTY, L2_LOG_SLOPE = 0.01, 0.01, 1.0


def sigmoid(z):
    return 1 / (1 + np.exp(-np.clip(z, -30.0, 30.0)))


def fit_irt(model_idx, bench_idx, share, weight, n_models, n_bench):
    """Full-batch Adam on weighted cross-entropy plus L2 priors.

    weight: one per result, scaled to average 1, so the priors keep the same
    strength whatever the weights add up to. Returns (skill, difficulty, log_slope).
    """
    params = [np.zeros(n_models), np.zeros(n_bench), np.zeros(n_bench)]
    l2 = (L2_SKILL, L2_DIFFICULTY, L2_LOG_SLOPE)
    m1 = [np.zeros_like(p) for p in params]
    m2 = [np.zeros_like(p) for p in params]
    for t in range(1, STEPS + 1):
        skill, difficulty, log_slope = params
        slope = np.exp(log_slope)[bench_idx]
        gap = skill[model_idx] - difficulty[bench_idx]
        g = weight * (sigmoid(slope * gap) - share)   # d(weighted cross-entropy)/d(logit)
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


def fit_scores(rows, weight_col):
    """Fit one IRT model to `rows` (one per benchmark per model) and return
    {model_name: score}: the share of a typical benchmark of the fit it would solve."""
    bench_ids = list(dict.fromkeys(rows["benchmark_id"]))   # keeps display order
    bench_pos = {b: i for i, b in enumerate(bench_ids)}
    names = sorted(rows["model_name"].unique())
    model_pos = {n: i for i, n in enumerate(names)}
    weight = rows[weight_col].to_numpy(dtype=float)
    skill, difficulty, _ = fit_irt(
        rows["model_name"].map(model_pos).to_numpy(),
        rows["benchmark_id"].map(bench_pos).to_numpy(),
        np.clip(rows["score"].to_numpy() / rows["unit_max"].to_numpy(), 0.0, 1.0),
        weight / weight.mean(),
        len(names), len(bench_ids),
    )
    typical_difficulty = float(np.median(difficulty))
    return {n: round(float(sigmoid(skill[i] - typical_difficulty)), 4) for n, i in model_pos.items()}


def details(rows):
    """Model details from its first result in display order, latest release date."""
    first = rows.iloc[0]
    released = rows["released_date"].dropna()
    open_w = first["is_open_weights"]
    price = first["output_price_usd_per_mtok"]
    return (
        first["model_key"],
        released.max() if len(released) else None,
        first["lab"],
        None if open_w is None or open_w != open_w else bool(open_w),   # NaN != NaN
        None if price is None or price != price else float(price),
    )


def model(dbt, session):
    dbt.config(materialized="table", submission_method="serverless_cluster")

    from pyspark.sql.types import (BooleanType, DateType, DoubleType, IntegerType,
                                   StringType, StructField, StructType)

    benchmarks = (dbt.ref("dim_benchmarks").toPandas()
                  .query("is_in_combined_scores")
                  .sort_values(["category_sort_order", "display_rank"]))  # tooltip parts follow the pill order
    scores = dbt.ref("fct_benchmark_scores").toPandas()
    rows = scores.merge(
        benchmarks[["benchmark_id", "unit_max", "weight_in_category", "weight_in_overall",
                    "category_sort_order", "display_rank"]],
        on="benchmark_id",
    ).sort_values(["category_sort_order", "display_rank", "model_name"])

    out = []
    category_scores = {}   # (category, model_name) -> score, for the Overall's breakdown
    category_order = list(dict.fromkeys(benchmarks["category"]))

    # ── one fit per category ──
    for category in category_order:
        cat_rows = rows[rows["category"] == category]
        if cat_rows["benchmark_id"].nunique() < 2:
            continue  # nothing to combine
        fitted = fit_scores(cat_rows, "weight_in_category")
        components = json.dumps(list(dict.fromkeys(cat_rows["benchmark_id"])))
        for name, m_rows in cat_rows.groupby("model_name", sort=False):
            if len(m_rows) < MIN_RESULTS:
                continue
            category_scores[(category, name)] = fitted[name]
            model_key, released, lab, open_w, price = details(m_rows)
            out.append((
                f"{category}|{model_key}", category, name, fitted[name], len(m_rows), released,
                lab, open_w, price,
                json.dumps([[r.benchmark_id, float(r.score)] for r in m_rows.itertuples()]),
                components, MIN_RESULTS,
            ))

    # ── the headline Overall: one pooled fit across every category ──
    all_rows = rows[rows["weight_in_overall"] > 0]
    fitted = fit_scores(all_rows, "weight_in_overall")
    with_category_score = [c for c in category_order if any(k[0] == c for k in category_scores)]
    components = json.dumps([f"{c}-overall" for c in with_category_score])
    for name, m_rows in all_rows.groupby("model_name", sort=False):
        if len(m_rows) < MIN_RESULTS_OVERALL or m_rows["category"].nunique() < MIN_CATEGORIES_OVERALL:
            continue
        model_key, released, lab, open_w, price = details(m_rows)
        parts = [[f"{c}-overall", category_scores[(c, name)]]
                 for c in with_category_score if (c, name) in category_scores]
        out.append((
            f"overall|{model_key}", "overall", name, fitted[name], len(m_rows), released,
            lab, open_w, price, json.dumps(parts), components, MIN_RESULTS_OVERALL,
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
