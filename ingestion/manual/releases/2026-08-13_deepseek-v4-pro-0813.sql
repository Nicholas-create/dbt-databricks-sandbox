-- Release batch: DeepSeek-V4-Pro GA (V4-Pro-0813), released 13 Aug 2026
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813 (model card, Markdown table; read 14 Nov 2026).
-- Release note: https://api-docs.deepseek.com/news/news260813.
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V4-Pro-0813, V4-Flash-0731 and the
-- V4 previews. HLE "wo / w tools" = hle-no-tools / hle-with-tools.
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-with-tools, DeepSeek V4 Pro 0813: 60.0 here; 60.0 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * hle-with-tools, DeepSeek V4 Flash 0731: 51.5 here; 51.5 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * terminal-bench-2-1, DeepSeek V4 Pro 0813: 87.9 here; 87.9 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * terminal-bench-2-1, DeepSeek V4 Flash 0731: 82.7 here; 82.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * nl2repo, DeepSeek V4 Pro 0813: 61.5 here; 61.5 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * nl2repo, DeepSeek V4 Flash 0731: 54.2 here; 54.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * cybergym, DeepSeek V4 Pro 0813: 83.3 here; 83.3 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * cybergym, DeepSeek V4 Flash 0731: 76.7 here; 76.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * deepswe, DeepSeek V4 Pro 0813: 62.7 here; 62.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * deepswe, DeepSeek V4 Flash 0731: 54.4 here; 54.4 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * toolathlon-verified, DeepSeek V4 Flash 0731: 70.3 here; 70.3 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp
--   * agents-last-exam-pass-rate, DeepSeek V4 Pro 0813: 25.7 here; 25.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * agents-last-exam-pass-rate, DeepSeek V4 Flash 0731: 25.2 here; 25.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * automationbench-public, DeepSeek V4 Flash 0731: 25.1 here; 25.1 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp
--   * dsbench-hard, DeepSeek V4 Flash 0731: 59.6 here; 59.6 on https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- hle-no-tools
    ('hle-no-tools', 'DeepSeek V4 Pro 0813', 42.7, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek V4 Flash 0731', 37.8, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek-V4-Pro', 37.7, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek-V4-Flash', 34.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'DeepSeek-V4-Pro', 48.2, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('hle-with-tools', 'DeepSeek-V4-Flash', 45.1, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'DeepSeek-V4-Pro', 72.1, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('terminal-bench-2-1', 'DeepSeek-V4-Flash', 61.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- nl2repo
    ('nl2repo', 'DeepSeek-V4-Pro', 38.5, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('nl2repo', 'DeepSeek-V4-Flash', 39.4, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- cybergym
    ('cybergym', 'DeepSeek-V4-Pro', 52.7, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('cybergym', 'DeepSeek-V4-Flash', 38.7, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'DeepSeek-V4-Pro', 12.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('deepswe', 'DeepSeek-V4-Flash', 7.3, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- toolathlon-verified
    ('toolathlon-verified', 'DeepSeek V4 Pro 0813', 74.1, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('toolathlon-verified', 'DeepSeek-V4-Pro', 55.9, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('toolathlon-verified', 'DeepSeek-V4-Flash', 49.7, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'DeepSeek-V4-Pro', 16.5, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('agents-last-exam-pass-rate', 'DeepSeek-V4-Flash', 15.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- automationbench-public
    ('automationbench-public', 'DeepSeek V4 Pro 0813', 31.8, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('automationbench-public', 'DeepSeek-V4-Pro', 12.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('automationbench-public', 'DeepSeek-V4-Flash', 10.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- dsbench-fullstack
    ('dsbench-fullstack', 'DeepSeek V4 Pro 0813', 71.1, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('dsbench-fullstack', 'DeepSeek V4 Flash 0731', 68.7, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('dsbench-fullstack', 'DeepSeek-V4-Pro', 41.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('dsbench-fullstack', 'DeepSeek-V4-Flash', 37.0, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    -- dsbench-hard
    ('dsbench-hard', 'DeepSeek V4 Pro 0813', 67.2, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('dsbench-hard', 'DeepSeek-V4-Pro', 31.1, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null),
    ('dsbench-hard', 'DeepSeek-V4-Flash', 25.8, null, null, 'DeepSeek', true, date'2026-04-24', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813', 'vendor_reported', null);
