-- Definition change (not a release), 14 Nov 2026: OpenAI backfill, final definitions
-- A split pill orders its versions by when each definition was last entered. Benchmarks that
-- gained versions in this backfill are entered again here, unchanged, in the order the pill
-- should read; this file is dated last so the order holds however the batches are replayed.
-- Also:
--   * ctf-challenges moves to the hidden 'internal' category: OpenAI labels it "Internal" on the
--     GPT-5.5 page and only OpenAI models are ever scored on it.
--   * Long-context benchmarks (OpenAI MRCR, GraphWalks, BrowseComp Long Context) move from
--     Reasoning to a new Long context category: OpenAI's pages give them their own section, and
--     with eight MRCR context lengths they had taken over the Reasoning tab.
--   * The osworld family is entered again in version order (2.0 offline had landed last).
--   * hle-no-tools: notes reworded; it now holds every developer's no-tools runs, not only
--     Anthropic's (they differ from Epoch's HLE runs, e.g. GPT-5.4 39.8% vs 36.2%).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hle-no-tools', 'Humanity\'s Last Exam (no tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'no tools',
     'Developers\' own runs without tools; they differ from Epoch\'s Humanity\'s Last Exam runs, so kept separate.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hle-with-tools', 'Humanity\'s Last Exam (with tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'with tools',
     'Same questions as Humanity\'s Last Exam, with tool use allowed.');

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
    ('healthbench-professional', 'HealthBench Professional', 'life-sciences', 'OpenAI', null, 'pct', 1,
     'healthbench', 'Professional',
     'Health conversations graded against physician-written rubrics, professional set.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('screenspot-pro', 'ScreenSpot-Pro', 'agents', null, null, 'pct', 1,
     'screenspot-pro', 'ScreenSpot-Pro',
     'Locating interface elements in high-resolution screenshots (no tools).');

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
    ('graphwalks-bfs-128k', 'GraphWalks BFS (<128K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks', '<128K',
     'Breadth-first search over a graph given in under 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-256k', 'GraphWalks BFS (256K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks', '256K',
     'Breadth-first search over a graph given in 256K tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-1m', 'GraphWalks BFS (1M)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks', '1M',
     'Breadth-first search over a graph given in 1M tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-bfs-256k-1m', 'GraphWalks BFS (256K–1M)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks', '256K–1M',
     'Breadth-first search over a graph given in 256K–1M tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-128k', 'GraphWalks parents (<128K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '<128K',
     'Finding a node\'s parents in a graph given in under 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-256k', 'GraphWalks parents (256K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '256K',
     'Finding a node\'s parents in a graph given in 256K tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-1m', 'GraphWalks parents (1M)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '1M',
     'Finding a node\'s parents in a graph given in 1M tokens (F1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('graphwalks-parents-256k-1m', 'GraphWalks parents (256K–1M)', 'long-context', 'OpenAI', null, 'pct', 1,
     'graphwalks-parents', '256K–1M',
     'Finding a node\'s parents in a graph given in 256K–1M tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-4k-8k', 'OpenAI MRCR v2 (4K–8K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '4K–8K',
     'Long-context retrieval: 8 needles in 4K–8K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-8k-16k', 'OpenAI MRCR v2 (8K–16K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '8K–16K',
     'Long-context retrieval: 8 needles in 8K–16K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-16k-32k', 'OpenAI MRCR v2 (16K–32K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '16K–32K',
     'Long-context retrieval: 8 needles in 16K–32K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-32k-64k', 'OpenAI MRCR v2 (32K–64K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '32K–64K',
     'Long-context retrieval: 8 needles in 32K–64K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-64k-128k', 'OpenAI MRCR v2 (64K–128K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '64K–128K',
     'Long-context retrieval: 8 needles in 64K–128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-128k-256k', 'OpenAI MRCR v2 (128K–256K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '128K–256K',
     'Long-context retrieval: 8 needles in 128K–256K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-256k', 'OpenAI MRCR v2 (256K–512K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '256K–512K',
     'Long-context retrieval: 8 needles in 256K–512K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-1m', 'OpenAI MRCR v2 (512K–1M)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr', '512K–1M',
     'Long-context retrieval: 8 needles in 512K–1M tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-2needle-128k', 'OpenAI MRCR (2 needles, 128K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr-2needle', '128K',
     'Long-context retrieval: 2 needles in 128K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('openai-mrcr-2needle-256k', 'OpenAI MRCR (2 needles, 256K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'openai-mrcr-2needle', '256K',
     'Long-context retrieval: 2 needles in 256K tokens.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-lc-128k', 'BrowseComp Long Context (128K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'browsecomp-lc', '128K',
     'Answering from 128K tokens of supplied web pages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-lc-256k', 'BrowseComp Long Context (256K)', 'long-context', 'OpenAI', null, 'pct', 1,
     'browsecomp-lc', '256K',
     'Answering from 256K tokens of supplied web pages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-verified', 'OSWorld-Verified', 'agents', null, null, 'pct', 1,
     'osworld', 'Verified',
     'Computer use, verified task set.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-0', 'OSWorld 2.0', 'agents', null, null, 'pct', 1,
     'osworld', '2.0',
     'Computer use; the original 2.0 task release.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-0-offline', 'OSWorld 2.0 (offline set)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 offline',
     'Computer use, OSWorld 2.0 v2026.08.08 offline set, partial score.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-0-aug', 'OSWorld 2.0 (Aug 2026 tasks)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 Aug',
     'Computer use, August 2026 task release, partial credit; not comparable with earlier OSWorld 2.0 results.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-0-aug-strict', 'OSWorld 2.0 (Aug 2026 tasks, strict)', 'agents', null, null, 'pct', 1,
     'osworld', '2.0 Aug strict',
     'Computer use, August 2026 task release, strict scoring (no partial credit).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-1-full', 'OSWorld 2.1', 'agents', null, null, 'pct', 1,
     'osworld', '2.1',
     'Computer use, version 2.1, partial credit; no subset named (the offline-set results are osworld-2-1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-1', 'OSWorld 2.1 (offline set)', 'agents', null, null, 'pct', 1,
     'osworld', '2.1 offline',
     'Computer use, version 2.1, offline set, partial credit.');

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
    ('genebench-pro', 'GeneBench Pro', 'life-sciences', null, null, 'pct', 1,
     'genebench', 'Pro',
     'Harder genomics and gene-analysis tasks.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('ctf-challenges', 'Capture-the-Flag Challenges (OpenAI internal)', 'internal', 'OpenAI', null, 'pct', 1,
     null, null,
     'OpenAI\'s internal professional-level capture-the-flag evaluation; the task set changes over time.');

