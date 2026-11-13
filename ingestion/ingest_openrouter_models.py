# Databricks notebook source
import json
import requests
from datetime import datetime, timezone
from pyspark.sql import Row

spark.sql("CREATE SCHEMA IF NOT EXISTS workspace.raw_openrouter")

resp = requests.get("https://openrouter.ai/api/v1/models", timeout=30)
resp.raise_for_status()
models = resp.json()["data"]
loaded_at = datetime.now(timezone.utc)

rows = [
    Row(model_id=m["id"], raw_json=json.dumps(m), loaded_at=loaded_at)
    for m in models
]

(spark.createDataFrame(rows)
      .write
      .mode("append")
      .saveAsTable("workspace.raw_openrouter.models_daily"))

print(f"Loaded {len(rows)} models at {loaded_at:%Y-%m-%d %H:%M} UTC")