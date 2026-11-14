-- Release batch: Gemini 3.6 Flash, announced 21 Jul 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-6-flash/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.6 Flash, 3.5 Flash and 3.1
-- Pro. Same day as the 3.5 Flash-Lite card; ordered after it.
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Superseded by a later page (the newer value is entered there):
--   * deepswe, Gemini 3.6 Flash: 49 here; 48.6 on https://deepmind.google/models/model-cards/gemini-3-7-flash/
--   * terminal-bench-2-1, Gemini 3.6 Flash: 78.0 here; 78.0 on https://deepmind.google/models/model-cards/gemini-3-7-flash/
--   * charxiv-reasoning, Gemini 3.6 Flash: 85.2 here; 85.2 on https://deepmind.google/models/model-cards/gemini-3-7-flash/
--   * charxiv-reasoning-python, Gemini 3.6 Flash: 89.4 here; 89.4 on https://deepmind.google/models/model-cards/gemini-3-7-flash/
--   * gdm-mrcr-128k, Gemini 3.6 Flash: 91.8 here; 91.8 on https://deepmind.google/models/model-cards/gemini-3-7-flash/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'Gemini 3.6 Flash', 58.7, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('swe-bench-pro', 'Gemini 3.5 Flash', 55.1, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('swe-bench-pro', 'Gemini 3.1 Pro', 54.2, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'Gemini 3.5 Flash', 37, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'Gemini 3.1 Pro', 12, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'DeepSWE v1.1.'),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Gemini 3.5 Flash', 76.2, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'Terminus-2 harness.'),
    ('terminal-bench-2-1', 'Gemini 3.1 Pro', 73.8, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'Terminus-2 harness.'),
    -- mle-bench
    ('mle-bench', 'Gemini 3.6 Flash', 63.9, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('mle-bench', 'Gemini 3.5 Flash', 49.7, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('mle-bench', 'Gemini 3.1 Pro', 42.6, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    -- osworld-verified
    ('osworld-verified', 'Gemini 3.6 Flash', 83.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('osworld-verified', 'Gemini 3.5 Flash', 78.4, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('osworld-verified', 'Gemini 3.1 Pro', 76.2, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3.5 Flash', 84.2, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('charxiv-reasoning', 'Gemini 3.1 Pro', 83.3, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    -- charxiv-reasoning-python
    ('charxiv-reasoning-python', 'Gemini 3.5 Flash', 84.9, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'With tools.'),
    ('charxiv-reasoning-python', 'Gemini 3.1 Pro', 83.2, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', 'With tools.'),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemini 3.5 Flash', 77.3, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('gdm-mrcr-128k', 'Gemini 3.1 Pro', 84.9, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    -- gdm-mrcr-1m
    ('gdm-mrcr-1m', 'Gemini 3.6 Flash', 54.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('gdm-mrcr-1m', 'Gemini 3.5 Flash', 26.6, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null),
    ('gdm-mrcr-1m', 'Gemini 3.1 Pro', 26.3, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-6-flash/', 'vendor_reported', null);
