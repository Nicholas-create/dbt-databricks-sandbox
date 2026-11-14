-- Release batch: Claude Opus 5.5, announced 22 Sep 2026
-- Source: https://www.anthropic.com/claude-opus-5-5 (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Opus 5.5, Fable 5.1 and Opus 5. Page note: Opus 5.5 uses adaptive thinking at
-- max effort with production safeguards, unless noted; AutomationBench was run and reported
-- by Zapier. Opus 5.5's Terminal-Bench 4.0 repeats on the Sonnet 5.5 page and is entered there.
--
-- Benchmark mapping:
--   * CursorBench 4.0 = Epoch's CursorBench (Opus 5.5 57.8%, Fable 5.1 51.8% on both).
--   * FrontierCode v1.1 (Main) = Epoch's FrontierCode.
--   * OSWorld 2.1 "partial" differs from the "offline set" results on the Fable 5.2 and
--     Haiku 5.5 pages (Fable 5.1: 80.7% vs 83.5%), so it is a new benchmark, osworld-2-1-full.
--   * Chartography (with tools): new; the no-tools results elsewhere are a separate variant.
--
-- Not entered, and why:
--   * GPT-6 Astra and GPT-5.6 Sol columns: competitors' models. GDPval-AA v2.1: Artificial
--     Analysis data.
--   * Already entered from the Fable 5.2 page: AutomationBench (Opus 5.5 40.0 here, 42.5
--     there), HLE with tools and Terminal-Bench-Science for Opus 5.5 / Fable 5.1.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-1-full', 'OSWorld 2.1', 'agents', null, null, 'pct', 1,
     'osworld', '2.1',
     'Computer use, version 2.1, partial credit; no subset named (the offline-set results are osworld-2-1).'),
    ('chartography-with-tools', 'Chartography (with tools)', 'reasoning', 'Surge AI', null, 'pct', 1,
     'chartography', 'with tools',
     'Visual chart recognition, tool use allowed.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-4
    ('terminal-bench-4', 'Claude Fable 5.1', 55.8, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    ('terminal-bench-4', 'Claude Opus 5', 52.3, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    -- frontiercode
    ('frontiercode', 'Claude Fable 5.1', 50.3, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    ('frontiercode', 'Claude Opus 5', 48.0, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', 'FrontierCode v1.1, Main. The Opus 5 page reported 53.4.'),
    -- cursorbench
    ('cursorbench', 'Claude Fable 5.1', 51.8, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', 'CursorBench 4.0.'),
    ('cursorbench', 'Claude Opus 5', 46.6, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', 'CursorBench 4.0.'),
    -- automationbench
    ('automationbench', 'Claude Opus 5', 26.9, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Opus 5', 63.6, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    -- terminal-bench-science
    ('terminal-bench-science', 'Claude Opus 5', 29.0, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    -- osworld-2-1-full
    ('osworld-2-1-full', 'Claude Fable 5.1', 80.7, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    ('osworld-2-1-full', 'Claude Opus 5', 74.0, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    -- chartography-with-tools
    ('chartography-with-tools', 'Claude Opus 5.5', 89.0, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    ('chartography-with-tools', 'Claude Fable 5.1', 88.4, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null),
    ('chartography-with-tools', 'Claude Opus 5', 83.4, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-opus-5-5', 'vendor_reported', null);
