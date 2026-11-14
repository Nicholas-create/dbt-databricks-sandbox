-- Release batch: GPT-5.5 and GPT-5.5 Pro, announced 23 Apr 2026
-- Source: https://openai.com/index/introducing-gpt-5-5/ (9 HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). Claude and Gemini columns not entered.
--   * New: CyberGym (cyber); GeneBench, BixBench (life sciences); OfficeQA Pro (agents, with
--     OfficeQA); Expert-SWE (OpenAI internal, hidden).
--   * GeneBench is not GeneBench Pro (GPT-5.5: 25.0% here, 12% on the GPT-5.6 page): two
--     benchmarks in one family.
--   * Capture-the-Flags challenge tasks (Internal) = the hidden ctf-challenges.
--   * Graphwalks BFS / parents "256k" and "1mil" = the 256K and 1M benchmarks.
--   * Tau2-bench Telecom "(original prompts)": GPT-5.4 scores 92.8% here vs 98.9% on the GPT-5.4
--     page, so it's a separate variant, not a revision.
-- Not entered: Artificial Analysis Intelligence Index.
--
-- Superseded by a later page (the newer value is entered there):
--   * toolathlon, GPT-5.5: 55.6 here; 55.6 on https://openai.com/index/gpt-5-6/
--   * browsecomp, GPT-5.5: 84.4 here; 84.4 on https://openai.com/index/gpt-5-6/
--   * swe-bench-pro, GPT-5.5: 58.6 here; 59.4 on https://openai.com/index/gpt-5-6/
--   * mmmu-pro, GPT-5.5: 81.2 here; 81.2 on https://openai.com/index/gpt-5-6/
--   * mmmu-pro-with-tools, GPT-5.5: 83.2 here; 83.2 on https://openai.com/index/gpt-5-6/
--   * gpqa-diamond, GPT-5.5: 93.6 here; 93.6 on https://openai.com/index/gpt-5-6/
--   * ctf-challenges, GPT-5.5: 88.1 here; 88.1 on https://openai.com/index/gpt-5-6/
--   * ctf-challenges, GPT-5.4: 83.7 here; 83.75 on https://openai.com/index/gpt-5-6/
--   * graphwalks-256k, GPT-5.5: 73.7 here; 73.7 on https://openai.com/index/gpt-5-6/
--   * graphwalks-1m, GPT-5.5: 45.4 here; 45.4 on https://openai.com/index/gpt-5-6/
--   * openai-mrcr-256k, GPT-5.5: 81.5 here; 81.5 on https://openai.com/index/gpt-5-6/
--   * openai-mrcr-1m, GPT-5.5: 74.0 here; 74 on https://openai.com/index/gpt-5-6/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('cybergym', 'CyberGym', 'cyber', null, null, 'pct', 1,
     null, null,
     'Reproducing real-world vulnerabilities from descriptions.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('genebench', 'GeneBench', 'life-sciences', null, null, 'pct', 1,
     'genebench', 'GeneBench',
     'Genomics and gene-analysis tasks.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('bixbench', 'BixBench', 'life-sciences', null, null, 'pct', 1,
     null, null,
     'Bioinformatics analysis tasks.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('officeqa-pro', 'OfficeQA Pro', 'agents', null, null, 'pct', 1,
     'officeqa', 'Pro',
     'Harder questions over office documents.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('tau2-telecom-original', 'τ²-bench (telecom, original prompts)', 'agents', 'Sierra', null, 'pct', 1,
     'tau2-bench', 'telecom (original prompts)',
     'Telecom domain with the original task prompts; scores differ from the other telecom runs (GPT-5.4: 92.8% vs 98.9%).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('expert-swe', 'Expert-SWE (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench
    ('terminal-bench', 'GPT-5.5', 82.7, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    ('terminal-bench', 'GPT-5.4', 75.1, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Terminal-Bench 2.0.'),
    -- expert-swe
    ('expert-swe', 'GPT-5.5', 73.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('expert-swe', 'GPT-5.4', 68.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- gdpval
    ('gdpval', 'GPT-5.5', 84.9, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Wins or ties.'),
    ('gdpval', 'GPT-5.4', 83.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Wins or ties.'),
    ('gdpval', 'GPT-5.5 Pro', 82.3, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Wins or ties.'),
    ('gdpval', 'GPT-5.4 Pro', 82.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Wins or ties.'),
    -- osworld-verified
    ('osworld-verified', 'GPT-5.5', 78.7, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('osworld-verified', 'GPT-5.4', 75.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'GPT-5.4', 54.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'GPT-5.4', 82.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.5 Pro', 90.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.4 Pro', 89.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5.5', 51.7, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-1-3-v1', 'GPT-5.4', 47.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-1-3-v1', 'GPT-5.5 Pro', 52.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-1-3-v1', 'GPT-5.4 Pro', 50.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- frontiermath-tier-4-v1
    ('frontiermath-tier-4-v1', 'GPT-5.5', 35.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-tier-4-v1', 'GPT-5.4', 27.1, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-tier-4-v1', 'GPT-5.5 Pro', 39.6, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('frontiermath-tier-4-v1', 'GPT-5.4 Pro', 38.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- cybergym
    ('cybergym', 'GPT-5.5', 81.8, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('cybergym', 'GPT-5.4', 79.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.4', 57.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'Public set.'),
    -- financeagent
    ('financeagent', 'GPT-5.5', 60.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'v1.1.'),
    ('financeagent', 'GPT-5.4', 56.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'v1.1.'),
    ('financeagent', 'GPT-5.4 Pro', 61.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'v1.1.'),
    -- investment-banking-tasks
    ('investment-banking-tasks', 'GPT-5.5', 88.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('investment-banking-tasks', 'GPT-5.4', 87.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('investment-banking-tasks', 'GPT-5.5 Pro', 88.6, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('investment-banking-tasks', 'GPT-5.4 Pro', 83.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- officeqa-pro
    ('officeqa-pro', 'GPT-5.5', 54.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('officeqa-pro', 'GPT-5.4', 53.2, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5.4', 81.2, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- mmmu-pro-with-tools
    ('mmmu-pro-with-tools', 'GPT-5.4', 82.1, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'GPT-5.5', 75.3, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('mcp-atlas', 'GPT-5.4', 70.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- tau2-telecom-original
    ('tau2-telecom-original', 'GPT-5.5', 98.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('tau2-telecom-original', 'GPT-5.4', 92.8, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- genebench
    ('genebench', 'GPT-5.5', 25.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('genebench', 'GPT-5.4', 19.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('genebench', 'GPT-5.5 Pro', 33.2, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('genebench', 'GPT-5.4 Pro', 25.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- bixbench
    ('bixbench', 'GPT-5.5', 80.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('bixbench', 'GPT-5.4', 74.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.4', 92.8, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.4 Pro', 94.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5.5', 41.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5.4', 39.8, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5.5 Pro', 43.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5.4 Pro', 42.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-5.5', 52.2, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5.4', 52.1, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5.5 Pro', 57.2, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('hle-with-tools', 'GPT-5.4 Pro', 58.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- graphwalks-256k
    ('graphwalks-256k', 'GPT-5.4', 62.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- graphwalks-1m
    ('graphwalks-1m', 'GPT-5.4', 9.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- graphwalks-parents-256k
    ('graphwalks-parents-256k', 'GPT-5.5', 90.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('graphwalks-parents-256k', 'GPT-5.4', 82.8, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- graphwalks-parents-1m
    ('graphwalks-parents-1m', 'GPT-5.5', 58.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('graphwalks-parents-1m', 'GPT-5.4', 44.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-4k-8k
    ('openai-mrcr-4k-8k', 'GPT-5.5', 98.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-4k-8k', 'GPT-5.4', 97.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-8k-16k
    ('openai-mrcr-8k-16k', 'GPT-5.5', 93.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-8k-16k', 'GPT-5.4', 91.4, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-16k-32k
    ('openai-mrcr-16k-32k', 'GPT-5.5', 96.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-16k-32k', 'GPT-5.4', 97.2, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-32k-64k
    ('openai-mrcr-32k-64k', 'GPT-5.5', 90.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-32k-64k', 'GPT-5.4', 90.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-64k-128k
    ('openai-mrcr-64k-128k', 'GPT-5.5', 83.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-64k-128k', 'GPT-5.4', 86.0, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-128k-256k
    ('openai-mrcr-128k-256k', 'GPT-5.5', 87.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    ('openai-mrcr-128k-256k', 'GPT-5.4', 79.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-256k
    ('openai-mrcr-256k', 'GPT-5.4', 57.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- openai-mrcr-1m
    ('openai-mrcr-1m', 'GPT-5.4', 36.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', null),
    -- arc-agi
    ('arc-agi', 'GPT-5.5', 95.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    ('arc-agi', 'GPT-5.4', 93.7, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    ('arc-agi', 'GPT-5.4 Pro', 94.5, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-1 (Verified).'),
    -- arc-agi-2
    ('arc-agi-2', 'GPT-5.5', 85.0, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-2 (Verified).'),
    ('arc-agi-2', 'GPT-5.4', 73.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-2 (Verified).'),
    ('arc-agi-2', 'GPT-5.4 Pro', 83.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/introducing-gpt-5-5/', 'vendor_reported', 'ARC-AGI-2 (Verified).');
