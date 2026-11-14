-- Release batch: Gemini 3.5 Flash-Lite, announced 21 Jul 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.5 Flash-Lite and 3.1
-- Flash-Lite. CharXiv "With tools" = CharXiv Reasoning (with Python).
--   * New: MLE-Bench (coding).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- The announcement post (3.6 Flash, 3.5 Flash-Lite and 3.5 Flash Cyber) points to the cards.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mle-bench', 'MLE-Bench', 'coding', null, null, 'pct', 1,
     null, null,
     'Machine-learning engineering competitions.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'Gemini 3.5 Flash-Lite', 54.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('swe-bench-pro', 'Gemini 3.1 Flash-Lite', 38.3, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Gemini 3.5 Flash-Lite', 54.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', 'Terminus-2 harness.'),
    ('terminal-bench-2-1', 'Gemini 3.1 Flash-Lite', 31.0, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', 'Terminus-2 harness.'),
    -- mle-bench
    ('mle-bench', 'Gemini 3.5 Flash-Lite', 39.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('mle-bench', 'Gemini 3.1 Flash-Lite', 22.0, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    -- osworld-verified
    ('osworld-verified', 'Gemini 3.5 Flash-Lite', 74.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('osworld-verified', 'Gemini 3.1 Flash-Lite', 54.3, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3.5 Flash-Lite', 74.5, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('charxiv-reasoning', 'Gemini 3.1 Flash-Lite', 73.2, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    -- charxiv-reasoning-python
    ('charxiv-reasoning-python', 'Gemini 3.5 Flash-Lite', 76.5, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', 'With tools.'),
    ('charxiv-reasoning-python', 'Gemini 3.1 Flash-Lite', 75.6, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', 'With tools.'),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemini 3.5 Flash-Lite', 72.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('gdm-mrcr-128k', 'Gemini 3.1 Flash-Lite', 60.1, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    -- gdm-mrcr-1m
    ('gdm-mrcr-1m', 'Gemini 3.5 Flash-Lite', 21.3, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null),
    ('gdm-mrcr-1m', 'Gemini 3.1 Flash-Lite', 12.3, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/', 'vendor_reported', null);
