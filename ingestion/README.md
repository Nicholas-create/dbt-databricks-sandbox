# Ingestion

Loaders that run outside dbt and fill the raw tables.

## `ingest_openrouter_models.py`

A Databricks notebook, exported in *Source* format. It calls OpenRouter's public `/api/v1/models` endpoint (no key needed) and appends one row per model to `ai_model_tracker.raw_openrouter.models_daily`:

| Column | Content |
|---|---|
| `model_id` | OpenRouter model id, e.g. `google/gemini-2.5-pro` |
| `raw_json` | The full API record as text, unmodified |
| `loaded_at` | UTC timestamp of the load |

It follows the raw-layer rules in [`CONVENTIONS.md`](../CONVENTIONS.md) §1: the whole JSON record is stored (parsing happens in dbt staging), and every load is appended, so price history builds up day by day.

**Schedule:** Databricks job `ingest_openrouter_models`, daily at 06:00 Europe/London, on serverless compute. dbt's source freshness check on `models_daily` warns after 26 hours and errors after 50 hours, so a missed run shows up.

**Keeping it in sync:** the job runs the copy in the Databricks workspace. After changing the notebook there, re-export it (Workspace → the notebook → ⋮ → *Export* → *Source file*) and commit it here.

## Model releases (manual)

Benchmarks, results and the model list have no loader: they're entered from each model's release page into the dbt seeds in [`seeds/manual/`](../seeds/manual/), and `dbt build` loads them. The step-by-step runbook and one release note per release are in [`manual/`](manual/README.md).

## Retired: Epoch AI

The project started from Epoch AI's benchmark hub and notable-models list. On 20 Nov 2026 the data still in use was copied into the seeds (see [`manual/releases/2026-11-20_epoch-baseline-copy.md`](manual/releases/2026-11-20_epoch-baseline-copy.md)), and the loader, source and staging models were removed. The raw tables `ai_model_tracker.raw_epoch.*` are no longer read by anything.
