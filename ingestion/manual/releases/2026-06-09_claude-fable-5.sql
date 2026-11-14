-- Release batch: Claude Fable 5 and Claude Mythos 5, announced 9 Jun 2026
-- Source: https://www.anthropic.com/news/claude-fable-5-mythos-5 (benchmark table is an image; read 14 Nov 2026)
-- Entered: 14 Nov 2026, as part of the Claude 5-family backfill (one batch per page,
-- run in page order; each score comes from the newest page that reports it).
--
-- Entered: Anthropic's own models. The highlighted column is "Mythos 5 / Fable 5"
-- combined: per the page's methodology note it shows the HIGHER of the two models.
--   * Starred (*) cells differ because Fable 5's safeguards fall back to Opus 4.8, so
--     the starred value is Claude Mythos 5's: entered as Claude Mythos 5.
--   * Unstarred cells could be either model (within 1-3 points): not entered. Fable 5's
--     own scores come from the Opus 5 page, which gives it a column of its own.
--   * Claude Mythos Preview and Claude Opus 4.8 columns are clean: entered.
--
-- Not entered, and why:
--   * GPT 5.5 and Gemini 3.1 Pro columns: competitors' models.
--   * GDPval-AA: Artificial Analysis data (CONVENTIONS.md section 8).
--   * Superseded by a later page (newer value entered there): AutomationBench Opus 4.8
--     15.5 (Opus 5 page: 17.0); BioMysteryBench hard Opus 4.8 40.0 (42.4); human solved
--     Opus 4.8 80.4 (88.5) and Mythos 5 83.9 (89.0); HealthBench Professional Opus 4.8
--     56.9 (57.4). HLE, OSWorld-Verified, Terminal-Bench 2.1, SWE-bench Pro and Legal
--     values for Opus 4.8 repeat on later pages and are entered from the latest one.
--
-- New benchmarks: SWE-bench Pro (family swe-bench, with Epoch's SWE-bench Verified),
-- FrontierCode Diamond (family frontiercode), Terminal-Bench 2.1 (family terminal-bench,
-- with Epoch's 2.0), OSWorld-Verified (family osworld), HLE no tools (family
-- humanity-s-last-exam: Anthropic's no-tools runs differ from Epoch's HLE, e.g.
-- Sonnet 5.5 56.9% vs 46.1%), GDP.pdf, Blueprint-Bench 2, Legal Agent Benchmark,
-- BioMysteryBench (hard / human solved), ExploitBench, HealthBench Professional.
-- New site categories: cyber and life-sciences (seeds/benchmark_categories.csv).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('swe-bench-pro', 'SWE-bench Pro', 'coding', 'Scale AI', null, 'pct', 1,
     'swe-bench', 'Pro',
     'Long-horizon software engineering tasks; a harder successor to SWE-bench Verified.'),
    ('frontiercode-diamond', 'FrontierCode (Diamond)', 'coding', 'Cognition', null, 'pct', 1,
     'frontiercode', 'Diamond',
     'The Diamond set of FrontierCode, as named on Anthropic\'s pages; scores differ from the Main set (Epoch\'s FrontierCode).'),
    ('terminal-bench-2-1', 'Terminal-Bench 2.1', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '2.1',
     'Agentic coding in a terminal, version 2.1.'),
    ('osworld-verified', 'OSWorld-Verified', 'agents', null, null, 'pct', 1,
     'osworld', 'Verified',
     'Computer use, verified task set.'),
    ('hle-no-tools', 'Humanity\'s Last Exam (no tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'no tools',
     'Anthropic\'s own no-tools runs; differ from Epoch\'s Humanity\'s Last Exam, so kept separate.'),
    ('gdp-pdf', 'GDP.pdf', 'agents', null, null, 'pct', 1,
     null, null,
     'Knowledge work from document images (vision), no tools.'),
    ('blueprint-bench-2', 'Blueprint-Bench 2', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Spatial reasoning.'),
    ('legal-agent-benchmark', 'Legal Agent Benchmark', 'agents', null, null, 'pct', 1,
     null, null,
     'Legal agent tasks (held-out set).'),
    ('biomysterybench-hard', 'BioMysteryBench (hard)', 'life-sciences', null, null, 'pct', 1,
     'biomysterybench', 'hard',
     'Biology research problems, hard subset.'),
    ('biomysterybench-human-solved', 'BioMysteryBench (human solved)', 'life-sciences', null, null, 'pct', 1,
     'biomysterybench', 'human solved',
     'Biology research problems that human experts have solved.'),
    ('exploitbench', 'ExploitBench', 'cyber', null, null, 'pct', 1,
     null, null,
     'Exploit development; Cap% score.'),
    ('healthbench-professional', 'HealthBench Professional', 'life-sciences', 'OpenAI', null, 'pct', 1,
     null, null,
     'Health conversations graded against physician-written rubrics, professional set.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'Claude Mythos Preview', 77.8, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- frontiercode-diamond
    ('frontiercode-diamond', 'Claude Opus 4.8', 13.4, null, 'xhigh', 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- gdp-pdf
    ('gdp-pdf', 'Claude Opus 4.8', 22.5, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'No tools.'),
    -- blueprint-bench-2
    ('blueprint-bench-2', 'Claude Opus 4.8', 14.5, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- osworld-verified
    ('osworld-verified', 'Claude Mythos Preview', 85.4, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Claude Mythos 5', 59.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('hle-no-tools', 'Claude Mythos Preview', 56.8, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Mythos 5', 64.5, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('hle-with-tools', 'Claude Mythos Preview', 64.7, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- biomysterybench-hard
    ('biomysterybench-hard', 'Claude Mythos 5', 46.1, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('biomysterybench-hard', 'Claude Mythos Preview', 29.6, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- biomysterybench-human-solved
    ('biomysterybench-human-solved', 'Claude Mythos Preview', 82.6, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Claude Mythos 5', 88.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    -- exploitbench
    ('exploitbench', 'Claude Mythos 5', 78.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('exploitbench', 'Claude Mythos Preview', 69.0, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    ('exploitbench', 'Claude Opus 4.8', 40.0, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null),
    -- healthbench-professional
    ('healthbench-professional', 'Claude Mythos Preview', 64.7, null, null, 'Anthropic', false, date'2026-04-07', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', null);
