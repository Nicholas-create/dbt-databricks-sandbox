-- Release batch: Gemini 3 Deep Think update ("Feb 2026"), announced 12 Feb 2026
-- Source: https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/
-- (table is an image, transcribed; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). The updated model is named as in our
-- data, "Gemini 3 Deep Think (2/26)"; the original is "Gemini 3 Deep Think". The "Gemini 3 Pro
-- Preview" column is Gemini 3 Pro.
--   * New: International Math Olympiad 2025, Codeforces (Elo, index), International Physics and
--     Chemistry Olympiad 2025 (theory), CMT-Benchmark (condensed matter theory).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- The Dec 2025 "Deep Think is now available" post has no benchmark results.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('imo-2025', 'IMO 2025', 'maths', null, null, 'pct', 1,
     null, null,
     'International Mathematical Olympiad 2025 problems.'),
    ('codeforces', 'Codeforces', 'coding', null, null, 'index', null,
     null, null,
     'Competitive programming, no tools: Elo rating.'),
    ('ipho-2025', 'IPhO 2025 (theory)', 'science', null, null, 'pct', 1,
     null, null,
     'International Physics Olympiad 2025, theory problems.'),
    ('icho-2025', 'IChO 2025 (theory)', 'science', null, null, 'pct', 1,
     null, null,
     'International Chemistry Olympiad 2025, theory problems.'),
    ('cmt-benchmark', 'CMT-Benchmark', 'science', null, null, 'pct', 1,
     null, null,
     'Condensed matter theory problems.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- imo-2025
    ('imo-2025', 'Gemini 3 Deep Think (2/26)', 81.5, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    ('imo-2025', 'Gemini 3 Pro', 14.3, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'Gemini 3 Deep Think (2/26)', 3455, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    ('codeforces', 'Gemini 3 Pro', 2512, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- ipho-2025
    ('ipho-2025', 'Gemini 3 Deep Think (2/26)', 87.7, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    ('ipho-2025', 'Gemini 3 Pro', 76.3, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- cmt-benchmark
    ('cmt-benchmark', 'Gemini 3 Deep Think (2/26)', 50.5, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    ('cmt-benchmark', 'Gemini 3 Pro', 39.5, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- icho-2025
    ('icho-2025', 'Gemini 3 Deep Think (2/26)', 82.8, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    ('icho-2025', 'Gemini 3 Pro', 69.6, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- arc-agi-2
    ('arc-agi-2', 'Gemini 3 Deep Think (2/26)', 84.6, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Gemini 3 Deep Think (2/26)', 48.4, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemini 3 Deep Think (2/26)', 81.5, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Gemini 3 Deep Think (2/26)', 53.4, null, null, 'Google', false, date'2026-02-12', 'https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-deep-think/', 'vendor_reported', 'Search and code execution.');
