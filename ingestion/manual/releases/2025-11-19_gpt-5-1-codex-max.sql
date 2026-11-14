-- Release batch: GPT-5.1-Codex-Max, announced 19 Nov 2025
-- Source: https://openai.com/index/gpt-5-1-codex-max/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins).
-- GPT-5.1-Codex at high effort, GPT-5.1-Codex-Max at xhigh (column headers).
-- SWE-Lancer IC SWE = the share-solved SWE-Lancer (IC Diamond) reported on later pages.
-- Terminal-Bench 2.0 = Epoch's Terminal-Bench (2.0).
--
-- Superseded by a later page (the newer value is entered there):
--   * terminal-bench, GPT-5.1-Codex-Max: 58.1 here; 58.1 on https://openai.com/index/introducing-gpt-5-2-codex/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('swe-lancer', 'SWE-Lancer (IC Diamond)', 'coding', 'OpenAI', null, 'pct', 1,
     null, null,
     'Freelance software-engineering tasks (IC SWE Diamond): share solved. The dollars-earned version isn\'t entered.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-verified
    ('swe-bench-verified', 'GPT-5.1-Codex', 73.7, null, 'high', 'OpenAI', false, date'2025-11-12', 'https://openai.com/index/gpt-5-1-codex-max/', 'vendor_reported', 'All 500 problems.'),
    ('swe-bench-verified', 'GPT-5.1-Codex-Max', 77.9, null, 'xhigh', 'OpenAI', false, date'2025-11-19', 'https://openai.com/index/gpt-5-1-codex-max/', 'vendor_reported', 'All 500 problems.'),
    -- swe-lancer
    ('swe-lancer', 'GPT-5.1-Codex', 66.3, null, 'high', 'OpenAI', false, date'2025-11-12', 'https://openai.com/index/gpt-5-1-codex-max/', 'vendor_reported', null),
    ('swe-lancer', 'GPT-5.1-Codex-Max', 79.9, null, 'xhigh', 'OpenAI', false, date'2025-11-19', 'https://openai.com/index/gpt-5-1-codex-max/', 'vendor_reported', null),
    -- terminal-bench
    ('terminal-bench', 'GPT-5.1-Codex', 52.8, null, 'high', 'OpenAI', false, date'2025-11-12', 'https://openai.com/index/gpt-5-1-codex-max/', 'vendor_reported', 'Terminal-Bench 2.0.');
