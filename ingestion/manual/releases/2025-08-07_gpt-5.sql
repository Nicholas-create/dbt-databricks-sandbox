-- Release batch: GPT-5 (launch post), announced 7 Aug 2025
-- Source: https://openai.com/index/introducing-gpt-5/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (one batch per page, page order; newest page wins).
-- Entered: OpenAI's GPT-5-family models only (GPT-5 onwards); older OpenAI models (o3, o4-mini,
-- GPT-4o, GPT-4.1, ChatGPT agent, deep research) and other developers' columns are not.
--
-- The charts' exact values ship with the page. The bars are stacked (without + with thinking),
-- so the value entered is the one printed on the bar, which matches the developer page.
-- Only GPT-5 Pro, and GPT-5 results the developer page lacks, are entered from here.
--
-- Not entered, and why:
--   * "(python)" results on AIME, HMMT and GPQA: a tool set-up reported only here, for two models.
--   * FrontierMath "no tools": FrontierMath is run with Python everywhere else.
--   * Tau2-bench (domain not stated) and "Economically important tasks" (metric not stated).
--   * Hallucination, deception and safety charts: not capability benchmarks.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('healthbench', 'HealthBench', 'life-sciences', 'OpenAI', null, 'pct', 1,
     'healthbench', 'HealthBench',
     'Realistic health conversations graded against physician-written rubrics.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('healthbench-hard', 'HealthBench Hard', 'life-sciences', 'OpenAI', null, 'pct', 1,
     'healthbench', 'Hard',
     'The hardest HealthBench conversations.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontiermath-1-3-v1', 'FrontierMath Tier 1–3 (v1)', 'maths', 'Epoch AI', null, 'pct', 1,
     'frontiermath', '1–3 (v1)',
     'The original FrontierMath set, with Python, as reported on release pages before v2. Epoch\'s FrontierMath is v2.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- aime-2025
    ('aime-2025', 'GPT-5 Pro', 96.7, null, null, 'OpenAI', false, date'2025-10-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).'),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5 Pro', 32.1, null, null, 'OpenAI', false, date'2025-10-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).'),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5 Pro', 88.4, null, null, 'OpenAI', false, date'2025-10-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'No tools. From the page\'s chart data (the value printed on the bar).'),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5 Pro', 30.7, null, null, 'OpenAI', false, date'2025-10-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).'),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-5 Pro', 42.0, null, null, 'OpenAI', false, date'2025-10-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'Python + search with blocklist. From the page\'s chart data (the value printed on the bar).'),
    ('hle-with-tools', 'GPT-5', 35.2, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'Python + search with blocklist. From the page\'s chart data (the value printed on the bar).'),
    -- browsecomp
    ('browsecomp', 'GPT-5', 54.9, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).'),
    -- healthbench
    ('healthbench', 'GPT-5', 67.2, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).'),
    -- healthbench-hard
    ('healthbench-hard', 'GPT-5', 46.2, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5/', 'vendor_reported', 'From the page\'s chart data (the value printed on the bar).');
