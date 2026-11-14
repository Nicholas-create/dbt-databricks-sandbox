-- Correction (not a release), 14 Nov 2026: restore apostrophes lost on insert
-- Databricks (Spark) SQL reads 'Humanity''s' as two string literals glued together, so every
-- '' escape in the batches run so far dropped its apostrophe ("Humanitys Last Exam") without
-- an error. The batch files now escape with a backslash:
--   right: 'Humanity\'s Last Exam'   -> Humanity's Last Exam
--   wrong: 'Humanity''s Last Exam'   -> Humanitys Last Exam
-- Append-only, so the affected rows are inserted again with the text fixed; the newest row
-- wins and the scores are unchanged. Rows copied from the corrected batch files.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontiercode-2', 'FrontierCode 2.0', 'coding', null, null, 'pct', 1,
     'frontiercode', '2.0',
     'Would the maintainers of open-source repositories merge the model\'s code changes. A newer version than Epoch\'s FrontierCode.'),
    ('hle-with-tools', 'Humanity\'s Last Exam (with tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'with tools',
     'Same questions as Humanity\'s Last Exam, with tool use allowed.'),
    ('frontiercode-diamond', 'FrontierCode (Diamond)', 'coding', 'Cognition', null, 'pct', 1,
     'frontiercode', 'Diamond',
     'The Diamond set of FrontierCode, as named on Anthropic\'s pages; scores differ from the Main set (Epoch\'s FrontierCode).'),
    ('hle-no-tools', 'Humanity\'s Last Exam (no tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'no tools',
     'Anthropic\'s own no-tools runs; differ from Epoch\'s Humanity\'s Last Exam, so kept separate.'),
    ('cursorbench-3-2', 'CursorBench 3.2', 'coding', 'Cursor', null, 'pct', 1,
     'cursorbench', '3.2',
     'Version 3.2.0; Epoch\'s CursorBench matches version 4.0.'),
    ('cyscenariobench', 'CyScenarioBench', 'cyber', null, null, 'pct', 1,
     null, null,
     'Realistic cyber-operation scenarios; each lab\'s scores are based on unique tasks.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    ('hle-no-tools', 'Claude Mythos 5', 59.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('hle-with-tools', 'Claude Mythos 5', 64.5, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('biomysterybench-hard', 'Claude Mythos 5', 46.1, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('terminal-bench-2-1', 'Claude Mythos 5', 88.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('exploitbench', 'Claude Mythos 5', 78.0, null, null, 'Anthropic', false, date'2026-06-09', 'https://www.anthropic.com/news/claude-fable-5-mythos-5', 'vendor_reported', 'Starred cell of the Mythos 5 / Fable 5 column (Mythos 5\'s score).'),
    ('terminal-bench-4', 'Claude Opus 5.5', 66.4, null, 'xhigh', 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'Xhigh is Opus 5.5\'s highest score (footnote 1).');
