-- Release batch: GPT-6 Astra, announced 3 Sep 2026
-- Source: https://openai.com/index/gpt-6-astra/ (9 HTML tables plus charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins per score).
--
-- Entered: GPT-6 Astra and GPT-5.6 Sol (both OpenAI) from the tables.
--
-- Benchmark mapping:
--   * The table's "BenchCAD" row is the python-tool variant: its chart is titled "BenchCAD
--     (python tool)" and GPT-5.6 Sol's 83.3% matches that row on the GPT-5.6 page (83.4%).
--   * OSWorld 2.0 (v2026.08.08, offline set, partial score): new, osworld-2-0-offline.
--   * FrontierCode 1.1 Extended: new, in the frontiercode family. FrontierCode 1.1 Main =
--     Epoch's FrontierCode. ARC-AGI-1 / ARC-AGI-2 = Epoch's ARC-AGI / ARC-AGI-2.
--   * ExploitBench (June-Aug 2026): new variant in an exploitbench family.
--   * OpenScore String Quartets is published as 1 - OMR-NED on a 0-1 scale (0.84); entered
--     as a share (84.0).
--   * Internal Design / Data Science / Database Migration Tasks: hidden 'internal' category.
--
-- Not entered, and why:
--   * Claude and Gemini columns: other developers' models.
--   * Artificial Analysis Intelligence Index and Coding Agent Index: Artificial Analysis data.
--   * Alignment rows ("lower is better" safety rates): not capability benchmarks.
--   * Superseded by a later page: Agents' Last Exam (Astra 59.3, Sol 53.6), OSWorld 2.0 offline
--     (Astra 72.6, Sol 65.7), DeepSWE Astra 74.1, AutomationBench (Astra 41.4, Sol 18.1),
--     FrontierCode Main (Astra 53.3, Sol 47.5), Terminal-Bench 4.0 Astra 57.9,
--     Terminal-Bench Science Astra 64.6 (GPT-6.1 pages: 68.1).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('screenspot-pro', 'ScreenSpot-Pro', 'agents', null, null, 'pct', 1,
     null, null,
     'Locating interface elements in high-resolution screenshots (no tools).'),
    ('osworld-2-0-offline', 'OSWorld 2.0 (offline set)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 offline',
     'Computer use, OSWorld 2.0 v2026.08.08 offline set, partial score.'),
    ('frontiercode-extended', 'FrontierCode (Extended)', 'coding', 'Cognition', null, 'pct', 1,
     'frontiercode', 'Extended',
     'FrontierCode 1.1, Extended set.'),
    ('openscore-string-quartets', 'OpenScore String Quartets', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Optical music recognition: transcribing photographed string-quartet scores (1 - OMR-NED, Legato camera subset).'),
    ('exploitbench', 'ExploitBench', 'cyber', null, null, 'pct', 1,
     'exploitbench', 'ExploitBench',
     'Exploit development; Cap% score.'),
    ('exploitbench-jun-aug-2026', 'ExploitBench (Jun–Aug 2026)', 'cyber', null, null, 'pct', 1,
     'exploitbench', 'Jun–Aug 2026',
     'Internal port of ExploitBench on vulnerabilities from June to August 2026.'),
    ('sre-bench', 'SRE-Bench', 'cyber', null, null, 'pct', 1,
     null, null,
     'Site-reliability and security operations tasks.'),
    ('design-tasks', 'Design Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('data-science-tasks', 'Data Science Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('database-migration-tasks', 'Database Migration Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- screenspot-pro
    ('screenspot-pro', 'GPT-6 Astra', 92.7, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('screenspot-pro', 'GPT-5.6 Sol', 76.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- benchcad-python
    ('benchcad-python', 'GPT-6 Astra', 95.9, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('benchcad-python', 'GPT-5.6 Sol', 83.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'GPT-6 Astra', 91.5, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.6 Sol', 90.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- openscore-string-quartets
    ('openscore-string-quartets', 'GPT-6 Astra', 84.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'Published as 0.84 / 0.19 (1 - OMR-NED).'),
    ('openscore-string-quartets', 'GPT-5.6 Sol', 19.0, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'Published as 0.84 / 0.19 (1 - OMR-NED).'),
    -- design-tasks
    ('design-tasks', 'GPT-6 Astra', 50.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('design-tasks', 'GPT-5.6 Sol', 47.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- data-science-tasks
    ('data-science-tasks', 'GPT-6 Astra', 40.9, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('data-science-tasks', 'GPT-5.6 Sol', 30.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'GPT-5.6 Sol', 37.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- frontiercode-extended
    ('frontiercode-extended', 'GPT-6 Astra', 64.5, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('frontiercode-extended', 'GPT-5.6 Sol', 60.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- database-migration-tasks
    ('database-migration-tasks', 'GPT-6 Astra', 63.9, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('database-migration-tasks', 'GPT-5.6 Sol', 42.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- terminal-bench-science
    ('terminal-bench-science', 'GPT-5.6 Sol', 22.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- frontiermath-tier-4
    ('frontiermath-tier-4', 'GPT-6 Astra', 97.6, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'FrontierMath Tier 4 (v2).'),
    ('frontiermath-tier-4', 'GPT-5.6 Sol', 83.0, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'FrontierMath Tier 4 (v2).'),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-6 Astra', 96.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.6 Sol', 94.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'GPT-6 Astra', 57.2, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- genebench-pro
    ('genebench-pro', 'GPT-6 Astra', 37.1, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('genebench-pro', 'GPT-5.6 Sol', 32.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- medchembench
    ('medchembench', 'GPT-6 Astra', 49.3, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('medchembench', 'GPT-5.6 Sol', 47.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- lifescibench
    ('lifescibench', 'GPT-6 Astra', 60.3, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('lifescibench', 'GPT-5.6 Sol', 59.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- healthbench-professional
    ('healthbench-professional', 'GPT-6 Astra', 63.4, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'Length-adjusted.'),
    ('healthbench-professional', 'GPT-5.6 Sol', 60.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'Length-adjusted.'),
    -- exploitbench
    ('exploitbench', 'GPT-6 Astra', 100.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('exploitbench', 'GPT-5.6 Sol', 78.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- exploitgym
    ('exploitgym', 'GPT-6 Astra', 42.4, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('exploitgym', 'GPT-5.6 Sol', 30.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- exploitbench-jun-aug-2026
    ('exploitbench-jun-aug-2026', 'GPT-6 Astra', 39.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('exploitbench-jun-aug-2026', 'GPT-5.6 Sol', 5.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- sre-bench
    ('sre-bench', 'GPT-6 Astra', 88.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('sre-bench', 'GPT-5.6 Sol', 55.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- sec-bench-pro
    ('sec-bench-pro', 'GPT-6 Astra', 85.4, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('sec-bench-pro', 'GPT-5.6 Sol', 79.1, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- openai-mrcr-256k
    ('openai-mrcr-256k', 'GPT-6 Astra', 100.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('openai-mrcr-256k', 'GPT-5.6 Sol', 91.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- openai-mrcr-1m
    ('openai-mrcr-1m', 'GPT-6 Astra', 96.3, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('openai-mrcr-1m', 'GPT-5.6 Sol', 73.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- arc-agi-3
    ('arc-agi-3', 'GPT-6 Astra', 99.9, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('arc-agi-3', 'GPT-5.6 Sol', 7.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- arc-agi-2
    ('arc-agi-2', 'GPT-6 Astra', 95.0, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    ('arc-agi-2', 'GPT-5.6 Sol', 92.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', null),
    -- arc-agi
    ('arc-agi', 'GPT-6 Astra', 98.5, null, null, 'OpenAI', false, date'2026-09-03', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'ARC-AGI-1.'),
    ('arc-agi', 'GPT-5.6 Sol', 97.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-6-astra/', 'vendor_reported', 'ARC-AGI-1.');
