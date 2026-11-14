-- Release batch: DeepSeek-V4-Pro and DeepSeek-V4-Flash (Preview), released 24 Apr 2026
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro (model card, Markdown tables; the V4-Flash card carries the same
-- tables; read 14 Nov 2026). Release note: https://api-docs.deepseek.com/news/news260424.
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). Each model at its best reasoning mode
-- (Max, except MCP Atlas, where V4-Pro High scores higher).
--   * Apex = MathArena Apex (Gemini 3.1 Pro 60.9%); Apex Shortlist is new, in its family.
--   * "MRCR 1M (MMR)" is not Google's MRCR set-up (Gemini 3.1 Pro 76.3% vs 26.3%): new
--     mrcr-1m-deepseek (Long context), with CorpusQA 1M.
--   * New: Chinese-SimpleQA (science), HMMT Feb 2026 (maths).
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
-- Also not entered: LiveCodeBench (problem window not stated).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, DeepSeek-V4-Pro: 37.7 here; 37.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813
--   * hle-no-tools, DeepSeek-V4-Flash: 34.8 here; 34.8 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813
--   * hle-with-tools, DeepSeek-V4-Pro: 48.2 here; 48.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813
--   * hle-with-tools, DeepSeek-V4-Flash: 45.1 here; 45.1 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('chinese-simpleqa', 'Chinese SimpleQA', 'science', null, null, 'pct', 1,
     null, null,
     'Short factual questions in Chinese.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hmmt-feb-2026', 'HMMT February 2026', 'maths', null, null, 'pct', 1,
     'hmmt', 'Feb 2026',
     'Harvard-MIT Mathematics Tournament, February 2026, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('matharena-apex-shortlist', 'MathArena Apex (Shortlist)', 'maths', null, null, 'pct', 1,
     'matharena-apex', 'Shortlist',
     'The shortlist of MathArena Apex candidate problems.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mrcr-1m-deepseek', 'MRCR 1M (DeepSeek set-up)', 'long-context', null, null, 'pct', 1,
     null, null,
     'Multi-round coreference at 1M tokens, as run by DeepSeek (MMR).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('corpusqa-1m', 'CorpusQA 1M', 'long-context', null, null, 'pct', 1,
     null, null,
     'Question answering over a 1M-token corpus.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- mmlu-pro
    ('mmlu-pro', 'DeepSeek-V4-Pro', 87.5, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('mmlu-pro', 'DeepSeek-V4-Flash', 86.4, null, 'high', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- simpleqa-verified
    ('simpleqa-verified', 'DeepSeek-V4-Pro', 57.9, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('simpleqa-verified', 'DeepSeek-V4-Flash', 34.1, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- chinese-simpleqa
    ('chinese-simpleqa', 'DeepSeek-V4-Pro', 84.4, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('chinese-simpleqa', 'DeepSeek-V4-Flash', 78.9, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'DeepSeek-V4-Pro', 90.1, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('gpqa-diamond', 'DeepSeek-V4-Flash', 88.1, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'DeepSeek-V4-Pro', 3206, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('codeforces', 'DeepSeek-V4-Flash', 3052, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- hmmt-feb-2026
    ('hmmt-feb-2026', 'DeepSeek-V4-Pro', 95.2, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('hmmt-feb-2026', 'DeepSeek-V4-Flash', 94.8, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- imo-answerbench
    ('imo-answerbench', 'DeepSeek-V4-Pro', 89.8, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('imo-answerbench', 'DeepSeek-V4-Flash', 88.4, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- matharena-apex
    ('matharena-apex', 'DeepSeek-V4-Pro', 38.3, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('matharena-apex', 'DeepSeek-V4-Flash', 33.0, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- matharena-apex-shortlist
    ('matharena-apex-shortlist', 'DeepSeek-V4-Pro', 90.2, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('matharena-apex-shortlist', 'DeepSeek-V4-Flash', 85.7, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- mrcr-1m-deepseek
    ('mrcr-1m-deepseek', 'DeepSeek-V4-Pro', 83.5, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('mrcr-1m-deepseek', 'DeepSeek-V4-Flash', 78.7, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- corpusqa-1m
    ('corpusqa-1m', 'DeepSeek-V4-Pro', 62.0, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('corpusqa-1m', 'DeepSeek-V4-Flash', 60.5, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- terminal-bench
    ('terminal-bench', 'DeepSeek-V4-Pro', 67.9, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', 'Terminal Bench 2.0.'),
    ('terminal-bench', 'DeepSeek-V4-Flash', 56.9, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', 'Terminal Bench 2.0.'),
    -- swe-bench-verified
    ('swe-bench-verified', 'DeepSeek-V4-Pro', 80.6, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('swe-bench-verified', 'DeepSeek-V4-Flash', 79.0, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'DeepSeek-V4-Pro', 55.4, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('swe-bench-pro', 'DeepSeek-V4-Flash', 52.6, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- swe-bench-multilingual
    ('swe-bench-multilingual', 'DeepSeek-V4-Pro', 76.2, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('swe-bench-multilingual', 'DeepSeek-V4-Flash', 73.3, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'DeepSeek-V4-Pro', 83.4, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('browsecomp', 'DeepSeek-V4-Flash', 73.2, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'DeepSeek-V4-Pro', 74.2, null, 'high', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('mcp-atlas', 'DeepSeek-V4-Flash', 69.0, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'DeepSeek-V4-Pro', 51.8, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null),
    ('toolathlon', 'DeepSeek-V4-Flash', 47.8, null, 'max', 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro', 'vendor_reported', null);
