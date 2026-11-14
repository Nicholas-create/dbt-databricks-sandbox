-- Release batch: GPT-5.4 and GPT-5.4 Pro, announced 5 Mar 2026
-- Source: https://openai.com/index/introducing-gpt-5-4/ (10 HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins).
--   * New: FinanceAgent v1.1, OfficeQA (agents); FrontierScience Research (science);
--     GraphWalks BFS / parents at 256K–1M (reasoning).
--   * OSWorld-Verified GPT-5.3-Codex: 74.0% here (asterisked) vs 64.7% on its own page; the
--     newer value is entered.
-- Not entered: OmniDocBench (edit distance, lower is better); tau2-bench telecom with reasoning
-- set to "none" (the models' best set-up is entered elsewhere).
--
-- Superseded by a later page (the newer value is entered there):
--   * gdpval, GPT-5.4: 83.0 here; 83.0 on https://openai.com/index/introducing-gpt-5-5/
--   * gdpval, GPT-5.4 Pro: 82.0 here; 82.0 on https://openai.com/index/introducing-gpt-5-5/
--   * financeagent, GPT-5.4: 56.0 here; 56.0 on https://openai.com/index/introducing-gpt-5-5/
--   * financeagent, GPT-5.4 Pro: 61.5 here; 61.5 on https://openai.com/index/introducing-gpt-5-5/
--   * investment-banking-tasks, GPT-5.4: 87.3 here; 87.3 on https://openai.com/index/introducing-gpt-5-5/
--   * investment-banking-tasks, GPT-5.4 Pro: 83.6 here; 83.6 on https://openai.com/index/introducing-gpt-5-5/
--   * swe-bench-pro, GPT-5.4: 57.7 here; 57.7 on https://openai.com/index/introducing-gpt-5-5/
--   * terminal-bench, GPT-5.4: 75.1 here; 75.1 on https://openai.com/index/introducing-gpt-5-5/
--   * osworld-verified, GPT-5.4: 75.0 here; 75.0 on https://openai.com/index/introducing-gpt-5-5/
--   * mmmu-pro, GPT-5.4: 81.2 here; 81.2 on https://openai.com/index/introducing-gpt-5-5/
--   * mmmu-pro-with-tools, GPT-5.4: 82.1 here; 82.1 on https://openai.com/index/introducing-gpt-5-5/
--   * browsecomp, GPT-5.4: 82.7 here; 82.7 on https://openai.com/index/introducing-gpt-5-5/
--   * browsecomp, GPT-5.4 Pro: 89.3 here; 89.3 on https://openai.com/index/introducing-gpt-5-5/
--   * mcp-atlas, GPT-5.4: 67.2 here; 70.6 on https://openai.com/index/introducing-gpt-5-5/
--   * toolathlon, GPT-5.4: 54.6 here; 54.6 on https://openai.com/index/introducing-gpt-5-5/
--   * tau2-telecom, GPT-5.4: 98.9 here; 98.9 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * frontiermath-1-3-v1, GPT-5.4: 47.6 here; 47.6 on https://openai.com/index/introducing-gpt-5-5/
--   * frontiermath-1-3-v1, GPT-5.4 Pro: 50.0 here; 50.0 on https://openai.com/index/introducing-gpt-5-5/
--   * frontiermath-tier-4-v1, GPT-5.4: 27.1 here; 27.1 on https://openai.com/index/introducing-gpt-5-5/
--   * frontiermath-tier-4-v1, GPT-5.4 Pro: 38.0 here; 38.0 on https://openai.com/index/introducing-gpt-5-5/
--   * gpqa-diamond, GPT-5.4: 92.8 here; 92.8 on https://openai.com/index/introducing-gpt-5-5/
--   * gpqa-diamond, GPT-5.4 Pro: 94.4 here; 94.4 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-no-tools, GPT-5.4: 39.8 here; 39.8 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-no-tools, GPT-5.4 Pro: 42.7 here; 42.7 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-with-tools, GPT-5.4: 52.1 here; 52.1 on https://openai.com/index/introducing-gpt-5-5/
--   * hle-with-tools, GPT-5.4 Pro: 58.7 here; 58.7 on https://openai.com/index/introducing-gpt-5-5/
--   * graphwalks-bfs-128k, GPT-5.4: 93.0 here; 93.1 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * graphwalks-parents-128k, GPT-5.4: 89.8 here; 89.8 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * openai-mrcr-4k-8k, GPT-5.4: 97.3 here; 97.3 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-8k-16k, GPT-5.4: 91.4 here; 91.4 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-16k-32k, GPT-5.4: 97.2 here; 97.2 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-32k-64k, GPT-5.4: 90.5 here; 90.5 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-64k-128k, GPT-5.4: 86.0 here; 86.0 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-128k-256k, GPT-5.4: 79.3 here; 79.3 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-256k, GPT-5.4: 57.5 here; 57.5 on https://openai.com/index/introducing-gpt-5-5/
--   * openai-mrcr-1m, GPT-5.4: 36.6 here; 36.6 on https://openai.com/index/introducing-gpt-5-5/
--   * arc-agi, GPT-5.4: 93.7 here; 93.7 on https://openai.com/index/introducing-gpt-5-5/
--   * arc-agi, GPT-5.4 Pro: 94.5 here; 94.5 on https://openai.com/index/introducing-gpt-5-5/
--   * arc-agi-2, GPT-5.4: 73.3 here; 73.3 on https://openai.com/index/introducing-gpt-5-5/
--   * arc-agi-2, GPT-5.4 Pro: 83.3 here; 83.3 on https://openai.com/index/introducing-gpt-5-5/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('financeagent', 'FinanceAgent', 'agents', 'Vals AI', null, 'pct', 1,
     null, null,
     'Financial-analyst agent tasks (v1.1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('officeqa', 'OfficeQA', 'agents', null, null, 'pct', 1,
     'officeqa', 'OfficeQA',
     'Questions over office documents.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontier-science-research', 'FrontierScience (Research)', 'science', 'OpenAI', null, 'pct', 1,
     null, null,
     'Research-level science problems.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-bfs-256k-1m', 'GraphWalks BFS (256K–1M)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks', '256K–1M',
     'Breadth-first search over a graph given in 256K–1M tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-256k', 'GraphWalks parents (256K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '256K',
     'Finding a node\'s parents in a graph given in 256K tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-1m', 'GraphWalks parents (1M)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '1M',
     'Finding a node\'s parents in a graph given in 1M tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-256k-1m', 'GraphWalks parents (256K–1M)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '256K–1M',
     'Finding a node\'s parents in a graph given in 256K–1M tokens.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gdpval
    ('gdpval', 'GPT-5.3-Codex', 70.9, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Wins or ties.'),
    ('gdpval', 'GPT-5.2', 70.9, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Wins or ties.'),
    ('gdpval', 'GPT-5.2 Pro', 74.1, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Wins or ties.'),
    -- financeagent
    ('financeagent', 'GPT-5.3-Codex', 54.0, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'v1.1.'),
    ('financeagent', 'GPT-5.2', 59.5, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'v1.1.'),
    -- investment-banking-tasks
    ('investment-banking-tasks', 'GPT-5.3-Codex', 79.3, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('investment-banking-tasks', 'GPT-5.2', 68.4, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('investment-banking-tasks', 'GPT-5.2 Pro', 71.7, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- officeqa
    ('officeqa', 'GPT-5.4', 68.1, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('officeqa', 'GPT-5.3-Codex', 65.1, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('officeqa', 'GPT-5.2', 63.1, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.3-Codex', 56.8, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Public set.'),
    ('swe-bench-pro', 'GPT-5.2', 55.6, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Public set.'),
    -- terminal-bench
    ('terminal-bench', 'GPT-5.3-Codex', 77.3, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    ('terminal-bench', 'GPT-5.2', 62.2, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    -- osworld-verified
    ('osworld-verified', 'GPT-5.3-Codex', 74.0, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('osworld-verified', 'GPT-5.2', 47.3, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5.2', 79.5, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- mmmu-pro-with-tools
    ('mmmu-pro-with-tools', 'GPT-5.2', 80.4, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'GPT-5.3-Codex', 77.3, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.2', 65.8, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.2 Pro', 77.9, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'GPT-5.2', 60.6, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'GPT-5.3-Codex', 51.9, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5.2', 45.7, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'GPT-5.2', 98.7, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- frontier-science-research
    ('frontier-science-research', 'GPT-5.4', 33.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('frontier-science-research', 'GPT-5.4 Pro', 36.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('frontier-science-research', 'GPT-5.2', 25.2, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5.2', 40.7, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- frontiermath-tier-4-v1
    ('frontiermath-tier-4-v1', 'GPT-5.2', 18.8, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('frontiermath-tier-4-v1', 'GPT-5.2 Pro', 31.3, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.3-Codex', 92.6, null, null, 'OpenAI', false, date'2026-02-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.2', 92.4, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.2 Pro', 93.2, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5.2', 34.5, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5.2 Pro', 36.6, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-5.2', 45.5, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5.2 Pro', 50.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- graphwalks-bfs-128k
    ('graphwalks-bfs-128k', 'GPT-5.2', 94.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- graphwalks-bfs-256k-1m
    ('graphwalks-bfs-256k-1m', 'GPT-5.4', 21.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- graphwalks-parents-128k
    ('graphwalks-parents-128k', 'GPT-5.2', 89.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- graphwalks-parents-256k-1m
    ('graphwalks-parents-256k-1m', 'GPT-5.4', 32.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-4k-8k
    ('openai-mrcr-4k-8k', 'GPT-5.2', 98.2, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-8k-16k
    ('openai-mrcr-8k-16k', 'GPT-5.2', 89.3, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-16k-32k
    ('openai-mrcr-16k-32k', 'GPT-5.2', 95.3, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-32k-64k
    ('openai-mrcr-32k-64k', 'GPT-5.2', 92.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-64k-128k
    ('openai-mrcr-64k-128k', 'GPT-5.2', 85.6, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- openai-mrcr-128k-256k
    ('openai-mrcr-128k-256k', 'GPT-5.2', 77.0, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', null),
    -- arc-agi
    ('arc-agi', 'GPT-5.2', 86.2, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    ('arc-agi', 'GPT-5.2 Pro', 90.5, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    -- arc-agi-2
    ('arc-agi-2', 'GPT-5.2', 52.9, null, null, 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'ARC-AGI-2 (Verified).'),
    ('arc-agi-2', 'GPT-5.2 Pro', 54.2, null, 'high', 'OpenAI', false, date'2025-12-11', 'https://openai.com/index/introducing-gpt-5-4/', 'vendor_reported', 'ARC-AGI-2 (Verified).');
