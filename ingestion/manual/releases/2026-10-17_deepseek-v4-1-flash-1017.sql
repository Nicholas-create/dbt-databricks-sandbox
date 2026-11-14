-- Release batch: DeepSeek-V4.1-Flash-1017, released 17 Oct 2026
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017 (model card, Markdown table; read 14 Nov 2026).
-- Release note: https://api-docs.deepseek.com/news/news261017.
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V4.1-Flash-1017 and V4.1-Flash.
--   * Apex Bench v1.1 = APEX-Agents (Opus 5 65.8% here and in Epoch's data).
--   * Automation-Bench v1.0.6 = automationbench-v106-deepseek.
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- hle-no-tools
    ('hle-no-tools', 'DeepSeek V4.1 Flash 1017', 42.6, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek V4.1 Flash', 36.8, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'DeepSeek V4.1 Flash 1017', 42.3, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('terminal-bench-4', 'DeepSeek V4.1 Flash', 31.2, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'DeepSeek V4.1 Flash 1017', 77.0, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'DeepSeek V4.1 Flash', 74.2, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', 'DeepSWE v1.1.'),
    -- programbench
    ('programbench', 'DeepSeek V4.1 Flash 1017', 29.1, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('programbench', 'DeepSeek V4.1 Flash', 20.3, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- nl2repo
    ('nl2repo', 'DeepSeek V4.1 Flash 1017', 68.2, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('nl2repo', 'DeepSeek V4.1 Flash', 65.4, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- automationbench-v106-deepseek
    ('automationbench-v106-deepseek', 'DeepSeek V4.1 Flash 1017', 60.5, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('automationbench-v106-deepseek', 'DeepSeek V4.1 Flash', 54.8, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'DeepSeek V4.1 Flash 1017', 35.4, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('agents-last-exam-pass-rate', 'DeepSeek V4.1 Flash', 31.8, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- apex-agents
    ('apex-agents', 'DeepSeek V4.1 Flash 1017', 72.1, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', 'Apex Bench v1.1.'),
    ('apex-agents', 'DeepSeek V4.1 Flash', 64.6, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', 'Apex Bench v1.1.'),
    -- chartography-with-tools
    ('chartography-with-tools', 'DeepSeek V4.1 Flash 1017', 83.0, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('chartography-with-tools', 'DeepSeek V4.1 Flash', 78.9, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- babyvision-tools
    ('babyvision-tools', 'DeepSeek V4.1 Flash 1017', 92.5, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('babyvision-tools', 'DeepSeek V4.1 Flash', 89.6, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    -- zerobench-tools
    ('zerobench-tools', 'DeepSeek V4.1 Flash 1017', 51.0, null, null, 'DeepSeek', true, date'2026-10-17', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null),
    ('zerobench-tools', 'DeepSeek V4.1 Flash', 49.0, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017', 'vendor_reported', null);
