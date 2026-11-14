-- Release batch: GPT-6 Sol and GPT-6 Luna, announced 22 Sep 2026
-- Source: https://openai.com/index/introducing-gpt-6-sol-and-luna/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins per score).
--
-- The results are cost-vs-score charts with no printed values, but each chart's exact data
-- ships with the page (model, effort, score): every value here comes from that data, taking
-- each model's best score across effort levels and recording that effort.
--
-- Entered: GPT-6 Sol, GPT-6 Luna, GPT-6 Astra, GPT-5.6 Sol and GPT-5.6 Luna.
--   * AutomationBench is version 1.0.6 here; OpenAI's earlier numbers (GPT-5.6 Sol 18.1%) are
--     superseded by this page's 28.8%. Anthropic's figures (Opus 5 26.9%) match this version.
--
-- Not entered, and why:
--   * Claude columns: Anthropic's models.
--   * Factual error rate and the alignment charts ("lower is better"): not capability scores.
--   * Repeated on the GPT-6.1 Sol page (entered there): AutomationBench GPT-6 Sol / Astra,
--     DeepSWE GPT-6 Sol / Astra, OSWorld 2.0 offline GPT-6 Sol / Astra. Agents' Last Exam
--     Astra and GPT-6 Luna repeat on the GPT-6.1 Terra page.

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- automationbench
    ('automationbench', 'GPT-6 Luna', 20.7, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('automationbench', 'GPT-5.6 Sol', 28.8, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('automationbench', 'GPT-5.6 Luna', 17.0, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- agents-last-exam
    ('agents-last-exam', 'GPT-6 Sol', 56.36, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-5.6 Sol', 53.62, null, 'xhigh', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-5.6 Luna', 50.37, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- frontiercode
    ('frontiercode', 'GPT-6 Astra', 53.3, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'FrontierCode 1.1 Main. From the page\'s chart data (best score across effort levels).'),
    ('frontiercode', 'GPT-6 Sol', 49.27, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'FrontierCode 1.1 Main. From the page\'s chart data (best score across effort levels).'),
    ('frontiercode', 'GPT-6 Luna', 42.42, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'FrontierCode 1.1 Main. From the page\'s chart data (best score across effort levels).'),
    ('frontiercode', 'GPT-5.6 Sol', 47.5, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'FrontierCode 1.1 Main. From the page\'s chart data (best score across effort levels).'),
    ('frontiercode', 'GPT-5.6 Luna', 39.8, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'FrontierCode 1.1 Main. From the page\'s chart data (best score across effort levels).'),
    -- deepswe
    ('deepswe', 'GPT-6 Luna', 66.59, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    ('deepswe', 'GPT-5.6 Sol', 72.67, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    ('deepswe', 'GPT-5.6 Luna', 62.17, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'DeepSWE v1.1. From the page\'s chart data (best score across effort levels).'),
    -- osworld-2-0-offline
    ('osworld-2-0-offline', 'GPT-6 Luna', 52.68, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-0-offline', 'GPT-5.6 Sol', 66.24, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-0-offline', 'GPT-5.6 Luna', 52.71, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-sol-and-luna/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).');
