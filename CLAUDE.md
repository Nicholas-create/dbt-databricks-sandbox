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
- dbt project `ai_model_tracker` on Databricks Free Edition: catalog `workspace`, dev schema `dbt_nsampson`.
- Tracks which AI model is best at what (benchmarks: Epoch AI baseline + model release pages), what models are (Epoch AI) and what they cost (OpenRouter).

## When a model is released
New benchmark results come from the model's release page, not from Epoch (Epoch was a one-off baseline). Follow the runbook in [`ingestion/manual/README.md`](ingestion/manual/README.md): read the page, enter the developer's results for its own models as a batch file in `ingestion/manual/releases/`, build, PR, deploy.

## Rules
All project conventions are in [`CONVENTIONS.md`](CONVENTIONS.md). Read it before changing anything, and follow it.
