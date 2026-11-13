# Ingestion

Loaders that run outside dbt and fill the raw tables.

## `ingest_openrouter_models.py`

A Databricks notebook, exported in *Source* format. It calls OpenRouter's public `/api/v1/models` endpoint (no key needed) and appends one row per model to `workspace.raw_openrouter.models_daily`:

| Column | Content |
|---|---|
| `model_id` | OpenRouter model id, e.g. `google/gemini-2.5-pro` |
| `raw_json` | The full API record as text, unmodified |
| `loaded_at` | UTC timestamp of the load |

It follows the raw-layer rules in [`CONVENTIONS.md`](../CONVENTIONS.md) §1: the whole JSON record is stored (parsing happens in dbt staging), and every load is appended, so price history builds up day by day.

**Schedule:** Databricks job `ingest_openrouter_models`, daily at 06:00 Europe/London, on serverless compute. dbt's source freshness check on `models_daily` warns after 26 hours and errors after 50 hours, so a missed run shows up.

**Keeping it in sync:** the job runs the copy in the Databricks workspace. After changing the notebook there, re-export it (Workspace → the notebook → ⋮ → *Export* → *Source file*) and commit it here.

## Epoch AI

There's no loader for Epoch AI. The [Notable AI models CSV](https://epoch.ai/data/notable_ai_models.csv) is uploaded by hand to `workspace.raw_epoch.notable_ai_models`; the upload settings are in `CONVENTIONS.md` §8.
