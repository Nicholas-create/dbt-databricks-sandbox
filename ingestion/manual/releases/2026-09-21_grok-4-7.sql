-- Release batch: Grok 4.7, announced 21 Sep 2026
-- Source: https://x.ai/news/grok-4-7 (table rendered on the page; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill (newest page wins). Grok 4.7 at xhigh (DeepSWE at high,
-- asterisked) and Grok 4.6 at high.
--   * New: EEBench (electrical engineering; coding, next to BenchCAD).
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
-- Also not entered: LatchBio biosafety and HackerBench v0.3 (safety measures); the CursorBench
-- cost chart (no printed values).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('eebench', 'EEBench', 'coding', null, null, 'pct', 1,
     null, null,
     'Electrical-engineering design tasks.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- cursorbench
    ('cursorbench', 'Grok 4.7', 46.3, null, null, 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'CursorBench 4.0.'),
    ('cursorbench', 'Grok 4.6', 40.4, null, null, 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'CursorBench 4.0.'),
    -- deepswe
    ('deepswe', 'Grok 4.7', 71.0, null, 'high', 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'Grok 4.6', 65.2, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'DeepSWE v1.1.'),
    -- eebench
    ('eebench', 'Grok 4.7', 64.0, null, null, 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', null),
    ('eebench', 'Grok 4.6', 53.0, null, null, 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'Grok 4.7', 37.6, null, null, 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', null),
    ('terminal-bench-4', 'Grok 4.6', 20.3, null, null, 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', null),
    -- legal-agent-benchmark-allpass
    ('legal-agent-benchmark-allpass', 'Grok 4.7', 19.6, null, null, 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'Harvey Legal Agent Benchmark.'),
    ('legal-agent-benchmark-allpass', 'Grok 4.6', 15.8, null, null, 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', 'Harvey Legal Agent Benchmark.'),
    -- healthbench-professional
    ('healthbench-professional', 'Grok 4.7', 56.7, null, null, 'xAI', false, date'2026-09-21', 'https://x.ai/news/grok-4-7', 'vendor_reported', null),
    ('healthbench-professional', 'Grok 4.6', 48.5, null, null, 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-7', 'vendor_reported', null);
