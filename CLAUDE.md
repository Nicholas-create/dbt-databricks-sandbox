# CLAUDE.md

## Who I am
Nicholas, moving from BI/FP&A into Analytics Engineering. This project is my portfolio piece, so I need to understand every change well enough to explain it in an interview.

## How I want to work
- **Before making each change, explain why**, not only what. The reasoning is the part I value most.
- When showing a convention or pattern, show a correct example next to a bad one.
- I prefer GUIs to the terminal. When I need to do something myself, say **where** it happens (which app, panel, menu).
- You edit files, commit and push to a feature branch. Never push to `main`; changes reach it only through a pull request.
- You may merge PRs yourself, but only after the branch builds locally, its checks pass, **and the `dbt CI` GitHub check is green** (`gh pr checks <n> --watch`). Put the build result and what you checked in the PR description.

## Running dbt
- **Locally:** dbt Core lives in the project's `.venv/`. Always call `.venv/bin/dbt` (or `source .venv/bin/activate` first). A bare `dbt` on this Mac is dbt Fusion, a different engine. Credentials come from `~/.dbt/profiles.yml` and environment variables, never from files in the repo.
- **dbt Studio:** every change must still build there, so push the branch and say if Studio's engine could behave differently from local dbt Core.

## Project
- dbt project `ai_model_tracker` on Databricks Free Edition: catalog `ai_model_tracker`, dev schema `dbt_nsampson`.
- Tracks which AI model is best at what (benchmarks from model release pages, with the project's own weighted Overall score), the model list, and what models cost (OpenRouter). No Epoch AI feed: its history was copied into the seeds on 20 Nov 2026 and is maintained there.

## When a model is released
New benchmark results come from the model's release page (the project's only benchmark source). Follow the runbook in [`ingestion/manual/README.md`](ingestion/manual/README.md): read the page, add the developer's results for its own models to the seed CSVs in `seeds/manual/`, write a release note in `ingestion/manual/releases/`, build, PR. The merge deploys. Never write benchmark data into a warehouse table by hand (`workspace.raw_manual` is retired).

## Rules
All project conventions are in [`CONVENTIONS.md`](CONVENTIONS.md). Read it before changing anything, and follow it. SQL follows dbt Labs' style guide (`CONVENTIONS.md` §7): run `.venv/bin/sqlfluff lint models tests macros` before pushing; the `sql lint` PR check runs the same.
