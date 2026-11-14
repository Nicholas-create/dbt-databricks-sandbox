-- Release batch: GPT-5.2-Codex, announced 18 Dec 2025
-- Source: https://openai.com/index/introducing-gpt-5-2-codex/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). Values from the charts' data.
-- "Professional Capture-the-Flag Challenges" is OpenAI's internal CTF evaluation (the GPT-5.5
-- page labels it "Internal"): hidden category. The o3 bar isn't entered (pre-GPT-5 model).
--
-- Superseded by a later page (the newer value is entered there):
--   * swe-bench-pro, GPT-5.2-Codex: 56.4 here; 56.4 on https://openai.com/index/introducing-gpt-5-3-codex/
--   * swe-bench-pro, GPT-5.2: 55.6 here; 55.6 on https://openai.com/index/introducing-gpt-5-4/
--   * terminal-bench, GPT-5.2-Codex: 64.0 here; 64.0 on https://openai.com/index/introducing-gpt-5-3-codex/
--   * terminal-bench, GPT-5.2: 62.2 here; 62.2 on https://openai.com/index/introducing-gpt-5-4/
--   * ctf-challenges, GPT-5.2: 82.35 here; 67.7 on https://openai.com/index/introducing-gpt-5-3-codex/
--   * ctf-challenges, GPT-5.2-Codex: 88.1 here; 67.4 on https://openai.com/index/introducing-gpt-5-3-codex/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.1', 50.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2-codex/', 'vendor_reported', 'From the page\'s chart data.'),
    -- terminal-bench
    ('terminal-bench', 'GPT-5.1-Codex-Max', 58.1, null, null, 'OpenAI', false, date'2025-11-19', 'https://openai.com/index/introducing-gpt-5-2-codex/', 'vendor_reported', 'Terminal-Bench 2.0. From the page\'s chart data.'),
    -- ctf-challenges
    ('ctf-challenges', 'GPT-5', 26.83, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-2-codex/', 'vendor_reported', 'From the page\'s chart data.'),
    ('ctf-challenges', 'GPT-5-Codex', 50.5, null, null, 'OpenAI', false, date'2025-09-15', 'https://openai.com/index/introducing-gpt-5-2-codex/', 'vendor_reported', 'From the page\'s chart data.'),
    ('ctf-challenges', 'GPT-5.1-Codex-Max', 75.6, null, null, 'OpenAI', false, date'2025-11-19', 'https://openai.com/index/introducing-gpt-5-2-codex/', 'vendor_reported', 'From the page\'s chart data.');
