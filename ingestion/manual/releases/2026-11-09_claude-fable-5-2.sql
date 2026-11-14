-- Release batch: Claude Fable 5.2 (and Claude Mythos 5.2), announced 9 Nov 2026
-- Source: https://www.anthropic.com/claude-fable-and-mythos-5-2 (read 14 Nov 2026)
-- Entered: 14 Nov 2026, following ingestion/manual/README.md
--
-- Entered: Anthropic's results for its own models (Fable 5.2, Fable 5.1, Opus 5.5),
-- source_type = vendor_reported. Page notes: scores are with safeguards on and at
-- each model's highest available effort unless a cell says otherwise.
--
-- Not entered, and why:
--   * GPT-6 Astra and Gemini 4 Carbon columns: a developer's numbers for competitors'
--     models; those come from the competitors' own release pages.
--   * Claude Mythos 5.2: restricted access (vetted organisations only), and its only
--     cell in a benchmark we show (Terminal-Bench-Science, 75.3%) isn't clearly labelled.
--   * CyScenarioBench, CVE Rediscovery, De novo binder design, RoboDojo Sim: no fitting
--     site category yet (cybersecurity, protein design, robotics).
--   * AA-Briefcase (and its unlabelled Elo row): Artificial Analysis data, whose terms
--     don't allow redistribution (CONVENTIONS.md section 8).
--   * Chartography (no tools): category not yet decided.
--
-- Benchmark mapping:
--   * FrontierSWE v2 and Remote Labor Index match Epoch's existing benchmarks (Fable 5.2's
--     69.9% and 41.3% equal Epoch's figures), so these rows supersede Epoch's.
--   * FrontierCode 2.0 and Humanity's Last Exam (with tools) are defined as NEW benchmarks:
--     Anthropic's numbers differ too much from Epoch's FrontierCode / HLE (Fable 5.1:
--     32.4% vs 50.9%, 65.6% vs 46.5%) to be the same test and setup.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max, notes)
values
    ('frontiercode-2',         'FrontierCode 2.0',                   'coding',  null,         null, 'pct', 1,
     'Would the maintainers of open-source repositories merge the model\'s code changes. A newer version than Epoch\'s FrontierCode.'),
    ('automationbench',        'AutomationBench',                    'agents',  null,         null, 'pct', 1,
     'Business workflow automation.'),
    ('wandr',                  'WANDR',                              'agents',  'Perplexity', null, 'pct', 1,
     'Agentic search; relaxed score.'),
    ('osworld-2-1',            'OSWorld 2.1',                        'agents',  null,         null, 'pct', 1,
     'Computer use; offline set, partial credit.'),
    ('terminal-bench-science', 'Terminal-Bench-Science',             'science', null,         null, 'pct', 1,
     'Agentic scientific research; version 0.1.'),
    ('hle-with-tools',         'Humanity\'s Last Exam (with tools)', 'science', null,         null, 'pct', 1,
     'Same questions as Humanity\'s Last Exam, with tool use allowed.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- FrontierCode 2.0
    ('frontiercode-2', 'Claude Fable 5.2', 49.1, null, 'xhigh', 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('frontiercode-2', 'Claude Fable 5.1', 32.4, null, 'xhigh', 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('frontiercode-2', 'Claude Opus 5.5',  45.5, null, 'max',   'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'Effort from the page text ("at Max effort").'),
    -- FrontierSWE v2 (supersedes Epoch)
    ('frontierswe', 'Claude Fable 5.2', 69.9, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'FrontierSWE v2.'),
    ('frontierswe', 'Claude Fable 5.1', 56.3, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'FrontierSWE v2.'),
    ('frontierswe', 'Claude Opus 5.5',  62.3, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'FrontierSWE v2.'),
    -- AutomationBench
    ('automationbench', 'Claude Fable 5.2', 51.4, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('automationbench', 'Claude Fable 5.1', 31.4, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('automationbench', 'Claude Opus 5.5',  42.5, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- WANDR (relaxed score)
    ('wandr', 'Claude Fable 5.2', 82.1, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('wandr', 'Claude Fable 5.1', 68.7, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('wandr', 'Claude Opus 5.5',  72.3, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- OSWorld 2.1 (offline set, partial)
    ('osworld-2-1', 'Claude Fable 5.2', 89.3, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('osworld-2-1', 'Claude Fable 5.1', 83.5, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('osworld-2-1', 'Claude Opus 5.5',  87.2, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- Terminal-Bench-Science 0.1
    ('terminal-bench-science', 'Claude Fable 5.2', 74.6, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('terminal-bench-science', 'Claude Fable 5.1', 52.6, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('terminal-bench-science', 'Claude Opus 5.5',  58.7, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- Remote Labor Index (supersedes Epoch)
    ('remote-labor-index', 'Claude Fable 5.2', 41.3, null, 'high', 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('remote-labor-index', 'Claude Fable 5.1', 17.9, null, null,   'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('remote-labor-index', 'Claude Opus 5.5',  21.3, null, null,   'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- Humanity's Last Exam (with tools)
    ('hle-with-tools', 'Claude Fable 5.2', 74.2, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('hle-with-tools', 'Claude Fable 5.1', 65.6, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('hle-with-tools', 'Claude Opus 5.5',  67.7, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null);
