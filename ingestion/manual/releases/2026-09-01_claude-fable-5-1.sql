-- Release batch: Claude Fable 5.1 and Claude Mythos 5.1, announced September 2026
-- Source: https://www.anthropic.com/claude-fable-and-mythos-5-1 (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Fable 5.1, Fable 5 and Opus 5, plus the cell labelled Mythos 5.1. Page note:
-- Fable 5.1 ran with production safeguards; where they intervened, cyber tasks were done by
-- Opus 4.8 and biology tasks by Opus 5 (OSWorld 2.0 and AutomationBench interventions
-- scored zero).
--
-- Benchmark mapping:
--   * OSWorld 2.0 here is the benchmark authors' August 2026 task release; the footnote says
--     it is not comparable with earlier OSWorld 2.0 results, so it is two new benchmarks
--     (partial and strict scoring) in the osworld family.
--   * CursorBench 3.2.0 is NOT Epoch's CursorBench (Epoch matches CursorBench 4.0 exactly:
--     Fable 5.1 51.8%), so it is new, in a cursorbench family.
--   * Terminal-Bench 4.0: new, in the terminal-bench family.
--
-- Not entered, and why:
--   * GPT-5.6 Sol column: competitor's model. GDPval-AA v2: Artificial Analysis data.
--   * Already entered from the Fable 5.2 page (same values): AutomationBench, Terminal-Bench-
--     Science and HLE with tools for Fable 5.1 (that page says 65.6; this one 65.0).
--   * Superseded by a later page: Terminal-Bench-Science Opus 5 and Terminal-Bench 4.0
--     Fable 5.1 / Opus 5 repeat on the Opus 5.5 page and are entered from there.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-0-aug', 'OSWorld 2.0 (Aug 2026 tasks)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 Aug',
     'Computer use, August 2026 task release, partial credit; not comparable with earlier OSWorld 2.0 results.'),
    ('osworld-2-0-aug-strict', 'OSWorld 2.0 (Aug 2026 tasks, strict)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 Aug strict',
     'Computer use, August 2026 task release, strict scoring (no partial credit).'),
    ('terminal-bench-4', 'Terminal-Bench 4.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '4.0',
     'Agentic coding in a terminal, version 4.0.'),
    ('cursorbench-3-2', 'CursorBench 3.2', 'coding', 'Cursor', null, 'pct', 1,
     'cursorbench', '3.2',
     'Version 3.2.0; Epoch\'s CursorBench matches version 4.0.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-science
    ('terminal-bench-science', 'Claude Fable 5', 24.7, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'Claude Mythos 5.1', 60.9, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', 'Labelled Mythos 5.1 in the Fable 5.1 column.'),
    ('terminal-bench-4', 'Claude Fable 5', 42.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- osworld-2-0-aug
    ('osworld-2-0-aug', 'Claude Fable 5.1', 77.9, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('osworld-2-0-aug', 'Claude Fable 5', 72.9, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('osworld-2-0-aug', 'Claude Opus 5', 75.4, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- osworld-2-0-aug-strict
    ('osworld-2-0-aug-strict', 'Claude Fable 5.1', 41.7, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('osworld-2-0-aug-strict', 'Claude Fable 5', 36.1, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('osworld-2-0-aug-strict', 'Claude Opus 5', 39.6, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Claude Fable 5.1', 60.9, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('hle-no-tools', 'Claude Fable 5', 57.8, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('hle-no-tools', 'Claude Opus 5', 56.6, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Fable 5', 63.8, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- automationbench
    ('automationbench', 'Claude Fable 5', 17.1, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    -- cursorbench-3-2
    ('cursorbench-3-2', 'Claude Fable 5.1', 73.4, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('cursorbench-3-2', 'Claude Fable 5', 70.5, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null),
    ('cursorbench-3-2', 'Claude Opus 5', 70.0, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/claude-fable-and-mythos-5-1', 'vendor_reported', null);
