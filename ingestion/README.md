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

- **Notable AI models:** no loader. The [CSV](https://epoch.ai/data/notable_ai_models.csv) is uploaded by hand to `workspace.raw_epoch.notable_ai_models`; the upload settings are in `CONVENTIONS.md` §8.
- **Benchmarks (`ingest_epoch_benchmarks.py`):** a one-off load of Epoch's benchmark hub (`epoch.ai/data/benchmark_data.zip`) into `workspace.raw_epoch.benchmark_rows`, run on 14 Nov 2026 as the historical baseline. It is **not scheduled**. One row per CSV row: `file_name`, `row_number`, `raw_json` (the row as a JSON object, untouched) and `loaded_at`. Re-running it appends a fresh copy, and staging reads only the latest load.

## Model releases (manual)

Every result since the baseline is entered from the model's release page into `workspace.raw_manual`. Tables, templates, one batch file per release and the step-by-step runbook are in [`manual/`](manual/README.md).
