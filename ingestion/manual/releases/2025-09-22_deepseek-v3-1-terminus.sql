-- Release batch: DeepSeek-V3.1-Terminus, released 22 Sep 2025
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus (model card, Markdown table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V3.1 and V3.1-Terminus.
-- LiveCodeBench = the 2408-2505 window (V3.1's 74.8% is the same figure as on its own card);
-- Terminal-bench = 1.0.
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
--
-- Superseded by a later page (the newer value is entered there):
--   * mmlu-pro, DeepSeek-V3.1-Terminus: 85.0 here; 85.0 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * gpqa-diamond, DeepSeek-V3.1-Terminus: 80.7 here; 80.7 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * hle-no-tools, DeepSeek-V3.1-Terminus: 21.7 here; 21.7 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * livecodebench-2408-2505, DeepSeek-V3.1-Terminus: 74.9 here; 74.9 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * codeforces, DeepSeek-V3.1-Terminus: 2046 here; 2046 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * aider-polyglot, DeepSeek-V3.1-Terminus: 76.1 here; 76.1 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * browsecomp, DeepSeek-V3.1-Terminus: 38.5 here; 38.5 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * browsecomp-zh, DeepSeek-V3.1-Terminus: 45.0 here; 45.0 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * simpleqa, DeepSeek-V3.1-Terminus: 96.8 here; 96.8 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * swe-bench-verified, DeepSeek-V3.1-Terminus: 68.4 here; 68.4 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * swe-bench-multilingual, DeepSeek-V3.1-Terminus: 57.8 here; 57.8 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp
--   * terminal-bench-1, DeepSeek-V3.1-Terminus: 36.7 here; 36.7 on https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- mmlu-pro
    ('mmlu-pro', 'DeepSeek-V3.1', 84.8, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'DeepSeek-V3.1', 80.1, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'DeepSeek-V3.1', 15.9, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- livecodebench-2408-2505
    ('livecodebench-2408-2505', 'DeepSeek-V3.1', 74.8, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'DeepSeek-V3.1', 2091, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- aider-polyglot
    ('aider-polyglot', 'DeepSeek-V3.1', 76.3, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'DeepSeek-V3.1', 30.0, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- browsecomp-zh
    ('browsecomp-zh', 'DeepSeek-V3.1', 49.2, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- simpleqa
    ('simpleqa', 'DeepSeek-V3.1', 93.4, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- swe-bench-verified
    ('swe-bench-verified', 'DeepSeek-V3.1', 66.0, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- swe-bench-multilingual
    ('swe-bench-multilingual', 'DeepSeek-V3.1', 54.5, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null),
    -- terminal-bench-1
    ('terminal-bench-1', 'DeepSeek-V3.1', 31.3, null, null, 'DeepSeek', true, date'2025-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus', 'vendor_reported', null);
