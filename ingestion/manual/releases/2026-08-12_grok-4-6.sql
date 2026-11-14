-- Release batch: Grok 4.6, announced 12 Aug 2026
-- Source: https://x.ai/news/grok-4-6 (table rendered on the page; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill (newest page wins). Grok 4.6 and Grok 4.5, both at high
-- effort (column headers).
--   * Harvey LAB (Vals) = the Legal Agent Benchmark "all pass rate" variant (GPT-5.6 Sol 2.5% here,
--     on the Grok 4.7 page and on Google's Gemini 3.8 Flash card).
--   * CursorBench v3.2 = cursorbench-3-2 (Fable 5 70.5% here and on Anthropic's page);
--     FrontierCode v1.1 (Extended) = frontiercode-extended (GPT-5.6 Sol 60.6% on both).
--   * New: APEX-SWE (coding).
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
--
-- Superseded by a later page (the newer value is entered there):
--   * deepswe, Grok 4.6: 65.9 here; 65.2 on https://x.ai/news/grok-4-7
--   * legal-agent-benchmark-allpass, Grok 4.6: 15.8 here; 15.8 on https://x.ai/news/grok-4-7

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('apex-swe', 'APEX-SWE', 'coding', 'Mercor', null, 'pct', 1,
     null, null,
     'Long-horizon professional software-engineering tasks.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- cursorbench-3-2
    ('cursorbench-3-2', 'Grok 4.6', 69.9, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    ('cursorbench-3-2', 'Grok 4.5', 66.7, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'Grok 4.5', 54, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', 'DeepSWE v1.1.'),
    -- frontiercode-extended
    ('frontiercode-extended', 'Grok 4.6', 61.3, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    ('frontiercode-extended', 'Grok 4.5', 56.6, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    -- apex-agents
    ('apex-agents', 'Grok 4.6', 57.5, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    ('apex-agents', 'Grok 4.5', 47.1, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    -- terminal-bench-3
    ('terminal-bench-3', 'Grok 4.6', 26.0, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    ('terminal-bench-3', 'Grok 4.5', 15.7, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    -- apex-swe
    ('apex-swe', 'Grok 4.6', 56.4, null, 'high', 'xAI', false, date'2026-08-12', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    ('apex-swe', 'Grok 4.5', 53.6, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', null),
    -- legal-agent-benchmark-allpass
    ('legal-agent-benchmark-allpass', 'Grok 4.5', 12.9, null, 'high', 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-6', 'vendor_reported', 'Harvey LAB (Vals).');
