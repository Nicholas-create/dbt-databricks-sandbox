-- Release batch: DeepSeek-V4-Flash-Vision-Exp, released 21 Aug 2026
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp (model card, Markdown table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V4-Flash-Vision-Exp and V4-Flash-0731
-- (text agent rows).
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
-- Also not entered: ApexBench (version not stated; Opus 4.8 39.4% doesn't match APEX-Agents'
-- 48.9%); Chartography and ZeroBench (tool set-up not stated; later cards mark "w/ tools");
-- V4-Flash-0731 cells marked with a dagger.
--
-- Superseded by a later page (the newer value is entered there):
--   * terminal-bench-2-1, DeepSeek V4 Flash 0731: 82.7 here; 82.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * nl2repo, DeepSeek V4 Flash 0731: 54.2 here; 54.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * cybergym, DeepSeek V4 Flash 0731: 76.7 here; 76.7 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
--   * deepswe, DeepSeek V4 Flash 0731: 54.4 here; 54.4 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'DeepSeek-V4-Flash-Vision-Exp', 83.9, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- nl2repo
    ('nl2repo', 'DeepSeek-V4-Flash-Vision-Exp', 57.7, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- cybergym
    ('cybergym', 'DeepSeek-V4-Flash-Vision-Exp', 75.3, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'DeepSeek-V4-Flash-Vision-Exp', 59.3, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- toolathlon-verified
    ('toolathlon-verified', 'DeepSeek-V4-Flash-Vision-Exp', 75.9, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    ('toolathlon-verified', 'DeepSeek V4 Flash 0731', 70.3, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- dsbench-hard
    ('dsbench-hard', 'DeepSeek-V4-Flash-Vision-Exp', 63.6, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    ('dsbench-hard', 'DeepSeek V4 Flash 0731', 59.6, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- automationbench-public
    ('automationbench-public', 'DeepSeek-V4-Flash-Vision-Exp', 25.7, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    ('automationbench-public', 'DeepSeek V4 Flash 0731', 25.1, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'DeepSeek-V4-Flash-Vision-Exp', 27.3, null, null, 'DeepSeek', true, date'2026-08-21', 'https://huggingface.co/deepseek-ai/DeepSeek-V4-Flash-Vision-Exp', 'vendor_reported', null);
