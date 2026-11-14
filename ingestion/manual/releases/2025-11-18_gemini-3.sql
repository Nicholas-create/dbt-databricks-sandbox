-- Release batch: Gemini 3 Pro and Gemini 3 Deep Think, announced 18 Nov 2025
-- Source: https://blog.google/products-and-platforms/products/gemini/gemini-3/ (table and charts
-- are images, transcribed; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (one batch per page, page order; newest page wins).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Benchmark mapping:
--   * Humanity's Last Exam "no tools" / "with search and code execution" = hle-no-tools /
--     hle-with-tools. MRCR v2 (8-needle) here is Google's own set-up (128K average and 1M
--     pointwise), not OpenAI's buckets: new gdm-mrcr family (Long context).
--   * New: MathArena Apex, LiveCodeBench Pro (Elo, index), Vending-Bench 2 (net worth, $,
--     index), FACTS Benchmark Suite, Global PIQA.
-- Not entered: AIME "with code execution" (a tool set-up, as with OpenAI's python rows);
-- tau2-bench (domain not stated); Deep Think's ARC-AGI-2 (marked "tools on", not the standard
-- set-up); the Vending-Bench chart (no printed values).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, Gemini 3 Pro: 37.5 here; 37.5 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * hle-with-tools, Gemini 3 Pro: 45.8 here; 45.8 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * arc-agi-2, Gemini 3 Pro: 31.1 here; 31.1 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * gpqa-diamond, Gemini 3 Pro: 91.9 here; 91.9 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * mmmu-pro, Gemini 3 Pro: 81.0 here; 81.0 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * livecodebench-pro, Gemini 3 Pro: 2439 here; 2439 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * terminal-bench, Gemini 3 Pro: 54.2 here; 56.9 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * swe-bench-verified, Gemini 3 Pro: 76.2 here; 76.2 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * mmmlu, Gemini 3 Pro: 91.8 here; 91.8 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * gdm-mrcr-128k, Gemini 3 Pro: 77.0 here; 77.0 on https://deepmind.google/models/model-cards/gemini-3-1-pro/
--   * gdm-mrcr-1m, Gemini 3 Pro: 26.3 here; 26.3 on https://deepmind.google/models/model-cards/gemini-3-1-pro/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('matharena-apex', 'MathArena Apex', 'maths', null, null, 'pct', 1,
     null, null,
     'The hardest recent maths-competition problems.'),
    ('livecodebench-pro', 'LiveCodeBench Pro', 'coding', null, null, 'index', null,
     null, null,
     'Competitive programming (Codeforces, ICPC, IOI): Elo rating.'),
    ('vending-bench-2', 'Vending-Bench 2 (net worth)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', 'net worth',
     'Running a simulated vending business for a year: mean net worth in dollars.'),
    ('facts', 'FACTS Benchmark Suite', 'science', 'Google DeepMind', null, 'pct', 1,
     null, null,
     'Factuality across grounding, parametric knowledge, search and multimodal inputs.'),
    ('global-piqa', 'Global PIQA', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Commonsense reasoning across 100 languages and cultures.'),
    ('gdm-mrcr-128k', 'MRCR v2, Google (128K average)', 'long-context', 'Google DeepMind', null, 'pct', 1,
     'gdm-mrcr', '128K average',
     'Google\'s 8-needle MRCR v2 set-up, averaged up to 128K tokens.'),
    ('gdm-mrcr-1m', 'MRCR v2, Google (1M pointwise)', 'long-context', 'Google DeepMind', null, 'pct', 1,
     'gdm-mrcr', '1M pointwise',
     'Google\'s 8-needle MRCR v2 set-up at 1M tokens.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- aime-2025
    ('aime-2025', 'Gemini 3 Pro', 95.0, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- matharena-apex
    ('matharena-apex', 'Gemini 3 Pro', 23.4, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- screenspot-pro
    ('screenspot-pro', 'Gemini 3 Pro', 72.7, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3 Pro', 81.4, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- videommmu
    ('videommmu', 'Gemini 3 Pro', 87.6, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- vending-bench-2
    ('vending-bench-2', 'Gemini 3 Pro', 5478.16, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- facts
    ('facts', 'Gemini 3 Pro', 70.5, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- simpleqa-verified
    ('simpleqa-verified', 'Gemini 3 Pro', 72.1, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- global-piqa
    ('global-piqa', 'Gemini 3 Pro', 93.4, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Gemini 3 Deep Think', 41.0, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', 'Tools off (chart with printed values).'),
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemini 3 Deep Think', 93.8, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3/', 'vendor_reported', 'Tools off (chart with printed values).');
