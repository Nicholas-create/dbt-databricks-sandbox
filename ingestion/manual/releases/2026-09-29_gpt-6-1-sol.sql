-- Release batch: GPT-6.1 Sol, announced 29 Sep 2026
-- Source: https://openai.com/index/introducing-gpt-6-1-sol/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins per score).
--
-- Values from each chart's embedded data (best score across effort levels, effort recorded).
-- Entered: GPT-6.1 Sol, GPT-6 Sol and GPT-6 Astra.
--
-- Not entered, and why:
--   * Claude columns (Opus 5.5, Fable 5.1 with fallbacks): Anthropic's models.
--   * Factual error rate and alignment charts ("lower is better").
--   * Repeated on the GPT-6.1 Terra page (entered there): Terminal-Bench Science for GPT-6.1
--     Sol (57.02 here, 57.0 there) and GPT-6 Astra.

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- deepswe
    ('deepswe', 'GPT-6 Astra', 74.12, null, 'xhigh', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    ('deepswe', 'GPT-6.1 Sol', 75.22, null, 'high', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    ('deepswe', 'GPT-6 Sol', 68.81, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    -- gdp-pdf
    ('gdp-pdf', 'GPT-6.1 Sol', 32.0, null, 'high', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('gdp-pdf', 'GPT-6 Astra', 32.2, null, 'xhigh', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('gdp-pdf', 'GPT-6 Sol', 28.0, null, 'high', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- automationbench
    ('automationbench', 'GPT-6 Astra', 41.4, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'AutomationBench 1.0.6. From the page\'s chart data (best score across effort levels).'),
    ('automationbench', 'GPT-6.1 Sol', 36.1, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'AutomationBench 1.0.6. From the page\'s chart data (best score across effort levels).'),
    ('automationbench', 'GPT-6 Sol', 33.18, null, 'xhigh', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'AutomationBench 1.0.6. From the page\'s chart data (best score across effort levels).'),
    -- osworld-2-0-offline
    ('osworld-2-0-offline', 'GPT-6 Astra', 73.49, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-0-offline', 'GPT-6.1 Sol', 71.42, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-0-offline', 'GPT-6 Sol', 64.43, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- terminal-bench-science
    ('terminal-bench-science', 'GPT-6 Sol', 27.59, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-sol/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).');
