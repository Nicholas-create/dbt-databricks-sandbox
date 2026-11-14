-- Release batch: GPT-5.4 mini and GPT-5.4 nano, announced 17 Mar 2026
-- Source: https://openai.com/index/introducing-gpt-5-4-mini-and-nano/ (6 HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). GPT-5.4, mini and nano at xhigh;
-- GPT-5 mini at high (column headers). Names as in our data: GPT-5.4 Mini, GPT-5.4 Nano.
-- MMMUPro w/ Python = MMMU-Pro (with tools). Not entered: OmniDocBench (lower is better).
--
-- Superseded by a later page (the newer value is entered there):
--   * swe-bench-pro, GPT-5.4: 57.7 here; 57.7 on https://openai.com/index/introducing-gpt-5-5/
--   * terminal-bench, GPT-5.4: 75.1 here; 75.1 on https://openai.com/index/introducing-gpt-5-5/
--   * toolathlon, GPT-5.4: 54.6 here; 54.6 on https://openai.com/index/introducing-gpt-5-5/
--   * gpqa-diamond, GPT-5.4: 93.0 here; 92.8 on https://openai.com/index/introducing-gpt-5-5/
--   * osworld-verified, GPT-5.4: 75.0 here; 75.0 on https://openai.com/index/introducing-gpt-5-5/
--   * mcp-atlas, GPT-5.4: 67.2 here; 70.6 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-with-tools, GPT-5.4: 52.1 here; 52.1 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-no-tools, GPT-5.4: 39.8 here; 39.8 on https://openai.com/index/introducing-gpt-5-5/
--   * mmmu-pro-with-tools, GPT-5.4: 81.5 here; 82.1 on https://openai.com/index/introducing-gpt-5-5/
--   * mmmu-pro, GPT-5.4: 81.2 here; 81.2 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-64k-128k, GPT-5.4: 86.0 here; 86.0 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-128k-256k, GPT-5.4: 79.3 here; 79.3 on https://openai.com/index/introducing-gpt-5-5/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.4 Mini', 54.4, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Public set.'),
    ('swe-bench-pro', 'GPT-5.4 Nano', 52.4, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Public set.'),
    ('swe-bench-pro', 'GPT-5 mini', 45.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Public set.'),
    -- terminal-bench
    ('terminal-bench', 'GPT-5.4 Mini', 60.0, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    ('terminal-bench', 'GPT-5.4 Nano', 46.3, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    ('terminal-bench', 'GPT-5 mini', 38.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    -- toolathlon
    ('toolathlon', 'GPT-5.4 Mini', 42.9, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5.4 Nano', 35.5, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5 mini', 26.9, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.4 Mini', 88.0, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.4 Nano', 82.8, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5 mini', 81.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- osworld-verified
    ('osworld-verified', 'GPT-5.4 Mini', 72.1, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('osworld-verified', 'GPT-5.4 Nano', 39.0, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('osworld-verified', 'GPT-5 mini', 42.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'GPT-5.4 Mini', 57.7, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('mcp-atlas', 'GPT-5.4 Nano', 56.1, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('mcp-atlas', 'GPT-5 mini', 47.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'GPT-5.4', 98.9, null, 'xhigh', 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('tau2-telecom', 'GPT-5.4 Mini', 93.4, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('tau2-telecom', 'GPT-5.4 Nano', 92.5, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('tau2-telecom', 'GPT-5 mini', 74.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-5.4 Mini', 41.5, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5.4 Nano', 37.7, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5 mini', 31.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5.4 Mini', 28.2, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5.4 Nano', 24.3, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5 mini', 18.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- mmmu-pro-with-tools
    ('mmmu-pro-with-tools', 'GPT-5.4 Mini', 78.0, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'With Python.'),
    ('mmmu-pro-with-tools', 'GPT-5.4 Nano', 69.5, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'With Python.'),
    ('mmmu-pro-with-tools', 'GPT-5 mini', 74.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', 'With Python.'),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5.4 Mini', 76.6, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('mmmu-pro', 'GPT-5.4 Nano', 66.1, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('mmmu-pro', 'GPT-5 mini', 67.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- openai-mrcr-64k-128k
    ('openai-mrcr-64k-128k', 'GPT-5.4 Mini', 47.7, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('openai-mrcr-64k-128k', 'GPT-5.4 Nano', 44.2, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('openai-mrcr-64k-128k', 'GPT-5 mini', 35.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- openai-mrcr-128k-256k
    ('openai-mrcr-128k-256k', 'GPT-5.4 Mini', 33.6, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('openai-mrcr-128k-256k', 'GPT-5.4 Nano', 33.1, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('openai-mrcr-128k-256k', 'GPT-5 mini', 19.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- graphwalks-bfs-128k
    ('graphwalks-bfs-128k', 'GPT-5.4', 93.1, null, 'xhigh', 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-bfs-128k', 'GPT-5.4 Mini', 76.3, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-bfs-128k', 'GPT-5.4 Nano', 73.4, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-bfs-128k', 'GPT-5 mini', 73.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    -- graphwalks-parents-128k
    ('graphwalks-parents-128k', 'GPT-5.4', 89.8, null, 'xhigh', 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-parents-128k', 'GPT-5.4 Mini', 71.5, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-parents-128k', 'GPT-5.4 Nano', 50.8, null, 'xhigh', 'OpenAI', false, date'2026-03-17', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null),
    ('graphwalks-parents-128k', 'GPT-5 mini', 64.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-4-mini-and-nano/', 'vendor_reported', null);
