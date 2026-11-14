-- Templates for adding benchmark data by hand.
-- Where: Databricks → SQL Editor (left sidebar) → paste one block → fill it in → Run.
-- The site picks it up after the next production build (daily 07:30 UTC), or now via
-- GitHub → Actions → "dbt production build" → Run workflow.
--
-- Rules (CONVENTIONS.md section 1, "Manually curated sources"):
--   * never UPDATE or DELETE. To fix a value, insert the row again with the right value:
--     the newest row for a benchmark and model wins.
--   * to withdraw a score, insert the same benchmark and model with is_retracted = true
--     (Epoch's score, if it has one, shows again).
--   * model_name must be spelled as Epoch spells it (check epoch.ai/benchmarks), e.g.
--     'Claude Fable 5.2', so the score lands on the same row as Epoch's results.

-- ── 1. A score on an existing benchmark ──────────────────────────────────────
-- Benchmark ids: the benchmark_id column of workspace.analytics.dim_benchmarks
insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values (
    'frontierswe',              -- benchmark_id
    'Claude Fable 5.2',         -- model_name, spelled as Epoch spells it
    69.9,                       -- score exactly as published: 69.9 for 69.9%
    null,                       -- harness, e.g. 'claude-code' (or null)
    null,                       -- effort, e.g. 'xhigh' (or null)
    'Anthropic',                -- lab (null = take it from Epoch)
    false,                      -- is_open_weights (null = take it from Epoch)
    date'2026-11-09',           -- released_date (null = take it from Epoch)
    'https://www.anthropic.com/claude-fable-and-mythos-5-2',   -- where it was published
    'vendor_reported',          -- 'vendor_reported' (the lab about its own model) or 'independent'
    null                        -- notes
);

-- ── 2. A benchmark Epoch doesn't carry (define it once, before its scores) ──────
insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max, notes)
values (
    'automationbench',          -- benchmark_id: lowercase, hyphens, unique
    'AutomationBench',          -- name shown on the site
    'agents',                   -- overall, coding, writing, maths, science, reasoning, agents
    null,                       -- publisher
    null,                       -- benchmark home page
    'pct',                      -- 'pct' (scores entered as 0-100), 'points', or 'index'
    1,                          -- top of the scale in site units: 1 for pct
    null                        -- notes
);

-- ── 3. Withdraw a score ─────────────────────────────────────────────────────
insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, source_url, source_type, is_retracted, notes)
values ('frontierswe', 'Claude Fable 5.2', 0, 'https://…', 'vendor_reported', true, 'why it was withdrawn');
