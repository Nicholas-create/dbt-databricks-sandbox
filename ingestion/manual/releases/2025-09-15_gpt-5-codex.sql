-- Release batch: GPT-5-Codex ("Introducing upgrades to Codex"), announced 15 Sep 2025
-- Source: https://openai.com/index/introducing-upgrades-to-codex/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). Values from the charts' data.
-- Code refactoring tasks: OpenAI internal (hidden category). Not entered: Codex CLI traffic
-- share and code-review comment charts (usage, not benchmarks).
--
-- Superseded by a later page (the newer value is entered there):
--   * swe-bench-verified, GPT-5: 72.8 here; 72.8 on https://openai.com/index/gpt-5-1-for-developers/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('code-refactoring-tasks', 'Code Refactoring Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-verified
    ('swe-bench-verified', 'GPT-5-Codex', 74.5, null, 'high', 'OpenAI', false, date'2025-09-15', 'https://openai.com/index/introducing-upgrades-to-codex/', 'vendor_reported', 'All 500 problems. From the page\'s chart data.'),
    -- code-refactoring-tasks
    ('code-refactoring-tasks', 'GPT-5-Codex', 51.34, null, 'high', 'OpenAI', false, date'2025-09-15', 'https://openai.com/index/introducing-upgrades-to-codex/', 'vendor_reported', 'From the page\'s chart data.'),
    ('code-refactoring-tasks', 'GPT-5', 33.93, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-upgrades-to-codex/', 'vendor_reported', 'From the page\'s chart data.');
