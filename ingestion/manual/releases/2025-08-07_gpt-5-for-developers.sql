-- Release batch: GPT-5, GPT-5 mini and GPT-5 nano for developers, announced 7 Aug 2025
-- Source: https://openai.com/index/introducing-gpt-5-for-developers/ (7 HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins).
-- Entered: OpenAI's GPT-5-family models only (GPT-5 onwards); older OpenAI models (o3, o4-mini,
-- GPT-4o, GPT-4.1, ChatGPT agent, deep research) and other developers' columns are not.
-- All three GPT-5 models are at high reasoning effort (column headers).
--
-- Benchmark mapping:
--   * Aider polyglot (diff) = Epoch's Aider Polyglot (GPT-5 88.0% on both).
--   * SWE-bench Verified here is on 477 of the 500 problems (noted per row); later pages use 500.
--   * MMMU-Pro here is the average of the standard and vision sets: entered as MMMU-Pro, noted.
--   * New: AIME 2025, HMMT Feb 2025 (maths); MMMU, CharXiv Reasoning, VideoMMMU, ERQA, VideoMME,
--     OpenAI MRCR (2 needles), GraphWalks BFS / parents (<128K), BrowseComp Long Context
--     (reasoning); Scale MultiChallenge, COLLIE (writing); tau2-bench airline / retail /
--     telecom (agents); API instruction following (OpenAI internal, hidden).
--
-- Not entered: SWE-Lancer in dollars earned (the share-solved version on later pages is);
-- hallucination rates ("lower is better").
--
-- Superseded by a later page (the newer value is entered there):
--   * aime-2025, GPT-5: 94.6 here; 94.6 on https://openai.com/index/gpt-5-1-for-developers/
--   * frontiermath-1-3-v1, GPT-5: 26.3 here; 26.3 on https://openai.com/index/gpt-5-1-for-developers/
--   * gpqa-diamond, GPT-5: 85.7 here; 85.7 on https://openai.com/index/gpt-5-1-for-developers/
--   * gpqa-diamond, GPT-5 mini: 82.3 here; 81.6 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * hle-no-tools, GPT-5 mini: 16.7 here; 18.3 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * mmmu, GPT-5: 84.2 here; 84.2 on https://openai.com/index/gpt-5-1-for-developers/
--   * mmmu-pro, GPT-5 mini: 74.1 here; 67.5 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * swe-bench-verified, GPT-5: 74.9 here; 72.8 on https://openai.com/index/gpt-5-1-for-developers/
--   * tau2-airline, GPT-5: 62.6 here; 62.6 on https://openai.com/index/gpt-5-1-for-developers/
--   * tau2-retail, GPT-5: 81.1 here; 81.1 on https://openai.com/index/gpt-5-1-for-developers/
--   * tau2-telecom, GPT-5: 96.7 here; 96.7 on https://openai.com/index/gpt-5-1-for-developers/
--   * tau2-telecom, GPT-5 mini: 74.1 here; 74.1 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * graphwalks-bfs-128k, GPT-5 mini: 73.4 here; 73.4 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * graphwalks-parents-128k, GPT-5 mini: 64.3 here; 64.3 on https://openai.com/index/introducing-gpt-5-4-mini-and-nano/
--   * browsecomp-lc-128k, GPT-5: 90.0 here; 90.0 on https://openai.com/index/gpt-5-1-for-developers/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('aime-2025', 'AIME 2025', 'maths', null, null, 'pct', 1,
     null, null,
     'American Invitational Mathematics Examination 2025, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hmmt-feb-2025', 'HMMT February 2025', 'maths', null, null, 'pct', 1,
     null, null,
     'Harvard-MIT Mathematics Tournament, February 2025, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mmmu', 'MMMU', 'reasoning', null, null, 'pct', 1,
     null, null,
     'College-level multimodal (image + text) problems.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('charxiv-reasoning', 'CharXiv Reasoning (no tools)', 'reasoning', null, null, 'pct', 1,
     'charxiv', 'no tools',
     'Reasoning about charts in scientific papers.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('charxiv-reasoning-python', 'CharXiv Reasoning (with Python)', 'reasoning', null, null, 'pct', 1,
     'charxiv', 'with Python',
     'CharXiv Reasoning with a Python tool.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('videommmu', 'VideoMMMU', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Video-based multimodal reasoning (up to 256 frames).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('erqa', 'ERQA', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Multimodal spatial (embodied) reasoning.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('videomme', 'VideoMME (long, with subtitles)', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Long-video understanding, with subtitles.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('scale-multichallenge', 'Scale MultiChallenge', 'writing', 'Scale AI', null, 'pct', 1,
     null, null,
     'Multi-turn conversations: keeping instructions and context across turns.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('collie', 'COLLIE', 'writing', null, null, 'pct', 1,
     null, null,
     'Following constraints in free-form writing.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('tau2-airline', 'τ²-bench (airline)', 'agents', 'Sierra', null, 'pct', 1,
     'tau2-bench', 'airline',
     'Customer-support agent with tools, airline domain.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('tau2-retail', 'τ²-bench (retail)', 'agents', 'Sierra', null, 'pct', 1,
     'tau2-bench', 'retail',
     'Customer-support agent with tools, retail domain.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('tau2-telecom', 'τ²-bench (telecom)', 'agents', 'Sierra', null, 'pct', 1,
     'tau2-bench', 'telecom',
     'Customer-support agent with tools, telecom domain.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-2needle-128k', 'OpenAI MRCR (2 needles, 128K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr-2needle', '128K',
     'Long-context retrieval: 2 needles in 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-2needle-256k', 'OpenAI MRCR (2 needles, 256K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'openai-mrcr-2needle', '256K',
     'Long-context retrieval: 2 needles in 256K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-bfs-128k', 'GraphWalks BFS (<128K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks', '<128K',
     'Breadth-first search over a graph given in under 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-128k', 'GraphWalks parents (<128K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '<128K',
     'Finding a node\'s parents in a graph given in under 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-lc-128k', 'BrowseComp Long Context (128K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'browsecomp-lc', '128K',
     'Answering from 128K tokens of supplied web pages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-lc-256k', 'BrowseComp Long Context (256K)', 'reasoning', 'OpenAI', null, 'pct', 1,
     'browsecomp-lc', '256K',
     'Answering from 256K tokens of supplied web pages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('api-instruction-following', 'API Instruction Following (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- aime-2025
    ('aime-2025', 'GPT-5 mini', 91.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('aime-2025', 'GPT-5 nano', 85.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5 mini', 22.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'With Python.'),
    ('frontiermath-1-3-v1', 'GPT-5 nano', 9.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'With Python.'),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5 nano', 71.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'GPT-5', 24.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('hle-no-tools', 'GPT-5 nano', 8.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'GPT-5', 93.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('hmmt-feb-2025', 'GPT-5 mini', 87.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('hmmt-feb-2025', 'GPT-5 nano', 75.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- mmmu
    ('mmmu', 'GPT-5 mini', 81.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('mmmu', 'GPT-5 nano', 75.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5', 78.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'Average of the standard and vision sets.'),
    ('mmmu-pro', 'GPT-5 nano', 62.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'Average of the standard and vision sets.'),
    -- charxiv-reasoning-python
    ('charxiv-reasoning-python', 'GPT-5', 81.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('charxiv-reasoning-python', 'GPT-5 mini', 75.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('charxiv-reasoning-python', 'GPT-5 nano', 62.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- videommmu
    ('videommmu', 'GPT-5', 84.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('videommmu', 'GPT-5 mini', 82.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('videommmu', 'GPT-5 nano', 66.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- erqa
    ('erqa', 'GPT-5', 65.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('erqa', 'GPT-5 mini', 62.9, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('erqa', 'GPT-5 nano', 50.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- swe-bench-verified
    ('swe-bench-verified', 'GPT-5 mini', 71.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', '477 of the 500 problems.'),
    ('swe-bench-verified', 'GPT-5 nano', 54.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', '477 of the 500 problems.'),
    -- aider-polyglot
    ('aider-polyglot', 'GPT-5', 88.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'Diff format.'),
    ('aider-polyglot', 'GPT-5 mini', 71.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'Diff format.'),
    ('aider-polyglot', 'GPT-5 nano', 48.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'Diff format.'),
    -- scale-multichallenge
    ('scale-multichallenge', 'GPT-5', 69.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'o3-mini grader.'),
    ('scale-multichallenge', 'GPT-5 mini', 62.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'o3-mini grader.'),
    ('scale-multichallenge', 'GPT-5 nano', 54.9, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', 'o3-mini grader.'),
    -- api-instruction-following
    ('api-instruction-following', 'GPT-5', 64.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('api-instruction-following', 'GPT-5 mini', 65.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('api-instruction-following', 'GPT-5 nano', 56.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- collie
    ('collie', 'GPT-5', 99.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('collie', 'GPT-5 mini', 98.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('collie', 'GPT-5 nano', 96.9, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- tau2-airline
    ('tau2-airline', 'GPT-5 mini', 60.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('tau2-airline', 'GPT-5 nano', 41.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- tau2-retail
    ('tau2-retail', 'GPT-5 mini', 78.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('tau2-retail', 'GPT-5 nano', 62.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'GPT-5 nano', 35.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- openai-mrcr-2needle-128k
    ('openai-mrcr-2needle-128k', 'GPT-5', 95.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('openai-mrcr-2needle-128k', 'GPT-5 mini', 84.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('openai-mrcr-2needle-128k', 'GPT-5 nano', 43.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- openai-mrcr-2needle-256k
    ('openai-mrcr-2needle-256k', 'GPT-5', 86.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('openai-mrcr-2needle-256k', 'GPT-5 mini', 58.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('openai-mrcr-2needle-256k', 'GPT-5 nano', 34.9, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- graphwalks-bfs-128k
    ('graphwalks-bfs-128k', 'GPT-5', 78.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('graphwalks-bfs-128k', 'GPT-5 nano', 64.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- graphwalks-parents-128k
    ('graphwalks-parents-128k', 'GPT-5', 73.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('graphwalks-parents-128k', 'GPT-5 nano', 43.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- browsecomp-lc-128k
    ('browsecomp-lc-128k', 'GPT-5 mini', 89.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('browsecomp-lc-128k', 'GPT-5 nano', 80.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- browsecomp-lc-256k
    ('browsecomp-lc-256k', 'GPT-5', 88.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('browsecomp-lc-256k', 'GPT-5 mini', 86.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('browsecomp-lc-256k', 'GPT-5 nano', 68.4, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    -- videomme
    ('videomme', 'GPT-5', 86.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('videomme', 'GPT-5 mini', 78.5, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null),
    ('videomme', 'GPT-5 nano', 65.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/introducing-gpt-5-for-developers/', 'vendor_reported', null);
