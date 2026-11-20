# Manual benchmark data

Every benchmark result comes from a **model's release page**. The project has no other feed: the history it started from (Epoch AI's hub, CC BY 4.0) was copied into these seeds once on 20 Nov 2026 and is maintained here like any other row. Every result counts in the Overall score as soon as its PR merges.

The data itself lives in Git, as three dbt seeds. This folder holds the runbook and one release note per release.

| File | What it is |
|---|---|
| [`seeds/manual/manual_benchmarks.csv`](../../seeds/manual/manual_benchmarks.csv) | Every benchmark: one row per `benchmark_id`, with its category, scale and `released_date` (which sets its weight in the Overall) |
| [`seeds/manual/manual_benchmark_scores.csv`](../../seeds/manual/manual_benchmark_scores.csv) | Every result: one row per benchmark and model, sorted by `benchmark_id`, then model name |
| [`seeds/manual/manual_models.csv`](../../seeds/manual/manual_models.csv) | The model list: one row per model, so the model gets a row in `dim_models` and its OpenRouter price. Sorted by `model_name` |
| [`seeds/manual/_manual__seeds.yml`](../../seeds/manual/_manual__seeds.yml) | What each column means, its type, and the tests that stop bad values |
| `releases/<date>_<model>.md` | One release note per model release: the page and date read, what was entered, what was skipped and why, older values a newer page replaced |

## The CSVs hold the current state; Git holds the history

Each seed holds only what is true now. A correction is an edited line, a withdrawal a deleted line, and the pull request that makes the change is the review. Git keeps every earlier version, who changed it and why.

✅ Fix a typo: edit the score on its line in `manual_benchmark_scores.csv`, in a PR.
❌ Type the fix straight into a warehouse table: nobody reviews it, and it's live in every environment at once.

✅ Withdraw a score: delete its line in a PR.
❌ Keep the line and add a "retracted" flag: the seed only describes the present; the history is in Git.

The old warehouse tables `workspace.raw_manual.benchmarks` and `benchmark_scores` are retired: nothing reads them any more, and they are kept untouched for reference. They stay in the old shared `workspace` catalog and were not moved to `ai_model_tracker` (15 Nov 2026).

## Adding a model release (the runbook)

Done by Claude Code when Nicholas says a model is out (with the release page URL), on a branch `data/<model>`.

1. **Read the release page** in full: the benchmark table, its footnotes (effort, safeguards, harness) and the release date. Prefer the developer's own announcement; note the URL.
2. **Decide what to enter.**
   - A developer's numbers **for its own models** only (`source_type = vendor_reported`), including its older models if the table shows them. Competitors' columns come from the competitors' own pages.
   - `independent` is for results published by a benchmark's maintainer (a public leaderboard).
   - Never Artificial Analysis benchmarks (licence; CONVENTIONS.md §9).
   - **Every benchmark on the page.** If the CSV already has that model and benchmark (e.g. from the copied history, `source_url` https://epoch.ai/benchmarks), the release page's value replaces the line; list the old value in the release note.
   - Skip cells the page doesn't label clearly, and say so in the release note. A combined column (e.g. "Mythos 5 / Fable 5", showing the higher of two models) is only usable where the page says whose score a cell is.
   - Only published numbers. A chart counts when the page ships its exact values (OpenAI's pages embed each chart's data): take the value printed on the bar (stacked bars: the label, not one segment) and, for effort curves, each model's best score with its effort recorded. When a page has a table and a chart for the same result, use the table. A chart with no values anywhere is skipped (a value read off a plotted line is a guess).
   - When the announcement's table is an image and the developer publishes the same evaluation as text (Google's DeepMind model cards, DeepSeek's Hugging Face model cards), enter from the text version and say so in the release note; transcribe images only when there's no text version.
   - One score per model: when a page reports several modes or efforts for one model (thinking / non-thinking, High / Max), enter the best and record the mode or effort. Base-model (pre-trained, few-shot) tables aren't entered: they're not the released model and their numbers aren't comparable with chat models'.
   - Rows run by Artificial Analysis count as Artificial Analysis data even inside another developer's table ("Terminal-Bench 4.0 (AA)", "AutomationBench-AA"): not entered. Neither are third-party composites (AA Index, Vals Index) or live leaderboard snapshots (Arena Elo).
   - Not capability benchmarks: safety and alignment rates, "lower is better" metrics (hallucination rate, edit distance), Artificial Analysis indices.
   - **A developer's internal evaluations** (labelled "internal", or only ever scored on its own models) go in with category `internal`: kept in the database, not shown on the site (`is_on_site = false` in `seeds/benchmark_categories.csv`), because they can't rank models across labs. Examples: Anthropic's CVE Rediscovery ("our internal evaluation" on the Fable 5.2 page), OpenAI's capture-the-flag challenges (labelled "Internal" on the GPT-5.5 page).
   - **Newest page wins.** Later pages often revise earlier numbers (new grader, re-run harness). The CSV keeps the value from the newest page that reports it; list the older published values in the release note. Never replace a newer page's value with an older one.
3. **Map each benchmark** to an existing `benchmark_id` (search `manual_benchmarks.csv`, or `select benchmark_id, benchmark_name, category from ai_model_tracker.analytics.dim_benchmarks`).
   - Same benchmark only if it's the same test and setup. A different version or "with tools" is a new benchmark: compare a shared model's score against ours before deciding.
   - A new version or variant of an existing benchmark gets its own `benchmark_id` **and** the existing one's `benchmark_family`, plus a short `variant_label` (e.g. `2.0`, `with tools`). The site then shows both as one split pill, each with its own results: the first segment shows the full benchmark name, the rest their variant label ("Terminal-Bench | 2.1 | 4.0"). Segments follow `sort_order`, lowest first: give the new row a number between its neighbours (they go up in steps of 10, so there is room), or the next free number at the end. Versions go oldest first, and a version without tools comes before its with-tools variant (Humanity's Last Exam, Chartography). If the existing benchmark has no family yet, give it one on its row. Versions in one family share one benchmark's weight in the Overall, so linking them also stops a benchmark published in five variants from counting five times.
   - A new benchmark gets a row in `manual_benchmarks.csv`, with a **`released_date`** (required): when the benchmark (this version) was first published, from its paper, announcement or leaderboard launch. If you can't find one, use the date of the release page you're entering. It sets the benchmark's weight in the Overall (newer counts more; half-life 1.5 years), so a wrong year matters more than a wrong day. Category must exist in `seeds/benchmark_categories.csv`. If none fits, Claude may add one (agreed 14 Nov 2026): a seed row, plus an emblem shape in `site/emblem.js` (otherwise the tab shows the globe), then check the header still fits. Example: Long context was split from Reasoning because OpenAI's pages give those benchmarks their own section, and eight MRCR context lengths had taken over the Reasoning tab.
