-- Release batch: DeepSeek-V3.1, released 21 Aug 2025
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V3.1 (model card, Markdown table; read 14 Nov 2026). The release note
-- (https://api-docs.deepseek.com/news/news250821) shows the same evaluation as images.
-- Entered: 14 Nov 2026, DeepSeek backfill (one batch per release, release order; newest wins).
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
--   * The card reports a non-thinking and a thinking mode; our data has one model, so each
--     benchmark takes the better mode (noted per row), like "highest available effort".
--   * Terminal-bench here is version 1.0 (Terminus 1 framework, Aug 2025): new terminal-bench-1.
--   * LiveCodeBench (2408-2505) is a problem window of its own: new, in the livecodebench family.
--   * New: MMLU-Redux (science), SWE-bench Multilingual (coding), AIME 2024 (maths).
--     Codeforces-Div1 rating = the Codeforces benchmark (rating, index).
--
-- Superseded by a later page (the newer value is entered there):
--   * mmlu-pro, DeepSeek-V3.1: 84.8 here; 84.8 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * gpqa-diamond, DeepSeek-V3.1: 80.1 here; 80.1 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * hle-no-tools, DeepSeek-V3.1: 15.9 here; 15.9 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * browsecomp, DeepSeek-V3.1: 30.0 here; 30.0 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * browsecomp-zh, DeepSeek-V3.1: 49.2 here; 49.2 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * simpleqa, DeepSeek-V3.1: 93.4 here; 93.4 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * livecodebench-2408-2505, DeepSeek-V3.1: 74.8 here; 74.8 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * codeforces, DeepSeek-V3.1: 2091 here; 2091 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * aider-polyglot, DeepSeek-V3.1: 76.3 here; 76.3 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * swe-bench-verified, DeepSeek-V3.1: 66.0 here; 66.0 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * swe-bench-multilingual, DeepSeek-V3.1: 54.5 here; 54.5 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus
--   * terminal-bench-1, DeepSeek-V3.1: 31.3 here; 31.3 on https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mmlu-redux', 'MMLU-Redux', 'science', null, null, 'pct', 1,
     null, null,
     'MMLU with corrected questions.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('swe-bench-multilingual', 'SWE-bench Multilingual', 'coding', null, null, 'pct', 1,
     null, null,
     'SWE-bench-style tasks across nine programming languages.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-1', 'Terminal-Bench 1.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '1.0',
     'Agentic coding in a terminal, version 1.0.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('aime-2024', 'AIME 2024', 'maths', null, null, 'pct', 1,
     null, null,
     'American Invitational Mathematics Examination 2024, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('livecodebench-2408-2505', 'LiveCodeBench (Aug 2024–May 2025)', 'coding', null, null, 'pct', 1,
     'livecodebench', 'Aug 2024–May 2025',
     'Code generation, problems published Aug 2024 to May 2025.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- mmlu-redux
    ('mmlu-redux', 'DeepSeek-V3.1', 93.7, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1', 'vendor_reported', 'Thinking mode.'),
    -- hle-with-tools
    ('hle-with-tools', 'DeepSeek-V3.1', 29.8, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1', 'vendor_reported', 'Python and search.'),
    -- aime-2024
    ('aime-2024', 'DeepSeek-V3.1', 93.1, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1', 'vendor_reported', 'Thinking mode.'),
    -- aime-2025
    ('aime-2025', 'DeepSeek-V3.1', 88.4, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1', 'vendor_reported', 'Thinking mode.'),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'DeepSeek-V3.1', 84.2, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1', 'vendor_reported', 'Thinking mode.');
