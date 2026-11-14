-- Release batch: DeepSeek-V4.1-Flash, released 10 Sep 2026 (release note date)
-- Source: https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash (model card, Markdown table; read 14 Nov 2026).
-- Release note: https://api-docs.deepseek.com/news/news260910.
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). The "DS-V4-Pro" and "DS-V4-Flash"
-- columns are V4-Pro-0813 and V4-Flash-0731 (same figures as on their cards).
--   * AutomationBench here (V4-Pro 43.2% vs 31.8% "Public" on its own card) is v1.0.6 as run by
--     DeepSeek (the 1017 card names it); other labs' v1.0.6 runs of the same models are far lower
--     (Opus 5: 26.9% vs 50.3%), so it's a variant of its own: automationbench-v106-deepseek.
--   * Agent's Last Exam (Pass@1) = agents-last-exam-pass-rate.
--   * New: ProgramBench (coding); BabyVision and ZeroBench, with tools (reasoning).
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, DeepSeek V4.1 Flash: 36.8 here; 36.8 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * terminal-bench-4, DeepSeek V4.1 Flash: 31.2 here; 31.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * deepswe, DeepSeek V4.1 Flash: 74.2 here; 74.2 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * programbench, DeepSeek V4.1 Flash: 20.3 here; 20.3 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * nl2repo, DeepSeek V4.1 Flash: 64.0 here; 65.4 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * automationbench-v106-deepseek, DeepSeek V4.1 Flash: 54.8 here; 54.8 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * agents-last-exam-pass-rate, DeepSeek V4.1 Flash: 31.8 here; 31.8 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * chartography-with-tools, DeepSeek V4.1 Flash: 78.9 here; 78.9 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * babyvision-tools, DeepSeek V4.1 Flash: 89.6 here; 89.6 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017
--   * zerobench-tools, DeepSeek V4.1 Flash: 49.0 here; 49.0 on https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('automationbench-v106-deepseek', 'AutomationBench v1.0.6 (DeepSeek runs)', 'agents', null, null, 'pct', 1,
     'automationbench', 'v1.0.6 (DeepSeek)',
     'AutomationBench 1.0.6 as run by DeepSeek; other labs\' 1.0.6 runs of the same models score far lower.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('programbench', 'ProgramBench', 'coding', null, null, 'pct', 1,
     null, null,
     'Writing whole programs from specifications (Almost@1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('babyvision-tools', 'BabyVision (with tools)', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Basic visual reasoning, tool use allowed.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('zerobench-tools', 'ZeroBench (with tools)', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Very hard visual questions (main set, pass@5), tool use allowed.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gpqa-diamond
    ('gpqa-diamond', 'DeepSeek V4 Pro 0813', 92.4, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('gpqa-diamond', 'DeepSeek V4 Flash 0731', 89.9, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('gpqa-diamond', 'DeepSeek V4.1 Flash', 90.9, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'DeepSeek V4 Pro 0813', 3348, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('codeforces', 'DeepSeek V4 Flash 0731', 3289, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('codeforces', 'DeepSeek V4.1 Flash', 3471, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- matharena-apex
    ('matharena-apex', 'DeepSeek V4 Pro 0813', 65.3, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('matharena-apex', 'DeepSeek V4 Flash 0731', 58.6, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('matharena-apex', 'DeepSeek V4.1 Flash', 65.6, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'DeepSeek V4 Pro 0813', 87.9, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('terminal-bench-2-1', 'DeepSeek V4 Flash 0731', 82.7, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('terminal-bench-2-1', 'DeepSeek V4.1 Flash', 90.6, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- terminal-bench-3
    ('terminal-bench-3', 'DeepSeek V4 Pro 0813', 11.8, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('terminal-bench-3', 'DeepSeek V4 Flash 0731', 7.6, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('terminal-bench-3', 'DeepSeek V4.1 Flash', 30.0, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'DeepSeek V4 Pro 0813', 12.4, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('terminal-bench-4', 'DeepSeek V4 Flash 0731', 7.0, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'DeepSeek V4 Pro 0813', 62.7, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', 'DeepSWE v1.1.'),
    ('deepswe', 'DeepSeek V4 Flash 0731', 54.4, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', 'DeepSWE v1.1.'),
    -- programbench
    ('programbench', 'DeepSeek V4 Pro 0813', 15.5, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- nl2repo
    ('nl2repo', 'DeepSeek V4 Pro 0813', 61.5, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('nl2repo', 'DeepSeek V4 Flash 0731', 54.2, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- cybergym
    ('cybergym', 'DeepSeek V4 Pro 0813', 83.3, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('cybergym', 'DeepSeek V4 Flash 0731', 76.7, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('cybergym', 'DeepSeek V4.1 Flash', 88.1, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- sec-bench-pro
    ('sec-bench-pro', 'DeepSeek V4 Pro 0813', 56.4, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('sec-bench-pro', 'DeepSeek V4 Flash 0731', 30.9, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('sec-bench-pro', 'DeepSeek V4.1 Flash', 62.8, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- exploitgym
    ('exploitgym', 'DeepSeek V4 Pro 0813', 5.4, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('exploitgym', 'DeepSeek V4 Flash 0731', 1.8, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('exploitgym', 'DeepSeek V4.1 Flash', 15.3, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'DeepSeek V4 Pro 0813', 60.0, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('hle-with-tools', 'DeepSeek V4 Flash 0731', 51.5, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('hle-with-tools', 'DeepSeek V4.1 Flash', 63.9, null, null, 'DeepSeek', true, date'2026-09-10', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- automationbench-v106-deepseek
    ('automationbench-v106-deepseek', 'DeepSeek V4 Pro 0813', 43.2, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('automationbench-v106-deepseek', 'DeepSeek V4 Flash 0731', 37.7, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'DeepSeek V4 Pro 0813', 25.7, null, null, 'DeepSeek', true, date'2026-08-13', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null),
    ('agents-last-exam-pass-rate', 'DeepSeek V4 Flash 0731', 25.2, null, null, 'DeepSeek', true, date'2026-07-31', 'https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash', 'vendor_reported', null);
