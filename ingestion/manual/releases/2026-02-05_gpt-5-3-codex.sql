-- Release batch: GPT-5.3-Codex, announced 5 Feb 2026
-- Source: https://openai.com/index/introducing-gpt-5-3-codex/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). All columns at xhigh effort, except
-- GDPval for GPT-5.2 (high).
--
-- Superseded by a later page (the newer value is entered there):
--   * swe-bench-pro, GPT-5.3-Codex: 56.8 here; 56.8 on https://openai.com/index/introducing-gpt-5-4/
--   * swe-bench-pro, GPT-5.2: 55.6 here; 55.6 on https://openai.com/index/introducing-gpt-5-4/
--   * terminal-bench, GPT-5.3-Codex: 77.3 here; 77.3 on https://openai.com/index/introducing-gpt-5-4/
--   * terminal-bench, GPT-5.2: 62.2 here; 62.2 on https://openai.com/index/introducing-gpt-5-4/
--   * osworld-verified, GPT-5.3-Codex: 64.7 here; 74.0 on https://openai.com/index/introducing-gpt-5-4/
--   * osworld-verified, GPT-5.2: 37.9 here; 47.3 on https://openai.com/index/introducing-gpt-5-4/
--   * gdpval, GPT-5.3-Codex: 70.9 here; 70.9 on https://openai.com/index/introducing-gpt-5-4/
--   * gdpval, GPT-5.2: 70.9 here; 70.9 on https://openai.com/index/introducing-gpt-5-4/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.2-Codex', 56.4, null, 'xhigh', 'OpenAI', false, date'2025-12-18', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', 'Public set.'),
    -- terminal-bench
    ('terminal-bench', 'GPT-5.2-Codex', 64.0, null, 'xhigh', 'OpenAI', false, date'2025-12-18', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    -- osworld-verified
    ('osworld-verified', 'GPT-5.2-Codex', 38.2, null, 'xhigh', 'OpenAI', false, date'2025-12-18', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    -- ctf-challenges
    ('ctf-challenges', 'GPT-5.3-Codex', 77.6, null, 'xhigh', 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.2-Codex', 67.4, null, 'xhigh', 'OpenAI', false, date'2025-12-18', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.2', 67.7, null, 'xhigh', 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    -- swe-lancer
    ('swe-lancer', 'GPT-5.3-Codex', 81.4, null, 'xhigh', 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    ('swe-lancer', 'GPT-5.2-Codex', 76.0, null, 'xhigh', 'OpenAI', false, date'2025-12-18', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null),
    ('swe-lancer', 'GPT-5.2', 74.6, null, 'xhigh', 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-3-codex/', 'vendor_reported', null);
