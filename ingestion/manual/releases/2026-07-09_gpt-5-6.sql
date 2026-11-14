-- Release batch: GPT-5.6 Sol, Terra and Luna, announced 9 Jul 2026
-- Source: https://openai.com/index/gpt-5-6/ (11 HTML tables plus charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (one batch per page, run in page order; each score
-- comes from the newest page that reports it).
--
-- Entered: OpenAI's own models from the tables: GPT-5.6 Sol, Terra, Luna, the "GPT-5.6 Sol
-- Ultra" column, and GPT-5.5. GPT-5.4 appears only in the charts, whose exact values ship
-- with the page: entered from that chart data.
--
-- Internal evaluations (Management Consulting Tasks, MedChemBench, and the self-improvement
-- set: Research Debugging, KernelGen 1P, NanoGPT, PostTrainBench Lite, RSI Index) only ever
-- score OpenAI's models, so they go in the hidden 'internal' category: kept, not on the site.
--
-- Benchmark mapping (checked against a model both sources score):
--   * SWE-Bench Pro = swe-bench-pro (Claude Mythos Preview 77.8% on both pages).
--   * gdp.pdf = gdp-pdf (Claude Opus 4.8 22.5% on both).
--   * ARC-AGI-3 = arc-agi-3 (Opus 4.8 1.5% on both). FrontierMath Tier 1-3 / Tier 4 (v2) =
--     Epoch's FrontierMath. GPQA Diamond = Epoch's.
--   * OSWorld 2.0 here is the original release (Opus 4.8 54.8% vs Anthropic's 55.7%).
--   * New: Agents' Last Exam, Big Finance Bench, Toolathlon (agents); BenchCAD and BenchCAD
--     (python tool) (coding); GeneBench Pro, LifeSciBench (life sciences); Capture-the-Flag
--     Challenges, SEC-Bench Pro, ExploitGym (cyber); MMMU-Pro no tools / with tools, OpenAI
--     MRCR v2 and GraphWalks BFS at two context lengths (reasoning).
--
-- Not entered, and why:
--   * Claude and Gemini columns: other developers' models.
--   * GDPval-AA, Artificial Analysis Intelligence Index and Coding Agent Index: Artificial
--     Analysis data (CONVENTIONS.md section 8).
--   * Multi-agent breakdowns (1 / 4 / 16 agents): set-ups of one model; only the named
--     "GPT-5.6 Sol Ultra" column is entered.
--   * Superseded by a later page (newer value entered there): Agents' Last Exam Sol 52.7,
--     Terra 50.4, Luna 50.3; DeepSWE Sol 72.7, Luna 67.2; GeneBench Pro Sol 28.7; MedChemBench
--     Sol 48.3; SEC-Bench Pro Sol 71.2; ExploitBench Sol 73.5; ExploitGym Sol 33.7; BenchCAD
--     (python tool) Sol 83.4; AutomationBench Sol 18.1, Luna 14.9 (AutomationBench 1.0.6 on the
--     GPT-6 Sol page: 28.8, 17.0); ARC-AGI-3 Sol 7.78. Values repeated unchanged on the GPT-6
--     Astra page are entered from there.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('agents-last-exam', 'Agents\' Last Exam', 'agents', null, null, 'pct', 1,
     null, null,
     'Long-horizon professional work on a computer across 55 sub-industries (v1).'),
    ('big-finance-bench', 'Big Finance Bench', 'agents', null, null, 'pct', 1,
     null, null,
     'Finance work tasks.'),
    ('toolathlon', 'Toolathlon', 'agents', null, null, 'pct', 1,
     null, null,
     'Tool use across many real applications.'),
    ('benchcad', 'BenchCAD', 'coding', null, null, 'pct', 1,
     'benchcad', 'BenchCAD',
     'CAD modelling of engineering parts.'),
    ('benchcad-python', 'BenchCAD (python tool)', 'coding', null, null, 'pct', 1,
     'benchcad', 'python tool',
     'CAD modelling of engineering parts, with a Python tool.'),
    ('genebench-pro', 'GeneBench Pro', 'life-sciences', null, null, 'pct', 1,
     null, null,
     'Genomics and gene-analysis tasks.'),
    ('lifescibench', 'LifeSciBench', 'life-sciences', null, null, 'pct', 1,
     null, null,
     'Life-sciences research tasks.'),
    ('ctf-challenges', 'Capture-the-Flag Challenges', 'cyber', null, null, 'pct', 1,
     null, null,
     'Security capture-the-flag tasks.'),
    ('sec-bench-pro', 'SEC-Bench Pro', 'cyber', null, null, 'pct', 1,
     null, null,
     'Finding and fixing security vulnerabilities in real code.'),
    ('exploitgym', 'ExploitGym', 'cyber', null, null, 'pct', 1,
     null, null,
     'Exploit development under a time cap (2 h or 6 h; the cap per row is in its notes where known).'),
    ('mmmu-pro', 'MMMU-Pro (no tools)', 'reasoning', null, null, 'pct', 1,
     'mmmu-pro', 'no tools',
     'Expert-level multimodal (image + text) questions.'),
    ('mmmu-pro-with-tools', 'MMMU-Pro (with tools)', 'reasoning', null, null, 'pct', 1,
     'mmmu-pro', 'with tools',
     'MMMU-Pro with tool use allowed.'),
    ('openai-mrcr-256k', 'OpenAI MRCR v2 (256K–512K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '256K–512K',
     'Long-context retrieval: 8 needles in 256K–512K tokens.'),
    ('openai-mrcr-1m', 'OpenAI MRCR v2 (512K–1M)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '512K–1M',
     'Long-context retrieval: 8 needles in 512K–1M tokens.'),
    ('graphwalks-256k', 'GraphWalks BFS (256K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks', '256K',
     'Breadth-first search over a graph given in 256K tokens (F1).'),
    ('graphwalks-1m', 'GraphWalks BFS (1M)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks', '1M',
     'Breadth-first search over a graph given in 1M tokens (F1).'),
    ('management-consulting-tasks', 'Management Consulting Tasks (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('medchembench', 'MedChemBench (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('research-debugging', 'Research Debugging (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('kernelgen-1p', 'KernelGen 1P (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('nanogpt', 'NanoGPT (OpenAI self-improvement eval)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('posttrainbench-lite', 'PostTrainBench Lite (OpenAI self-improvement eval)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null),
    ('rsi-index', 'RSI Index (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     'OpenAI\'s composite of its self-improvement evaluations.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- agents-last-exam
    ('agents-last-exam', 'GPT-5.5', 46.9, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- big-finance-bench
    ('big-finance-bench', 'GPT-5.6 Sol', 53, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('big-finance-bench', 'GPT-5.6 Terra', 51, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('big-finance-bench', 'GPT-5.6 Luna', 36, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('big-finance-bench', 'GPT-5.5', 49, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- management-consulting-tasks
    ('management-consulting-tasks', 'GPT-5.6 Sol', 43.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('management-consulting-tasks', 'GPT-5.6 Terra', 37.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('management-consulting-tasks', 'GPT-5.6 Luna', 35.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('management-consulting-tasks', 'GPT-5.5', 31.3, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'GPT-5.6 Sol', 64.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('swe-bench-pro', 'GPT-5.6 Terra', 63.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('swe-bench-pro', 'GPT-5.6 Luna', 62.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('swe-bench-pro', 'GPT-5.5', 59.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'GPT-5.6 Terra', 69.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'GPT-5.5', 67, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'DeepSWE v1.1.'),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'GPT-5.6 Sol', 88.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('terminal-bench-2-1', 'GPT-5.6 Sol Ultra', 91.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('terminal-bench-2-1', 'GPT-5.6 Terra', 87.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('terminal-bench-2-1', 'GPT-5.6 Luna', 84.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('terminal-bench-2-1', 'GPT-5.5', 85.6, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- genebench-pro
    ('genebench-pro', 'GPT-5.6 Terra', 23.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('genebench-pro', 'GPT-5.6 Luna', 10.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('genebench-pro', 'GPT-5.5', 12, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('genebench-pro', 'GPT-5.4', 8.87, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- lifescibench
    ('lifescibench', 'GPT-5.6 Terra', 56, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('lifescibench', 'GPT-5.6 Luna', 51.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('lifescibench', 'GPT-5.5', 50.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('lifescibench', 'GPT-5.4', 44.17, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- medchembench
    ('medchembench', 'GPT-5.6 Terra', 35, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('medchembench', 'GPT-5.6 Luna', 30.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('medchembench', 'GPT-5.5', 35.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('medchembench', 'GPT-5.4', 23.98, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- healthbench-professional
    ('healthbench-professional', 'GPT-5.6 Terra', 57.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('healthbench-professional', 'GPT-5.6 Luna', 55.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('healthbench-professional', 'GPT-5.5', 49.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- osworld-2-0
    ('osworld-2-0', 'GPT-5.6 Sol', 62.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('osworld-2-0', 'GPT-5.6 Terra', 50.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('osworld-2-0', 'GPT-5.6 Luna', 45.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('osworld-2-0', 'GPT-5.5', 47.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'GPT-5.6 Sol Ultra', 92.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.6 Terra', 87.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.6 Luna', 83.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('browsecomp', 'GPT-5.5', 84.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- benchcad
    ('benchcad', 'GPT-5.6 Sol', 70.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('benchcad', 'GPT-5.6 Terra', 62.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('benchcad', 'GPT-5.6 Luna', 63.1, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('benchcad', 'GPT-5.5', 44.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- benchcad-python
    ('benchcad-python', 'GPT-5.6 Terra', 78.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('benchcad-python', 'GPT-5.6 Luna', 73.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('benchcad-python', 'GPT-5.5', 55.8, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- ctf-challenges
    ('ctf-challenges', 'GPT-5.6 Sol', 96.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.6 Terra', 91.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.6 Luna', 85.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.5', 88.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('ctf-challenges', 'GPT-5.4', 83.75, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- sec-bench-pro
    ('sec-bench-pro', 'GPT-5.6 Sol Ultra', 74.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('sec-bench-pro', 'GPT-5.6 Terra', 57.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('sec-bench-pro', 'GPT-5.6 Luna', 48.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('sec-bench-pro', 'GPT-5.5', 45.8, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('sec-bench-pro', 'GPT-5.4', 35.93, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- exploitbench
    ('exploitbench', 'GPT-5.6 Terra', 52.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('exploitbench', 'GPT-5.6 Luna', 33.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('exploitbench', 'GPT-5.5', 47.9, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- exploitgym
    ('exploitgym', 'GPT-5.6 Terra', 23.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', '6 h cap (chart).'),
    ('exploitgym', 'GPT-5.6 Luna', 12.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', '6 h cap (chart).'),
    ('exploitgym', 'GPT-5.5', 15.1, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', '2 h cap (chart).'),
    -- research-debugging
    ('research-debugging', 'GPT-5.6 Sol', 68.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('research-debugging', 'GPT-5.6 Terra', 67.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('research-debugging', 'GPT-5.6 Luna', 50.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('research-debugging', 'GPT-5.5', 50, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('research-debugging', 'GPT-5.4', 47.71, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- kernelgen-1p
    ('kernelgen-1p', 'GPT-5.6 Sol', 61.1, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('kernelgen-1p', 'GPT-5.6 Terra', 49.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('kernelgen-1p', 'GPT-5.6 Luna', 22.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('kernelgen-1p', 'GPT-5.5', 29.3, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('kernelgen-1p', 'GPT-5.4', 17.96, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- nanogpt
    ('nanogpt', 'GPT-5.6 Sol', 9.69, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('nanogpt', 'GPT-5.6 Terra', 14.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('nanogpt', 'GPT-5.6 Luna', 1.66, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('nanogpt', 'GPT-5.5', 2.65, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('nanogpt', 'GPT-5.4', 2.3, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- posttrainbench-lite
    ('posttrainbench-lite', 'GPT-5.6 Sol', 50.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('posttrainbench-lite', 'GPT-5.6 Terra', 51.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('posttrainbench-lite', 'GPT-5.6 Luna', 29.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('posttrainbench-lite', 'GPT-5.5', 38.8, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- rsi-index
    ('rsi-index', 'GPT-5.6 Sol', 57.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('rsi-index', 'GPT-5.6 Terra', 56.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('rsi-index', 'GPT-5.6 Luna', 41.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('rsi-index', 'GPT-5.5', 41.7, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('rsi-index', 'GPT-5.4', 36.36, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5.6 Sol', 83, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro', 'GPT-5.6 Terra', 80.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro', 'GPT-5.6 Luna', 78.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro', 'GPT-5.5', 81.2, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- mmmu-pro-with-tools
    ('mmmu-pro-with-tools', 'GPT-5.6 Sol', 84.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro-with-tools', 'GPT-5.6 Terra', 82, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro-with-tools', 'GPT-5.6 Luna', 79.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('mmmu-pro-with-tools', 'GPT-5.5', 83.2, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- gdp-pdf
    ('gdp-pdf', 'GPT-5.6 Sol', 30.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('gdp-pdf', 'GPT-5.6 Terra', 24.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('gdp-pdf', 'GPT-5.6 Luna', 22.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('gdp-pdf', 'GPT-5.5', 26, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.6 Terra', 92.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.6 Luna', 92.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('gpqa-diamond', 'GPT-5.5', 93.6, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- frontiermath-1-3
    ('frontiermath-1-3', 'GPT-5.6 Sol', 89, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 1-3 (v2).'),
    ('frontiermath-1-3', 'GPT-5.6 Terra', 84.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 1-3 (v2).'),
    ('frontiermath-1-3', 'GPT-5.6 Luna', 78.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 1-3 (v2).'),
    ('frontiermath-1-3', 'GPT-5.5', 85.3, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 1-3 (v2).'),
    -- frontiermath-tier-4
    ('frontiermath-tier-4', 'GPT-5.6 Terra', 68.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 4 (v2).'),
    ('frontiermath-tier-4', 'GPT-5.6 Luna', 58.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 4 (v2).'),
    ('frontiermath-tier-4', 'GPT-5.5', 72.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'FrontierMath Tier 4 (v2).'),
    -- automationbench
    ('automationbench', 'GPT-5.6 Terra', 15.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('automationbench', 'GPT-5.5', 12.9, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('automationbench', 'GPT-5.4', 7.6, null, null, 'OpenAI', false, date'2026-03-05', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', 'From the page\'s chart data (best score across effort levels).'),
    -- toolathlon
    ('toolathlon', 'GPT-5.6 Sol', 58, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5.6 Terra', 53.1, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5.6 Luna', 53.4, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('toolathlon', 'GPT-5.5', 55.6, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- openai-mrcr-256k
    ('openai-mrcr-256k', 'GPT-5.6 Terra', 89.6, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('openai-mrcr-256k', 'GPT-5.6 Luna', 41.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('openai-mrcr-256k', 'GPT-5.5', 81.5, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- openai-mrcr-1m
    ('openai-mrcr-1m', 'GPT-5.6 Terra', 72.5, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('openai-mrcr-1m', 'GPT-5.6 Luna', 41.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('openai-mrcr-1m', 'GPT-5.5', 74, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- graphwalks-256k
    ('graphwalks-256k', 'GPT-5.6 Sol', 90.7, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-256k', 'GPT-5.6 Terra', 76.9, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-256k', 'GPT-5.6 Luna', 81.3, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-256k', 'GPT-5.5', 73.7, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- graphwalks-1m
    ('graphwalks-1m', 'GPT-5.6 Sol', 77.1, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-1m', 'GPT-5.6 Terra', 71.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-1m', 'GPT-5.6 Luna', 51.2, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('graphwalks-1m', 'GPT-5.5', 45.4, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    -- arc-agi-3
    ('arc-agi-3', 'GPT-5.6 Terra', 0.8, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('arc-agi-3', 'GPT-5.6 Luna', 0.18, null, null, 'OpenAI', false, date'2026-07-09', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null),
    ('arc-agi-3', 'GPT-5.5', 0.43, null, null, 'OpenAI', false, date'2026-04-23', 'https://openai.com/index/gpt-5-6/', 'vendor_reported', null);
