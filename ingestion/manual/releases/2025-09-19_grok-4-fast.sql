-- Release batch: Grok 4 Fast, announced 19 Sep 2025
-- Source: https://x.ai/news/grok-4-fast (HTML tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill (newest page wins). Grok 4 Fast and Grok 4.
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
--   * SimpleQA (the original) is not SimpleQA Verified (Epoch's): new simpleqa.
--   * BrowseComp (zh) is the Chinese version of BrowseComp: new, in a browsecomp family.
--   * New: Research-Eval (Reka), X Bench DeepSearch (zh) (agents). X Browse (asterisked) is
--     xAI's own evaluation: hidden 'internal' category.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('simpleqa', 'SimpleQA', 'science', 'OpenAI', null, 'pct', 1,
     null, null,
     'Short factual questions (the original set, not SimpleQA Verified).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-zh', 'BrowseComp (zh)', 'agents', null, null, 'pct', 1,
     'browsecomp', 'zh',
     'Chinese-language BrowseComp.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('research-eval-reka', 'Research-Eval (Reka)', 'agents', 'Reka', null, 'pct', 1,
     null, null,
     'Agentic research questions.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('xbench-deepsearch', 'xbench DeepSearch (zh)', 'agents', null, null, 'pct', 1,
     null, null,
     'Chinese deep-search agent tasks.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('x-browse', 'X Browse (xAI internal)', 'internal', 'xAI', null, 'pct', 1,
     null, null,
     null);

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gpqa-diamond
    ('gpqa-diamond', 'Grok 4 Fast', 85.7, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('gpqa-diamond', 'Grok 4', 87.5, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- aime-2025
    ('aime-2025', 'Grok 4 Fast', 92.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('aime-2025', 'Grok 4', 91.7, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'Grok 4 Fast', 93.3, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('hmmt-feb-2025', 'Grok 4', 90.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Grok 4 Fast', 20.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('hle-no-tools', 'Grok 4', 25.4, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- livecodebench-2025
    ('livecodebench-2025', 'Grok 4 Fast', 80.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', 'LiveCodeBench (Jan-May).'),
    ('livecodebench-2025', 'Grok 4', 79.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', 'LiveCodeBench (Jan-May).'),
    -- browsecomp
    ('browsecomp', 'Grok 4 Fast', 44.9, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('browsecomp', 'Grok 4', 43.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- simpleqa
    ('simpleqa', 'Grok 4 Fast', 95.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('simpleqa', 'Grok 4', 94.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- research-eval-reka
    ('research-eval-reka', 'Grok 4 Fast', 66.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('research-eval-reka', 'Grok 4', 58.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- browsecomp-zh
    ('browsecomp-zh', 'Grok 4 Fast', 51.2, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('browsecomp-zh', 'Grok 4', 45.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- xbench-deepsearch
    ('xbench-deepsearch', 'Grok 4 Fast', 74.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('xbench-deepsearch', 'Grok 4', 66.0, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    -- x-browse
    ('x-browse', 'Grok 4 Fast', 58.0, null, null, 'xAI', false, date'2025-09-19', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null),
    ('x-browse', 'Grok 4', 53.2, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-fast', 'vendor_reported', null);
