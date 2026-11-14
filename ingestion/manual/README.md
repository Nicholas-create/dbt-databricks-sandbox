# Manual benchmark data

Since 14 Nov 2026 every new benchmark result comes from a **model's release page**, not from Epoch AI. Epoch's hub was loaded once as the historical baseline (`raw_epoch.benchmark_rows`). Results typed in here supersede that baseline for the same benchmark and model.

| File | What it is |
|---|---|
| `create_manual_tables.sql` | Creates `workspace.raw_manual.benchmarks` and `benchmark_scores` (run once; safe to re-run) |
| `add_benchmark_score.sql` | Fill-in templates for a single score, a new benchmark, or a retraction |
| `releases/<date>_<model or change>.sql` | One batch per model release (or definition change): exactly what was entered, from which page, and what was left out and why |

## The tables are append-only

Never `UPDATE` or `DELETE`. The latest row per key is the current value, so the history of every entry stays visible.

✅ Fix a typo: insert the row again with the right score.
❌ `UPDATE raw_manual.benchmark_scores SET score = 46.0 WHERE …`: the wrong value and when it was published are gone.

✅ Withdraw a score: insert the same benchmark and model with `is_retracted = true`. Epoch's baseline score, if there is one, shows again.
❌ `DELETE FROM raw_manual.benchmark_scores WHERE …`

## Adding a model release (the runbook)

Done by Claude Code when Nicholas says a model is out (with the release page URL), on a branch `data/<model>`.

1. **Read the release page** in full: the benchmark table, its footnotes (effort, safeguards, harness) and the release date. Prefer the developer's own announcement; note the URL.
2. **Decide what to enter.**
   - A developer's numbers **for its own models** only (`source_type = 'vendor_reported'`), including its older models if the table shows them. Competitors' columns come from the competitors' own pages.
   - `independent` is for results published by a benchmark's maintainer (a public leaderboard).
   - Never Artificial Analysis benchmarks (licence; CONVENTIONS.md §8).
   - **Every benchmark on the page**, even when Epoch already has that model and benchmark: the database stands on its own, and a manual row supersedes Epoch's.
   - Skip cells the page doesn't label clearly, and say so in the batch file. A combined column (e.g. "Mythos 5 / Fable 5", showing the higher of two models) is only usable where the page says whose score a cell is.
   - Only published numbers. A chart counts when the page ships its exact values (OpenAI's pages embed each chart's data): take the value printed on the bar (stacked bars: the label, not one segment) and, for effort curves, each model's best score with its effort recorded. When a page has a table and a chart for the same result, use the table. A chart with no values anywhere is skipped (a value read off a plotted line is a guess).
   - When the announcement's table is an image and the developer publishes the same evaluation as text (Google's DeepMind model cards, DeepSeek's Hugging Face model cards), enter from the text version and say so in the batch header; transcribe images only when there's no text version.
   - One score per model: when a page reports several modes or efforts for one model (thinking / non-thinking, High / Max), enter the best and record the mode or effort. Base-model (pre-trained, few-shot) tables aren't entered: they're not the released model and their numbers aren't comparable with chat models'.
   - Rows run by Artificial Analysis count as Artificial Analysis data even inside another developer's table ("Terminal-Bench 4.0 (AA)", "AutomationBench-AA"): not entered. Neither are third-party composites (AA Index, Vals Index) or live leaderboard snapshots (Arena Elo).
   - Not capability benchmarks: safety and alignment rates, "lower is better" metrics (hallucination rate, edit distance), Artificial Analysis indices.
   - **A developer's internal evaluations** (labelled "internal", or only ever scored on its own models) go in with category `internal`: kept in the database, not shown on the site (`is_on_site = false` in `seeds/benchmark_categories.csv`), because they can't rank models across labs.
   - **Newest page wins.** Later pages often revise earlier numbers (new grader, re-run harness). Enter each score from the newest page that reports it and list older published values in the batch header; never insert an older page's value after a newer one, because the latest row is the current value.
3. **Map each benchmark** to an existing `benchmark_id` (`select benchmark_id, benchmark_name, category from workspace.analytics.dim_benchmarks`).
   - Same benchmark only if it's the same test and setup. A different version or "with tools" is a new benchmark: compare a shared model's score against ours before deciding.
   - A new version or variant of an existing benchmark gets its own `benchmark_id` **and** the existing one's `benchmark_family`, plus a short `variant_label` (e.g. `2.0`, `with tools`). The site then shows both as one split pill, each with its own results: the first segment shows the full benchmark name, the rest their variant label ("Terminal-Bench | 2.1 | 4.0"). Segments follow the order the definitions were last entered, so insert one definition per statement (file order = pill order); when a family gains versions across several pages, enter the whole family again, in order, in a final definitions file dated after the pages (e.g. `2026-11-14_openai-definitions.sql`). If the existing benchmark has no family yet, give it one (seed `benchmark_catalog` for Epoch benchmarks, a new definition row for manual ones).
   - A new benchmark gets a `raw_manual.benchmarks` row. Category must exist in `seeds/benchmark_categories.csv`. If none fits, Claude may add one (agreed 14 Nov 2026): a seed row, plus an emblem shape in `site/emblem.js` (otherwise the tab shows the globe), then check the header still fits.
4. **Spell model names** exactly as existing rows do (`select distinct model_name from workspace.analytics.fct_benchmark_scores where model_name ilike '%fable%'`). New models follow the developer's official name, e.g. `Claude Fable 5.2`.
5. **Fill every model detail** on new models: `lab`, `released_date`, `is_open_weights` (the test `assert_manual_scores_have_model_details` fails without lab and date). Scores exactly as published: `49.1` for 49.1%.
6. **Write the batch file** `releases/<release date>_<model>.sql` (header: source URL, date entered, what was skipped and why), then run it against Databricks (SQL Editor, or the CLI with the `ai-model-tracker` profile and `--file`, one statement per call).
   - **Escape apostrophes with a backslash.** Databricks (Spark) SQL reads `''` as two string literals glued together, silently dropping the apostrophe:
     ✅ `'Humanity\'s Last Exam'` → Humanity's Last Exam
     ❌ `'Humanity''s Last Exam'` → Humanitys Last Exam (no error)
7. **Build and check:** `.venv/bin/dbt build` in dev, then spot-check two scores in `fct_benchmark_scores` against the page, and preview the site (`scripts/export_site_data.py --schema dbt_nsampson`, then `python3 -m http.server 8766 -d site`).
8. **Ship:** commit the batch file (plus any dbt change), open a PR with the build result and spot checks, wait for the green `dbt CI` check, merge. The merge starts **dbt production build** and then **Publish site** on its own (GitHub → **Actions** shows both runs); when both are green, check the live page.

Note: the raw tables are shared by dev, CI and prod, so the data is live in Databricks as soon as step 6 runs; any production build before the merge (the daily one at 07:17 UTC, or another PR's merge) would publish it even before this PR merges. The PR is the review record of what was entered.

## Doing it by hand

Databricks → **SQL Editor** (left sidebar) → paste a block from `add_benchmark_score.sql` → fill it in → **Run**. Bad values are rejected straight away: `unit` and `source_type` must be one of the allowed words, and a score can't be negative.
