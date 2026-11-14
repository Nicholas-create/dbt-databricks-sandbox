-- Release batch: Gemma 4 (open weights), announced 2 Apr 2026
-- Source: https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/ (table is an
-- image, transcribed; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill. Gemma 4 31B IT, 26B A4B, E4B IT and E2B IT, all
-- "Thinking" (is_open_weights = true). Names as in our data where they exist.
--   * New: AIME 2026 (maths), LiveCodeBench v6 (in the livecodebench family).
-- Not entered: Arena AI (text) Elo (a live crowd leaderboard); Gemma 3 (older model).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('aime-2026', 'AIME 2026', 'maths', null, null, 'pct', 1,
     null, null,
     'American Invitational Mathematics Examination 2026, no tools.'),
    ('livecodebench-v6', 'LiveCodeBench v6', 'coding', null, null, 'pct', 1,
     'livecodebench', 'v6',
     'Competitive coding problems, LiveCodeBench release v6.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- mmmlu
    ('mmmlu', 'Gemma 4 31B IT', 85.2, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmlu', 'Gemma 4 26B A4B', 82.6, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmlu', 'Gemma 4 E4B IT', 69.4, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmlu', 'Gemma 4 E2B IT', 60.0, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemma 4 31B IT', 76.9, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmu-pro', 'Gemma 4 26B A4B', 73.8, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmu-pro', 'Gemma 4 E4B IT', 52.6, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('mmmu-pro', 'Gemma 4 E2B IT', 44.2, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    -- aime-2026
    ('aime-2026', 'Gemma 4 31B IT', 89.2, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('aime-2026', 'Gemma 4 26B A4B', 88.3, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('aime-2026', 'Gemma 4 E4B IT', 42.5, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('aime-2026', 'Gemma 4 E2B IT', 37.5, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    -- livecodebench-v6
    ('livecodebench-v6', 'Gemma 4 31B IT', 80.0, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('livecodebench-v6', 'Gemma 4 26B A4B', 77.1, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('livecodebench-v6', 'Gemma 4 E4B IT', 52.0, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('livecodebench-v6', 'Gemma 4 E2B IT', 44.0, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemma 4 31B IT', 84.3, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('gpqa-diamond', 'Gemma 4 26B A4B', 82.3, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('gpqa-diamond', 'Gemma 4 E4B IT', 58.6, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('gpqa-diamond', 'Gemma 4 E2B IT', 43.4, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    -- tau2-retail
    ('tau2-retail', 'Gemma 4 31B IT', 86.4, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('tau2-retail', 'Gemma 4 26B A4B', 85.5, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('tau2-retail', 'Gemma 4 E4B IT', 57.5, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null),
    ('tau2-retail', 'Gemma 4 E2B IT', 29.4, null, null, 'Google', true, date'2026-04-02', 'https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/', 'vendor_reported', null);
