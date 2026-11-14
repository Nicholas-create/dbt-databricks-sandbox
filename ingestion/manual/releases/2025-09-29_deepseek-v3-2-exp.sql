-- Release batch: DeepSeek-V3.2-Exp, released 29 Sep 2025
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp (model card, Markdown table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V3.1-Terminus and V3.2-Exp.
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- mmlu-pro
    ('mmlu-pro', 'DeepSeek-V3.1-Terminus', 85.0, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('mmlu-pro', 'DeepSeek-V3.2-Exp', 85.0, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'DeepSeek-V3.1-Terminus', 80.7, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('gpqa-diamond', 'DeepSeek-V3.2-Exp', 79.9, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'DeepSeek-V3.1-Terminus', 21.7, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek-V3.2-Exp', 19.8, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- livecodebench-2408-2505
    ('livecodebench-2408-2505', 'DeepSeek-V3.1-Terminus', 74.9, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('livecodebench-2408-2505', 'DeepSeek-V3.2-Exp', 74.1, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- aime-2025
    ('aime-2025', 'DeepSeek-V3.1-Terminus', 88.4, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('aime-2025', 'DeepSeek-V3.2-Exp', 89.3, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'DeepSeek-V3.1-Terminus', 86.1, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('hmmt-feb-2025', 'DeepSeek-V3.2-Exp', 83.6, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'DeepSeek-V3.1-Terminus', 2046, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('codeforces', 'DeepSeek-V3.2-Exp', 2121, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- aider-polyglot
    ('aider-polyglot', 'DeepSeek-V3.1-Terminus', 76.1, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('aider-polyglot', 'DeepSeek-V3.2-Exp', 74.5, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'DeepSeek-V3.1-Terminus', 38.5, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('browsecomp', 'DeepSeek-V3.2-Exp', 40.1, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- browsecomp-zh
    ('browsecomp-zh', 'DeepSeek-V3.1-Terminus', 45.0, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('browsecomp-zh', 'DeepSeek-V3.2-Exp', 47.9, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- simpleqa
    ('simpleqa', 'DeepSeek-V3.1-Terminus', 96.8, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('simpleqa', 'DeepSeek-V3.2-Exp', 97.1, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- swe-bench-verified
    ('swe-bench-verified', 'DeepSeek-V3.1-Terminus', 68.4, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('swe-bench-verified', 'DeepSeek-V3.2-Exp', 67.8, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- swe-bench-multilingual
    ('swe-bench-multilingual', 'DeepSeek-V3.1-Terminus', 57.8, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('swe-bench-multilingual', 'DeepSeek-V3.2-Exp', 57.9, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    -- terminal-bench-1
    ('terminal-bench-1', 'DeepSeek-V3.1-Terminus', 36.7, null, null, 'DeepSeek', true, date'2025-09-22', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null),
    ('terminal-bench-1', 'DeepSeek-V3.2-Exp', 37.7, null, null, 'DeepSeek', true, date'2025-09-29', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp', 'vendor_reported', null);