4. **Spell model names** exactly as existing rows do (search `manual_benchmark_scores.csv`, or `select distinct model_name from ai_model_tracker.analytics.fct_benchmark_scores where model_name ilike '%fable%'`). New models follow the developer's official name, e.g. `Claude Fable 5.2`.
5. **Fill every model detail** on every row: `lab`, `released_date` (YYYY-MM-DD), `is_open_weights` (`true` / `false`). The build fails without lab and date (`not_null` tests on the seed). Scores exactly as published: `49.1` for 49.1%.
   - **Add the model to the model list if it's new.** Check `select model_name from ai_model_tracker.analytics.dim_models where model_name = '<name>'`. No row: add a line to `seeds/manual/manual_models.csv` (same name; organisation, country and access category spelled as existing rows spell them, e.g. `Google DeepMind`, `Open weights (unrestricted)`; release date; release page). That gives it a row in `dim_models` and, once OpenRouter lists it, a price on the site and dashboard. If OpenRouter names it differently (e.g. `Beam 1.0 501B A23B`), add the pairing to `seeds/model_match_overrides.csv`.
6. **Edit the seeds and write the release note.**
   - Add or change rows in the two CSVs. Keep `manual_benchmark_scores.csv` sorted by `benchmark_id`, then model name, so a duplicate sits next to its twin. Leave a field empty for "no value".
   - Write `releases/<release date>_<model>.md`: the source URL and date read, what was entered, what was skipped and why, and any older values this page replaced.
7. **Build and check:** `.venv/bin/dbt build` in dev (it loads the seeds into your dev schema), then spot-check two scores in `dbt_nsampson.fct_benchmark_scores` against the page, check the model is in the Overall (`select * from dbt_nsampson.fct_benchmark_category_scores where category = 'overall' and model_name = '<name>'`; it needs 3 results in at least 2 categories, on benchmarks at least one other model has also sat), and preview the site (`scripts/export_site_data.py --schema dbt_nsampson`, then `python3 -m http.server 8766 -d site`).
8. **Ship:** commit the CSVs and the release note (plus any dbt change), open a PR with the build result and spot checks, wait for the green `dbt CI` check (CI loads the PR's own copy of the seeds), merge. The merge starts **dbt production build** and then **Publish site** on its own (GitHub → **Actions** shows both runs); when both are green, check the live page. Nothing reaches production before the merge.

## Doing it by hand

On GitHub, in the browser:

1. Open the repo → `seeds` → `manual` → the CSV to change. GitHub shows it as a table; click the **pencil** icon (top right of the file) to edit it as text.
2. Change or add the line. Commas separate fields; a field that contains a comma or a quote goes inside double quotes, with any quote inside it doubled (`"Visual chart recognition, no tools."`).
3. Click **Commit changes…**, choose **Create a new branch for this commit and start a pull request**, then **Propose changes** and **Create pull request**.
4. Wait for the green **dbt CI** check on the PR (it fails on an unknown `unit` or `source_type`, a negative score, a missing lab or release date, or a duplicate benchmark and model), then merge.
