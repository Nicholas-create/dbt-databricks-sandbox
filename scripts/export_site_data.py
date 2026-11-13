"""Export the website's data from the production marts to a static JSON file.

The public site can't query Databricks while someone is viewing it (that would
put a token in the browser), so this runs after the daily production build and
writes the data the page needs into site/data/models.json.

All modelling stays in dbt: this script only selects columns from one tested
mart and renames them for the page. Presentation choices (which labs to
highlight, colours, labels) live in the site's JavaScript.

Usage (credentials come from the same env vars dbt uses, never from the repo):
    python scripts/export_site_data.py                    # reads workspace.analytics
    python scripts/export_site_data.py --schema dbt_nsampson   # preview a dev build
"""

import argparse
import json
import os
from datetime import datetime, timezone
from decimal import Decimal
from pathlib import Path

from databricks import sql

OUT_FILE = Path(__file__).resolve().parent.parent / "site" / "data" / "models.json"

QUERY = """
    select
        model_name,
        organization,
        published_date,
        is_open_weights,
        input_price_usd_per_mtok,
        output_price_usd_per_mtok,
        context_length_tokens,
        price_as_of_date
    from {catalog}.{schema}.rpt_models_latest_price
    where has_price
      and output_price_usd_per_mtok > 0   -- log-scale chart: free (0) can't be plotted
    order by published_date, model_name
"""


def to_number(value):
    # Prices are DECIMAL in the warehouse; JSON has no decimal type, so the page
    # gets a plain number. Fine for display, never used for further maths.
    return float(value) if isinstance(value, Decimal) else value


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--catalog", default="workspace")
    parser.add_argument("--schema", default="analytics")
    args = parser.parse_args()

    host = os.environ["DATABRICKS_HOST"].removeprefix("https://").rstrip("/")
    with sql.connect(
        server_hostname=host,
        http_path=os.environ["DATABRICKS_HTTP_PATH"],
        access_token=os.environ["DATABRICKS_TOKEN"],
    ) as conn, conn.cursor() as cur:
        cur.execute(QUERY.format(catalog=args.catalog, schema=args.schema))
        rows = cur.fetchall()

    if not rows:
        raise SystemExit("No priced models returned: refusing to publish an empty site.")

    models = [
        {
            "name": r.model_name,
            "organization": r.organization,
            "released": r.published_date.isoformat(),
            "open_weights": r.is_open_weights,
            "input": to_number(r.input_price_usd_per_mtok),
            "output": to_number(r.output_price_usd_per_mtok),
            "context": r.context_length_tokens,
        }
        for r in rows
    ]

    payload = {
        "generated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "prices_as_of": max(r.price_as_of_date for r in rows).isoformat(),
        "source_schema": f"{args.catalog}.{args.schema}",
        "models": models,
    }

    OUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUT_FILE.write_text(json.dumps(payload, indent=1))
    print(f"Wrote {len(models)} models to {OUT_FILE.relative_to(Path.cwd()) if OUT_FILE.is_relative_to(Path.cwd()) else OUT_FILE}")


if __name__ == "__main__":
    main()
