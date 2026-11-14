# Databricks notebook source
# One-off load of Epoch AI's benchmark hub (https://epoch.ai/benchmarks, CC BY 4.0)
# into workspace.raw_epoch.benchmark_rows: the project's historical baseline, run
# once on 14 Nov 2026. It is NOT scheduled: from then on, new results are entered
# from each model's release page into raw_manual (see ingestion/manual/README.md).
# Re-running it appends a fresh copy; staging only reads the latest load.
#
# The zip holds ~90 CSVs, each with its own columns. Every CSV row is stored as
# a JSON object of strings next to its file name, so one raw table covers every
# benchmark and a new Epoch file never needs a loader change. Parsing happens
# in dbt staging (CONVENTIONS.md section 1).
import csv
import io
import json
import zipfile
from datetime import datetime, timezone

import requests
from pyspark.sql import Row

ZIP_URL = "https://epoch.ai/data/benchmark_data.zip"
TABLE = "workspace.raw_epoch.benchmark_rows"

spark.sql("CREATE SCHEMA IF NOT EXISTS workspace.raw_epoch")

resp = requests.get(ZIP_URL, timeout=60)
resp.raise_for_status()
loaded_at = datetime.now(timezone.utc)

rows = []
with zipfile.ZipFile(io.BytesIO(resp.content)) as zf:
    for file_name in sorted(n for n in zf.namelist() if n.endswith(".csv")):
        text = zf.read(file_name).decode("utf-8-sig")  # -sig drops a byte-order mark if present
        for row_number, record in enumerate(csv.DictReader(io.StringIO(text)), start=1):
            rows.append(Row(
                file_name=file_name,
                row_number=row_number,
                raw_json=json.dumps(record, ensure_ascii=False),
                loaded_at=loaded_at,
            ))

if not rows:
    raise ValueError("Epoch zip contained no CSV rows: refusing to append an empty load")

(spark.createDataFrame(rows)
      .write
      .mode("append")
      .saveAsTable(TABLE))

print(f"Loaded {len(rows)} rows from {len({r.file_name for r in rows})} files at {loaded_at:%Y-%m-%d %H:%M} UTC")
