-- Release batch: Gemini 3.8 Flash, announced 2 Sep 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-8-flash/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.8 Flash and 3.7 Flash.
--   * Harvey's Legal Agent Benchmark "all pass rate": Claude Opus 5 6.7% here vs 11.7% on
--     Anthropic's page, so a separate variant (legal-agent-benchmark-allpass).
--   * BioMysteryBench "Human Solvable / Human Difficult" = human solved / hard (Opus 5 90.1% /
--     49.4% on both pages).
--   * LVBench: the static result (87.1%) is entered; the agentic run (87.8%) is in the notes.
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- 3.8 Flash Cyber is limited to vetted defenders and has no published table.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('legal-agent-benchmark-allpass', 'Legal Agent Benchmark (all pass rate)', 'agents', 'Harvey', null, 'pct', 1,
     'legal-agent-benchmark', 'all pass rate',
     'Harvey\'s Legal Agent Benchmark: share of tasks with every check passed.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- deepswe
    ('deepswe', 'Gemini 3.8 Flash', 73.7, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'Gemini 3.7 Flash', 65.3, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'DeepSWE v1.1.'),
    -- financeagent-v2
    ('financeagent-v2', 'Gemini 3.8 Flash', 61.4, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('financeagent-v2', 'Gemini 3.7 Flash', 59.0, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- legal-agent-benchmark-allpass
    ('legal-agent-benchmark-allpass', 'Gemini 3.8 Flash', 10.0, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('legal-agent-benchmark-allpass', 'Gemini 3.7 Flash', 8.8, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Gemini 3.8 Flash', 89.4, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('terminal-bench-2-1', 'Gemini 3.7 Flash', 85.8, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'Gemini 3.8 Flash', 19.1, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('terminal-bench-4', 'Gemini 3.7 Flash', 11.2, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- gdp-pdf
    ('gdp-pdf', 'Gemini 3.8 Flash', 35.0, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'All pass rate.'),
    ('gdp-pdf', 'Gemini 3.7 Flash', 34.0, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'All pass rate.'),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3.8 Flash', 86.2, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('charxiv-reasoning', 'Gemini 3.7 Flash', 84.5, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- lvbench
    ('lvbench', 'Gemini 3.8 Flash', 87.1, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('lvbench', 'Gemini 3.7 Flash', 85.4, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- hle-verified
    ('hle-verified', 'Gemini 3.8 Flash', 54.9, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('hle-verified', 'Gemini 3.7 Flash', 53.6, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- osworld-2-0
    ('osworld-2-0', 'Gemini 3.8 Flash', 59.0, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'Partial score, batch tool enabled.'),
    ('osworld-2-0', 'Gemini 3.7 Flash', 50.6, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', 'Partial score, batch tool enabled.'),
    -- biomysterybench-human-solved
    ('biomysterybench-human-solved', 'Gemini 3.8 Flash', 88.8, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('biomysterybench-human-solved', 'Gemini 3.7 Flash', 87.1, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- biomysterybench-hard
    ('biomysterybench-hard', 'Gemini 3.8 Flash', 56.5, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('biomysterybench-hard', 'Gemini 3.7 Flash', 43.5, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    -- labbench2
    ('labbench2', 'Gemini 3.8 Flash', 86.2, null, null, 'Google', false, date'2026-09-02', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null),
    ('labbench2', 'Gemini 3.7 Flash', 82.1, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-8-flash/', 'vendor_reported', null);
