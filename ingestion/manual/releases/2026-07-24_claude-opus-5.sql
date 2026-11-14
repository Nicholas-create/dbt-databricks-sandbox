-- Release batch: Claude Opus 5, announced 24 Jul 2026
-- Source: https://www.anthropic.com/news/claude-opus-5 (benchmark table is an image; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Opus 5, Fable 5 and Opus 4.8 (all Anthropic). Cells marked "Mythos 5" in the
-- Fable 5 column are entered as Claude Mythos 5. This page is Fable 5's clean source.
--
-- Benchmark mapping:
--   * FrontierCode v1.1 Main = Epoch's FrontierCode (Fable 5 53.5% vs Epoch 53.5%).
--   * DeepSWE v1.1 = Epoch's DeepSWE (Opus 4.8 59.0% on both).
--   * AutomationBench: same benchmark as the existing manual one.
--   * New: Frontier-Bench v0.1, ARC-AGI-3 (family arc-agi), BrowseComp, OSWorld 2.0
--     (family osworld; the original task release).
--
-- Not entered, and why:
--   * GPT-5.6 Sol column: competitor's model. GDPval-AA v2: Artificial Analysis data.
--   * Effort-curve charts (no printed values) and the misaligned-behaviour audit (a safety
--     score, not a capability benchmark).
--   * Superseded by a later page: AutomationBench Opus 5 26.0 and Fable 5 17.4 (Fable 5.1
--     page: 26.9, 17.1); HLE no tools Opus 5 56.3 / Fable 5 56.5 (56.6 / 57.8); HLE with
--     tools Opus 5 64.7 / Fable 5 63.9 (63.6 / 63.8); FrontierCode Opus 5 53.4 (Opus 5.5
--     page: 48.0).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontier-bench', 'Frontier-Bench', 'coding', null, null, 'pct', 1,
     null, null,
     'Agentic terminal coding, v0.1; mini-SWE-agent harness, mean reward over 5 attempts.'),
    ('arc-agi-3', 'ARC-AGI-3', 'reasoning', 'ARC Prize', 'https://arcprize.org/leaderboard', 'pct', 1,
     'arc-agi', '3',
     'Novel problem-solving in interactive environments.'),
    ('browsecomp', 'BrowseComp', 'agents', 'OpenAI', null, 'pct', 1,
     null, null,
     'Agentic search: hard-to-find facts on the web.'),
    ('osworld-2-0', 'OSWorld 2.0', 'agents', null, null, 'pct', 1,
     'osworld', '2.0',
     'Computer use; the original 2.0 task release.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- frontier-bench
    ('frontier-bench', 'Claude Opus 5', 43.3, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('frontier-bench', 'Claude Fable 5', 33.7, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('frontier-bench', 'Claude Opus 4.8', 21.1, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- arc-agi-3
    ('arc-agi-3', 'Claude Opus 5', 30.2, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('arc-agi-3', 'Claude Opus 4.8', 1.5, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'Claude Opus 5', 90.8, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('browsecomp', 'Claude Fable 5', 87.4, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('browsecomp', 'Claude Opus 4.8', 84.3, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Claude Opus 4.8', 49.8, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Opus 4.8', 57.9, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- osworld-2-0
    ('osworld-2-0', 'Claude Opus 5', 70.6, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('osworld-2-0', 'Claude Fable 5', 66.1, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('osworld-2-0', 'Claude Opus 4.8', 55.7, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'Claude Opus 5', 68.8, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'Claude Fable 5', 69.7, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'Claude Opus 4.8', 59.0, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'DeepSWE v1.1.'),
    -- frontiercode
    ('frontiercode', 'Claude Fable 5', 53.5, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    ('frontiercode', 'Claude Opus 4.8', 46.5, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    -- automationbench
    ('automationbench', 'Claude Opus 4.8', 17.0, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- legal-agent-benchmark
    ('legal-agent-benchmark', 'Claude Opus 5', 11.7, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('legal-agent-benchmark', 'Claude Fable 5', 13.3, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('legal-agent-benchmark', 'Claude Opus 4.8', 10.4, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- healthbench-professional
    ('healthbench-professional', 'Claude Opus 5', 59.8, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('healthbench-professional', 'Claude Mythos 5', 66.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'Labelled Mythos 5 in the Fable 5 column.'),
    ('healthbench-professional', 'Claude Opus 4.8', 57.4, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- biomysterybench-hard
    ('biomysterybench-hard', 'Claude Opus 5', 49.4, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('biomysterybench-hard', 'Claude Fable 5', 46.5, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('biomysterybench-hard', 'Claude Opus 4.8', 42.4, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    -- biomysterybench-human-solved
    ('biomysterybench-human-solved', 'Claude Opus 5', 90.1, null, null, 'Anthropic', false, date'2026-07-24', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null),
    ('biomysterybench-human-solved', 'Claude Mythos 5', 89.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', 'Labelled Mythos 5 in the Fable 5 column.'),
    ('biomysterybench-human-solved', 'Claude Opus 4.8', 88.5, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-opus-5', 'vendor_reported', null);
