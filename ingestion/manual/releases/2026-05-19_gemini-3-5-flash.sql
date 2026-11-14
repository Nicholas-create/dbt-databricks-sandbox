-- Release batch: Gemini 3.5 Flash, announced 19 May 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-5-flash/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.5 Flash, Gemini 3 Flash and
-- Gemini 3.1 Pro.
--   * Finance Agent v2 is not FinanceAgent v1.1 (GPT-5.5: 51.8% here vs 60.0% on OpenAI's page):
--     new financeagent-v2 in a financeagent family.
--   * Humanity's Last Exam (full set) has no tools note here; Google's HLE rows are no-tools
--     unless marked, so it's entered as hle-no-tools.
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Superseded by a later page (the newer value is entered there):
--   * terminal-bench-2-1, Gemini 3.5 Flash: 76.2 here; 76.2 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * terminal-bench-2-1, Gemini 3.1 Pro: 70.3 here; 73.8 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * swe-bench-pro, Gemini 3.5 Flash: 55.1 here; 55.1 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * swe-bench-pro, Gemini 3.1 Pro: 54.2 here; 54.2 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * osworld-verified, Gemini 3.5 Flash: 78.4 here; 78.4 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * osworld-verified, Gemini 3.1 Pro: 76.2 here; 76.2 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * charxiv-reasoning, Gemini 3.5 Flash: 84.2 here; 84.2 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * charxiv-reasoning, Gemini 3.1 Pro: 83.3 here; 83.3 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * gdm-mrcr-128k, Gemini 3.5 Flash: 77.3 here; 77.3 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * gdm-mrcr-128k, Gemini 3.1 Pro: 84.9 here; 84.9 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * gdm-mrcr-1m, Gemini 3.5 Flash: 26.6 here; 26.6 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * gdm-mrcr-1m, Gemini 3.1 Pro: 26.3 here; 26.3 on https://deepmind.google/models/model-cards/gemini-3-6-flash/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('financeagent-v2', 'Finance Agent v2', 'agents', 'Vals AI', null, 'pct', 1,
     'financeagent', 'v2',
     'Financial-analyst agent tasks, version 2.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Gemini 3 Flash', 58.0, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', 'Terminus-2 harness.'),
    -- swe-bench-pro
    ('swe-bench-pro', 'Gemini 3 Flash', 49.6, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'Gemini 3.5 Flash', 83.6, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('mcp-atlas', 'Gemini 3 Flash', 62.0, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('mcp-atlas', 'Gemini 3.1 Pro', 78.2, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'Gemini 3.5 Flash', 56.5, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('toolathlon', 'Gemini 3 Flash', 49.4, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- osworld-verified
    ('osworld-verified', 'Gemini 3 Flash', 65.1, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- financeagent-v2
    ('financeagent-v2', 'Gemini 3.5 Flash', 57.9, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('financeagent-v2', 'Gemini 3 Flash', 42.6, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('financeagent-v2', 'Gemini 3.1 Pro', 43.0, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3 Flash', 80.3, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemini 3.5 Flash', 83.6, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('mmmu-pro', 'Gemini 3 Flash', 81.2, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('mmmu-pro', 'Gemini 3.1 Pro', 80.5, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- blueprint-bench-2
    ('blueprint-bench-2', 'Gemini 3.5 Flash', 33.6, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('blueprint-bench-2', 'Gemini 3 Flash', 0.0, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('blueprint-bench-2', 'Gemini 3.1 Pro', 26.5, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemini 3 Flash', 67.2, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- gdm-mrcr-1m
    ('gdm-mrcr-1m', 'Gemini 3 Flash', 22.1, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Gemini 3.5 Flash', 40.2, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('hle-no-tools', 'Gemini 3 Flash', 33.7, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('hle-no-tools', 'Gemini 3.1 Pro', 44.4, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    -- arc-agi-2
    ('arc-agi-2', 'Gemini 3.5 Flash', 72.1, null, null, 'Google', false, date'2026-05-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('arc-agi-2', 'Gemini 3 Flash', 33.6, null, null, 'Google', false, date'2025-12-17', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null),
    ('arc-agi-2', 'Gemini 3.1 Pro', 77.1, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-5-flash/', 'vendor_reported', null);
