-- Release batch: GPT-5.2 (Thinking and Pro), announced 11 Dec 2025
-- Source: https://openai.com/index/introducing-gpt-5-2/ (12 HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins).
-- Entered: OpenAI's GPT-5-family models only (GPT-5 onwards); older OpenAI models (o3, o4-mini,
-- GPT-4o, GPT-4.1, ChatGPT agent, deep research) and other developers' columns are not.
-- "GPT-5.2 Thinking" and "GPT-5.1 Thinking" are the API models GPT-5.2 and GPT-5.1 (the page's
-- ChatGPT-to-API table). GDPval's GPT-5 cell is labelled "(GPT-5)" and entered as GPT-5.
--
-- Benchmark mapping:
--   * GDPval (wins or ties): OpenAI's own GDPval, new (agents). Not GDPval-AA (Artificial
--     Analysis). The "clear wins" and "no ties" variants aren't entered (one score per model).
--   * FrontierMath Tier 1–3 / Tier 4 here are the original sets (v1): GPT-5.2 40.3% vs Epoch's
--     v2 67.4%, so they're the v1 benchmarks, not Epoch's.
--   * ARC-AGI-1 / -2 (Verified) = Epoch's ARC-AGI / ARC-AGI-2 (GPT-5.2 86.2% / 52.9% on both).
--   * MMMU Pro (w/ Python) = MMMU-Pro (with tools). ScreenSpot Pro (w/ Python) is new, next to
--     the no-tools ScreenSpot-Pro. OpenAI MRCR v2 8-needle buckets up to 256K: new.
--   * Investment banking spreadsheet tasks and ChatGPT answers without errors: OpenAI internal.
--
-- Not entered: mental-health safety table (not a capability benchmark).
--
-- Superseded by a later page (the newer value is entered there):
--   * gdpval, GPT-5.2: 70.9 here; 70.9 on https://openai.com/index/introducing-gpt-5-4/
--   * gdpval, GPT-5.2 Pro: 74.1 here; 74.1 on https://openai.com/index/introducing-gpt-5-4/
--   * investment-banking-tasks, GPT-5.2: 68.4 here; 68.4 on https://openai.com/index/introducing-gpt-5-4/
--   * investment-banking-tasks, GPT-5.2 Pro: 71.7 here; 71.7 on https://openai.com/index/introducing-gpt-5-4/
--   * swe-bench-pro, GPT-5.2: 55.6 here; 55.6 on https://openai.com/index/introducing-gpt-5-4/
--   * swe-bench-pro, GPT-5.1: 50.8 here; 50.8 on https://openai.com/index/introducing-gpt-5-2-codex/
--   * swe-lancer, GPT-5.2: 74.6 here; 74.6 on https://openai.com/index/introducing-gpt-5-3-codex/
--   * openai-mrcr-4k-8k, GPT-5.2: 98.2 here; 98.2 on https://openai.com/index/introducing-gpt-5-4/
--   * openai-mrcr-8k-16k, GPT-5.2: 89.3 here; 89.3 on https://openai.com/index/introducing-gpt-5-4/
--   * openai-mrcr-16k-32k, GPT-5.2: 95.3 here; 95.3 on https://openai.com/index/introducing-gpt-5-4/
--   * openai-mrcr-32k-64k, GPT-5.2: 92.0 here; 92.0 on https://openai.com/index/introducing-gpt-5-4/
--   * openai-mrcr-64k-128k, GPT-5.2: 85.6 here; 85.6 on https://openai.com/index/introducing-gpt-5-4/
--   * openai-mrcr-128k-256k, GPT-5.2: 77.0 here; 77.0 on https://openai.com/index/introducing-gpt-5-4/
--   * graphwalks-bfs-128k, GPT-5.2: 94.0 here; 94.0 on https://openai.com/index/introducing-gpt-5-4/
--   * graphwalks-parents-128k, GPT-5.2: 89.0 here; 89.0 on https://openai.com/index/introducing-gpt-5-4/
--   * mmmu-pro, GPT-5.2: 79.5 here; 79.5 on https://openai.com/index/introducing-gpt-5-4/
--   * mmmu-pro-with-tools, GPT-5.2: 80.4 here; 80.4 on https://openai.com/index/introducing-gpt-5-4/
--   * tau2-telecom, GPT-5.2: 98.7 here; 98.7 on https://openai.com/index/introducing-gpt-5-4/
--   * browsecomp, GPT-5.2: 65.8 here; 65.8 on https://openai.com/index/introducing-gpt-5-4/
--   * browsecomp, GPT-5.2 Pro: 77.9 here; 77.9 on https://openai.com/index/introducing-gpt-5-4/
--   * mcp-atlas, GPT-5.2: 60.6 here; 60.6 on https://openai.com/index/introducing-gpt-5-4/
--   * toolathlon, GPT-5.2: 46.3 here; 45.7 on https://openai.com/index/introducing-gpt-5-4/
--   * gpqa-diamond, GPT-5.2: 92.4 here; 92.4 on https://openai.com/index/introducing-gpt-5-4/
--   * gpqa-diamond, GPT-5.2 Pro: 93.2 here; 93.2 on https://openai.com/index/introducing-gpt-5-4/
--   * hle-no-tools, GPT-5.2: 34.5 here; 34.5 on https://openai.com/index/introducing-gpt-5-4/
--   * hle-no-tools, GPT-5.2 Pro: 36.6 here; 36.6 on https://openai.com/index/introducing-gpt-5-4/
--   * hle-with-tools, GPT-5.2: 45.5 here; 45.5 on https://openai.com/index/introducing-gpt-5-4/
--   * hle-with-tools, GPT-5.2 Pro: 50.0 here; 50.0 on https://openai.com/index/introducing-gpt-5-4/
--   * frontiermath-1-3-v1, GPT-5.2: 40.3 here; 40.7 on https://openai.com/index/introducing-gpt-5-4/
--   * frontiermath-tier-4-v1, GPT-5.2: 14.6 here; 18.8 on https://openai.com/index/introducing-gpt-5-4/
--   * arc-agi, GPT-5.2: 86.2 here; 86.2 on https://openai.com/index/introducing-gpt-5-4/
--   * arc-agi, GPT-5.2 Pro: 90.5 here; 90.5 on https://openai.com/index/introducing-gpt-5-4/
--   * arc-agi-2, GPT-5.2: 52.9 here; 52.9 on https://openai.com/index/introducing-gpt-5-4/
--   * arc-agi-2, GPT-5.2 Pro: 54.2 here; 54.2 on https://openai.com/index/introducing-gpt-5-4/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('gdpval', 'GDPval', 'agents', 'OpenAI', null, 'pct', 1,
     null, null,
     'Expert-graded knowledge work across 44 occupations: share of tasks where the model\'s work wins or ties against an expert\'s. Not GDPval-AA.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontiermath-tier-4-v1', 'FrontierMath Tier 4 (v1)', 'maths', 'Epoch AI', null, 'pct', 1,
     'frontiermath', 'Tier 4 (v1)',
     'The original FrontierMath Tier 4 set, with Python, as reported on release pages before v2.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mmmlu', 'MMMLU', 'science', null, null, 'pct', 1,
     null, null,
     'MMLU in 14 languages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('screenspot-pro-python', 'ScreenSpot-Pro (with Python)', 'agents', null, null, 'pct', 1,
     'screenspot-pro', 'with Python',
     'ScreenSpot-Pro with a Python tool.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mcp-atlas', 'MCP Atlas', 'agents', 'Scale AI', null, 'pct', 1,
     null, null,
     'Tool use through MCP servers.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-4k-8k', 'OpenAI MRCR v2 (4K–8K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '4K–8K',
     'Long-context retrieval: 8 needles in 4K–8K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-8k-16k', 'OpenAI MRCR v2 (8K–16K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '8K–16K',
     'Long-context retrieval: 8 needles in 8K–16K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-16k-32k', 'OpenAI MRCR v2 (16K–32K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '16K–32K',
     'Long-context retrieval: 8 needles in 16K–32K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-32k-64k', 'OpenAI MRCR v2 (32K–64K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '32K–64K',
     'Long-context retrieval: 8 needles in 32K–64K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-64k-128k', 'OpenAI MRCR v2 (64K–128K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '64K–128K',
     'Long-context retrieval: 8 needles in 64K–128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-128k-256k', 'OpenAI MRCR v2 (128K–256K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '128K–256K',
     'Long-context retrieval: 8 needles in 128K–256K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('investment-banking-tasks', 'Investment Banking Modeling Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('chatgpt-factuality-search', 'ChatGPT Answers Without Errors, with search (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('chatgpt-factuality-nosearch', 'ChatGPT Answers Without Errors, no search (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gdpval
    ('gdpval', 'GPT-5', 38.8, null, null, 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'Wins or ties.'),
    -- investment-banking-tasks
    ('investment-banking-tasks', 'GPT-5.1', 59.1, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- swe-bench-verified
    ('swe-bench-verified', 'GPT-5.2', 80.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('swe-bench-verified', 'GPT-5.1', 76.3, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- swe-lancer
    ('swe-lancer', 'GPT-5.1', 69.7, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- chatgpt-factuality-search
    ('chatgpt-factuality-search', 'GPT-5.2', 93.9, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('chatgpt-factuality-search', 'GPT-5.1', 91.2, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- chatgpt-factuality-nosearch
    ('chatgpt-factuality-nosearch', 'GPT-5.2', 88.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('chatgpt-factuality-nosearch', 'GPT-5.1', 87.3, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-4k-8k
    ('openai-mrcr-4k-8k', 'GPT-5.1', 65.3, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-8k-16k
    ('openai-mrcr-8k-16k', 'GPT-5.1', 47.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-16k-32k
    ('openai-mrcr-16k-32k', 'GPT-5.1', 44.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-32k-64k
    ('openai-mrcr-32k-64k', 'GPT-5.1', 37.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-64k-128k
    ('openai-mrcr-64k-128k', 'GPT-5.1', 36.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- openai-mrcr-128k-256k
    ('openai-mrcr-128k-256k', 'GPT-5.1', 29.6, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- browsecomp-lc-128k
    ('browsecomp-lc-128k', 'GPT-5.2', 92.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('browsecomp-lc-128k', 'GPT-5.1', 90.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- browsecomp-lc-256k
    ('browsecomp-lc-256k', 'GPT-5.2', 89.8, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('browsecomp-lc-256k', 'GPT-5.1', 89.5, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- graphwalks-bfs-128k
    ('graphwalks-bfs-128k', 'GPT-5.1', 76.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- graphwalks-parents-128k
    ('graphwalks-parents-128k', 'GPT-5.1', 71.5, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'GPT-5.2', 82.1, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('charxiv-reasoning', 'GPT-5.1', 67.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- charxiv-reasoning-python
    ('charxiv-reasoning-python', 'GPT-5.2', 88.7, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('charxiv-reasoning-python', 'GPT-5.1', 80.3, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- mmmu-pro-with-tools
    ('mmmu-pro-with-tools', 'GPT-5.1', 79.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'With Python.'),
    -- videommmu
    ('videommmu', 'GPT-5.2', 85.9, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'No tools.'),
    ('videommmu', 'GPT-5.1', 82.9, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'No tools.'),
    -- screenspot-pro-python
    ('screenspot-pro-python', 'GPT-5.2', 86.3, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('screenspot-pro-python', 'GPT-5.1', 64.2, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'GPT-5.1', 95.6, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- tau2-retail
    ('tau2-retail', 'GPT-5.2', 82.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('tau2-retail', 'GPT-5.1', 77.9, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'GPT-5.1', 50.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'GPT-5.1', 44.5, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'GPT-5.1', 36.1, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.1', 88.1, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'No tools.'),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5.1', 25.7, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-5.1', 42.7, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'Search and Python.'),
    -- mmmlu
    ('mmmlu', 'GPT-5.2', 89.6, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('mmmlu', 'GPT-5.1', 89.5, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'GPT-5.2', 99.4, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('hmmt-feb-2025', 'GPT-5.2 Pro', 100.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('hmmt-feb-2025', 'GPT-5.1', 96.3, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- aime-2025
    ('aime-2025', 'GPT-5.2', 100.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('aime-2025', 'GPT-5.2 Pro', 100.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    ('aime-2025', 'GPT-5.1', 94.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', null),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5.1', 31.0, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'With Python.'),
    -- frontiermath-tier-4-v1
    ('frontiermath-tier-4-v1', 'GPT-5.1', 12.5, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'With Python.'),
    -- arc-agi
    ('arc-agi', 'GPT-5.1', 72.8, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    -- arc-agi-2
    ('arc-agi-2', 'GPT-5.1', 17.6, null, null, 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/introducing-gpt-5-2/', 'vendor_reported', 'ARC-AGI-2 (Verified).');
