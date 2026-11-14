-- Release batch: Gemini 3.1 Flash-Lite, announced 3 Mar 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.1 Flash-Lite (High) only:
-- the other Google columns are Gemini 2.5 models.
--   * New: LiveCodeBench, problems from Jan to May 2025 (family livecodebench).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Superseded by a later page (the newer value is entered there):
--   * charxiv-reasoning, Gemini 3.1 Flash-Lite: 73.2 here; 73.2 on https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/
--   * gdm-mrcr-128k, Gemini 3.1 Flash-Lite: 60.1 here; 60.1 on https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/
--   * gdm-mrcr-1m, Gemini 3.1 Flash-Lite: 12.3 here; 12.3 on https://deepmind.google/models/model-cards/gemini-3-5-flash-lite/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('livecodebench-2025', 'LiveCodeBench (Jan–May 2025)', 'coding', null, null, 'pct', 1,
     'livecodebench', 'Jan–May 2025',
     'Code generation, problems published 1 Jan to 1 May 2025.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- hle-no-tools
    ('hle-no-tools', 'Gemini 3.1 Flash-Lite', 16.0, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemini 3.1 Flash-Lite', 86.9, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemini 3.1 Flash-Lite', 76.8, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- videommmu
    ('videommmu', 'Gemini 3.1 Flash-Lite', 84.8, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- simpleqa-verified
    ('simpleqa-verified', 'Gemini 3.1 Flash-Lite', 43.3, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- facts
    ('facts', 'Gemini 3.1 Flash-Lite', 40.6, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- mmmlu
    ('mmmlu', 'Gemini 3.1 Flash-Lite', 88.9, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null),
    -- livecodebench-2025
    ('livecodebench-2025', 'Gemini 3.1 Flash-Lite', 72.0, null, null, 'Google', false, date'2026-03-03', 'https://deepmind.google/models/model-cards/gemini-3-1-flash-lite/', 'vendor_reported', null);
