-- Release batch: GPT-6.1 Terra, announced 26 Oct 2026
-- Source: https://openai.com/index/introducing-gpt-6-1-terra/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins per score).
--
-- Values from each chart's embedded data; every point entered is at max effort.
-- Entered: GPT-6.1 Terra, GPT-6.1 Sol, GPT-6 Astra, GPT-6 Luna and GPT-5.6 Terra.
--   * MMMU-Pro (Vision): new variant in the mmmu-pro family.
--   * OSWorld 2.1, offline set = osworld-2-1 (Claude Sonnet 5.5 83.9% here and on Anthropic's
--     Haiku 5.5 page).
--
-- Not entered: Claude columns (Anthropic's models); factual error rate ("lower is better").

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mmmu-pro-vision', 'MMMU-Pro (Vision)', 'reasoning', null, null, 'pct', 1,
     'mmmu-pro', 'vision',
     'MMMU-Pro vision setting: the question is part of the image.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- agents-last-exam
    ('agents-last-exam', 'GPT-6.1 Terra', 60.0, null, 'max', 'OpenAI', false, date'2026-10-26', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-6.1 Sol', 58.6, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-6 Astra', 59.3, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-6 Luna', 50.9, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('agents-last-exam', 'GPT-5.6 Terra', 50.7, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- mmmu-pro-vision
    ('mmmu-pro-vision', 'GPT-6.1 Terra', 85.5, null, 'max', 'OpenAI', false, date'2026-10-26', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('mmmu-pro-vision', 'GPT-6.1 Sol', 86.3, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('mmmu-pro-vision', 'GPT-6 Astra', 86.7, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('mmmu-pro-vision', 'GPT-6 Luna', 79.9, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('mmmu-pro-vision', 'GPT-5.6 Terra', 81.7, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- osworld-2-1
    ('osworld-2-1', 'GPT-6.1 Terra', 74.2, null, 'max', 'OpenAI', false, date'2026-10-26', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-1', 'GPT-6.1 Sol', 78.0, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-1', 'GPT-6 Astra', 80.9, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-1', 'GPT-6 Luna', 55.5, null, 'max', 'OpenAI', false, date'2026-09-22', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('osworld-2-1', 'GPT-5.6 Terra', 57.1, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- terminal-bench-4
    ('terminal-bench-4', 'GPT-6.1 Terra', 50.3, null, 'max', 'OpenAI', false, date'2026-10-26', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('terminal-bench-4', 'GPT-6.1 Sol', 55.9, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('terminal-bench-4', 'GPT-6 Astra', 58.2, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('terminal-bench-4', 'GPT-5.6 Terra', 21.5, null, 'max', 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- terminal-bench-science
    ('terminal-bench-science', 'GPT-6.1 Terra', 58.3, null, 'max', 'OpenAI', false, date'2026-10-26', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('terminal-bench-science', 'GPT-6.1 Sol', 57.0, null, 'max', 'OpenAI', false, date'2026-09-29', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    ('terminal-bench-science', 'GPT-6 Astra', 68.1, null, 'max', 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/introducing-gpt-6-1-terra/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).');
