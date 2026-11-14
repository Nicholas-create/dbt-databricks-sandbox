-- Release batch: Gemma 4 12B (open weights), announced 3 Jun 2026
-- Source: https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/
-- (bar chart with printed values for Gemma 4 12B only; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill. Gemma 4 12B only (the 26B and Gemma 3 bars carry no
-- printed values).
--   * New: BBEH (BIG-Bench Extra Hard), MMLU-Pro, DocVQA, InfoVQA.
-- Not entered: LiveCodeBench (version not stated).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('bbeh', 'BIG-Bench Extra Hard', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Hard reasoning tasks (BBEH).'),
    ('mmlu-pro', 'MMLU-Pro', 'science', null, null, 'pct', 1,
     null, null,
     'Harder multiple-choice knowledge questions across subjects.'),
    ('docvqa', 'DocVQA', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Questions about document images.'),
    ('infovqa', 'InfoVQA', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Questions about infographics.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemma 4 12B', 78.8, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- bbeh
    ('bbeh', 'Gemma 4 12B', 53, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- mmlu-pro
    ('mmlu-pro', 'Gemma 4 12B', 77.2, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- docvqa
    ('docvqa', 'Gemma 4 12B', 94.9, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- infovqa
    ('infovqa', 'Gemma 4 12B', 88.4, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemma 4 12B', 69.1, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemma 4 12B', 43.4, null, null, 'Google', true, date'2026-06-03', 'https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/', 'vendor_reported', null);
