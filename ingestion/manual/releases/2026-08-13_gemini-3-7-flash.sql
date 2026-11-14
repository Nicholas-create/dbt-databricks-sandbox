-- Release batch: Gemini 3.7 Flash, announced 13 Aug 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-7-flash/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.7 Flash and 3.6 Flash.
--   * AutomationBench here is the private set: new automationbench-private.
--   * Agent's Last Exam is reported as a pass rate (GPT-5.6 Terra 28.0% here vs OpenAI's 50.7%
--     score): new agents-last-exam-pass-rate.
--   * OSWorld-2.0 = the original OSWorld 2.0 (GPT-5.6 Terra 50.2% on both pages).
--   * New: Terminal-Bench 3.0, LVBench (long video), HLE-Verified, LABBench2.
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- Also not entered: Code Arena (Elo leaderboard snapshot), Harvey LAB-AA (Artificial Analysis).
--
-- Superseded by a later page (the newer value is entered there):
--   * deepswe, Gemini 3.7 Flash: 65.3 here; 65.3 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * terminal-bench-2-1, Gemini 3.7 Flash: 85.8 here; 85.8 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * gdp-pdf, Gemini 3.7 Flash: 34.0 here; 34.0 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * charxiv-reasoning, Gemini 3.7 Flash: 84.5 here; 84.5 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * lvbench, Gemini 3.7 Flash: 85.4 here; 85.4 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * osworld-2-0, Gemini 3.7 Flash: 47.9 here; 50.6 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * hle-verified, Gemini 3.7 Flash: 53.6 here; 53.6 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * biomysterybench-human-solved, Gemini 3.7 Flash: 87.1 here; 87.1 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * biomysterybench-hard, Gemini 3.7 Flash: 43.5 here; 43.5 on https://deepmind.google/models/model-cards/gemini-3-8-flash/
--   * labbench2, Gemini 3.7 Flash: 82.1 here; 82.1 on https://deepmind.google/models/model-cards/gemini-3-8-flash/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-3', 'Terminal-Bench 3.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '3.0',
     'Terminal-Bench 3.0, general agent capabilities.'),
    ('automationbench-private', 'AutomationBench (private set)', 'agents', null, null, 'pct', 1,
     'automationbench', 'private set',
     'Zapier\'s AutomationBench, private task set.'),
    ('agents-last-exam-pass-rate', 'Agents\' Last Exam (pass rate)', 'agents', null, null, 'pct', 1,
     'agents-last-exam', 'pass rate',
     'Agents\' Last Exam reported as the share of tasks fully passed.'),
    ('lvbench', 'LVBench', 'reasoning', null, null, 'pct', 1,
     null, null,
     'Long video understanding.'),
    ('hle-verified', 'Humanity\'s Last Exam (Verified)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'Verified',
     'A verified subset of Humanity\'s Last Exam.'),
    ('labbench2', 'LAB-Bench 2', 'life-sciences', 'FutureHouse', null, 'pct', 1,
     null, null,
     'Real-world biology research tasks.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- frontiercode
    ('frontiercode', 'Gemini 3.7 Flash', 43.6, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', 'FrontierCode 1.1 Main.'),
    ('frontiercode', 'Gemini 3.6 Flash', 34.4, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', 'FrontierCode 1.1 Main.'),
    -- deepswe
    ('deepswe', 'Gemini 3.6 Flash', 48.6, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', 'DeepSWE v1.1.'),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Gemini 3.6 Flash', 78.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- terminal-bench-3
    ('terminal-bench-3', 'Gemini 3.7 Flash', 14.9, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    ('terminal-bench-3', 'Gemini 3.6 Flash', 5.4, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- automationbench-private
    ('automationbench-private', 'Gemini 3.7 Flash', 30.4, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    ('automationbench-private', 'Gemini 3.6 Flash', 17.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- gdp-pdf
    ('gdp-pdf', 'Gemini 3.6 Flash', 22.0, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- charxiv-reasoning
    ('charxiv-reasoning', 'Gemini 3.6 Flash', 85.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- charxiv-reasoning-python
    ('charxiv-reasoning-python', 'Gemini 3.7 Flash', 88.7, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', 'With tools.'),
    ('charxiv-reasoning-python', 'Gemini 3.6 Flash', 89.4, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', 'With tools.'),
    -- lvbench
    ('lvbench', 'Gemini 3.6 Flash', 84.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemini 3.7 Flash', 97.0, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    ('gdm-mrcr-128k', 'Gemini 3.6 Flash', 91.8, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- osworld-2-0
    ('osworld-2-0', 'Gemini 3.6 Flash', 33.8, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'Gemini 3.7 Flash', 26.3, null, null, 'Google', false, date'2026-08-13', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    ('agents-last-exam-pass-rate', 'Gemini 3.6 Flash', 24.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- hle-verified
    ('hle-verified', 'Gemini 3.6 Flash', 51.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- biomysterybench-human-solved
    ('biomysterybench-human-solved', 'Gemini 3.6 Flash', 80.6, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- biomysterybench-hard
    ('biomysterybench-hard', 'Gemini 3.6 Flash', 41.2, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null),
    -- labbench2
    ('labbench2', 'Gemini 3.6 Flash', 76.1, null, null, 'Google', false, date'2026-07-21', 'https://deepmind.google/models/model-cards/gemini-3-7-flash/', 'vendor_reported', null);
