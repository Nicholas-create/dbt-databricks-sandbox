"""Export the website's data from the production marts to a static JSON file.

The public site can't query Databricks while someone is viewing it (that would
put a token in the browser), so this runs after the daily production build and
writes the data the page needs into site/data/benchmarks.json.

All modelling stays in dbt: this script only selects from tested marts and
reshapes rows into the nested layout the page reads. Presentation choices
(colours, labels, which labs get logos) live in the site's JavaScript.

Usage (credentials come from the same env vars dbt uses, never from the repo):
    python scripts/export_site_data.py                         # reads workspace.analytics
    python scripts/export_site_data.py --schema dbt_nsampson   # preview a dev build
"""

import argparse
import json
import math
import os
from collections import defaultdict
from datetime import datetime, timezone
from decimal import Decimal
from pathlib import Path

from databricks import sql

OUT_FILE = Path(__file__).resolve().parent.parent / "site" / "data" / "benchmarks.json"

QUERIES = {
    "categories": """
        select category_id, label, phrase
        from {db}.benchmark_categories
        order by sort_order
    """,
    "benchmarks": """
        select benchmark_id, category, benchmark_name, publisher, source_url, harnesses,
               unit, unit_max, n_models, latest_release_date, benchmark_family, variant_label
        from {db}.dim_benchmarks
        where n_models > 0
        order by category_sort_order, display_rank   -- most relevant first, versions together
    """,
    "scores": """
        select benchmark_id, model_name, lab, is_open_weights, score, released_date,
               harness, effort, output_price_usd_per_mtok, source_type, source_url
        from {db}.fct_benchmark_scores
        order by benchmark_id, score desc, model_name
    """,
    "composites": """
        select category, model_name, lab, is_open_weights, score, released_date,
               output_price_usd_per_mtok, parts_json, components_json, min_results
        from {db}.fct_benchmark_category_scores
        order by category, score desc, model_name
    """,
}


def num(value):
    # DECIMAL prices arrive as Decimal; JSON has no decimal type, so the page gets a
    # plain number. Fine for display, never used for further maths.
    return float(value) if isinstance(value, Decimal) else value


def iso(d):
    return d.isoformat() if d else ""


def model_entry(r, **extra):
    return {
        "name": r.model_name,
        "lab": r.lab or "",
        "open_weights": r.is_open_weights,
        "score": round(float(r.score), 4),
        "released": iso(r.released_date),
        **extra,
        "output_price": num(r.output_price_usd_per_mtok),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--catalog", default="workspace")
    parser.add_argument("--schema", default="analytics")
    args = parser.parse_args()
    db = f"{args.catalog}.{args.schema}"

    host = os.environ["DATABRICKS_HOST"].removeprefix("https://").rstrip("/")
    with sql.connect(
        server_hostname=host,
        http_path=os.environ["DATABRICKS_HTTP_PATH"],
        access_token=os.environ["DATABRICKS_TOKEN"],
    ) as conn, conn.cursor() as cur:
        rows = {}
        for name, query in QUERIES.items():
            cur.execute(query.format(db=db))
            rows[name] = cur.fetchall()

    if not rows["scores"]:
        raise SystemExit("No benchmark scores returned: refusing to publish an empty site.")

    scores_by_bench = defaultdict(list)
    for r in rows["scores"]:
        scores_by_bench[r.benchmark_id].append(model_entry(
            r,
            harness=r.harness or "",
            effort=r.effort or "",
            source_type=r.source_type,   # null = Epoch's run; vendor_reported / independent = entered by hand
            source_url=r.source_url,
        ))

    benchmarks = []
    for b in rows["benchmarks"]:
        models = scores_by_bench[b.benchmark_id]
        if b.unit == "index":
            # open-ended index: round the axis up to a multiple of 40 so quarter ticks are whole tens
            top = max(m["score"] for m in models)
            axis_max = 40 * math.ceil(top / 40)
        else:
            axis_max = num(b.unit_max)
        benchmarks.append({
            "id": b.benchmark_id,
            "category": b.category,
            "name": b.benchmark_name,
            "family": b.benchmark_family,          # versions sharing a family form one split pill
            "variant": b.variant_label or "",      # label inside that pill, e.g. "2.0"
            "publisher": b.publisher or "",
            "source": b.source_url or "",
            "harnesses": [] if b.harnesses is None else [str(h) for h in b.harnesses],  # arrives as a numpy array
            "unit": b.unit,
            "max": axis_max,
            "n_models": b.n_models,
            "latest_release": iso(b.latest_release_date),
            "models": models,
        })

    # Category "Overall" pills, fitted in dbt (fct_benchmark_category_scores)
    composites_by_cat = defaultdict(list)
    for r in rows["composites"]:
        composites_by_cat[r.category].append(r)
    composites = []
    for c in rows["categories"]:
        cat_rows = composites_by_cat.get(c.category_id)
        if not cat_rows:
            continue
        models = [model_entry(r, harness="", effort="", parts=json.loads(r.parts_json)) for r in cat_rows]
        composites.append({
            "id": f"{c.category_id}-overall",
            "category": c.category_id,
            "name": "Overall",
            "kind": "composite",
            "publisher": "", "source": "", "harnesses": [],
            "unit": "pct", "max": 1,
            "components": json.loads(cat_rows[0].components_json),
            "min_results": cat_rows[0].min_results,
            "n_models": len(models),
            "latest_release": max((m["released"] for m in models), default=""),
            "models": models,
        })

    all_benchmarks = composites + benchmarks  # composites first: "Overall" is each category's first pill
    payload = {
        "generated": datetime.now(timezone.utc).date().isoformat(),
        "generated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "source": "Epoch AI, Capabilities & benchmarking (CC BY 4.0), plus results published by model developers",
        "source_schema": db,
        "categories": [
            {"id": c.category_id, "label": c.label, "phrase": c.phrase,
             "benchmarks": [b["id"] for b in all_benchmarks if b["category"] == c.category_id]}
            for c in rows["categories"]
        ],
        "benchmarks": all_benchmarks,
    }

    OUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUT_FILE.write_text(json.dumps(payload, indent=1))
    n_manual = sum(1 for r in rows["scores"] if r.source_type)
    print(f"Wrote {len(all_benchmarks)} benchmarks, {len(rows['scores'])} scores "
          f"({n_manual} entered by hand) to {OUT_FILE}")


if __name__ == "__main__":
    main()
