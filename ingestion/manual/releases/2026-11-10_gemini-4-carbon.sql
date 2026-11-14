-- Release batch: Gemini 4 Carbon, announced 28 Oct 2026, generally available 10 Nov 2026
-- Source: https://deepmind.google/models/model-cards/gemini-4-carbon/ (HTML table, published 10 Nov 2026; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 4 Carbon and Gemini 4 Argon.
-- Release date: the first announcement (28 Oct 2026).
--   * Agents' Last Exam v1.1 (score): new variant (GPT-6 Astra 73.1% here vs 59.3% on v1).
--   * Vending-Bench 2 "bank balance" is a different measure from the net worth reported for
--     Gemini 3: new vending-bench-2-balance.
--   * New: SWE-sweep (coding).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- Also not entered: Terminal-Bench 4.0 (AA) and Terminal-Bench-Science (AA).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('swe-sweep', 'SWE-sweep', 'coding', null, null, 'pct', 1,
     null, null,
     'Large, sweeping software changes across a codebase.'),
    ('agents-last-exam-v1-1', 'Agents\' Last Exam v1.1', 'agents', null, null, 'pct', 1,
     'agents-last-exam', 'v1.1',
     'Agents\' Last Exam version 1.1, score.'),
    ('vending-bench-2-balance', 'Vending-Bench 2 (bank balance)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', 'bank balance',
     'Running a simulated vending business: final bank balance in dollars.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-sweep
    ('swe-sweep', 'Gemini 4 Carbon', 9.6, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('swe-sweep', 'Gemini 4 Argon', 4.3, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- frontierswe
    ('frontierswe', 'Gemini 4 Carbon', 61.2, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', 'FrontierSWE v2.'),
    ('frontierswe', 'Gemini 4 Argon', 55.0, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', 'FrontierSWE v2.'),
    -- agents-last-exam-v1-1
    ('agents-last-exam-v1-1', 'Gemini 4 Carbon', 77.4, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('agents-last-exam-v1-1', 'Gemini 4 Argon', 69.0, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- osworld-2-1
    ('osworld-2-1', 'Gemini 4 Carbon', 81.5, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('osworld-2-1', 'Gemini 4 Argon', 74.7, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- automationbench
    ('automationbench', 'Gemini 4 Carbon', 53.9, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('automationbench', 'Gemini 4 Argon', 51.3, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- vending-bench-2-balance
    ('vending-bench-2-balance', 'Gemini 4 Carbon', 16484, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('vending-bench-2-balance', 'Gemini 4 Argon', 13718, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- chartography
    ('chartography', 'Gemini 4 Carbon', 72.5, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('chartography', 'Gemini 4 Argon', 71.6, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- blueprint-bench-2
    ('blueprint-bench-2', 'Gemini 4 Carbon', 58.6, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', 'Similarity score.'),
    ('blueprint-bench-2', 'Gemini 4 Argon', 54.4, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', 'Similarity score.'),
    -- graphwalks-bfs-256k-1m
    ('graphwalks-bfs-256k-1m', 'Gemini 4 Carbon', 96.2, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('graphwalks-bfs-256k-1m', 'Gemini 4 Argon', 84.2, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- riemannbench
    ('riemannbench', 'Gemini 4 Carbon', 80.0, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('riemannbench', 'Gemini 4 Argon', 76.0, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- cwe-bench
    ('cwe-bench', 'Gemini 4 Carbon', 71.0, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('cwe-bench', 'Gemini 4 Argon', 68.0, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- exploitgym
    ('exploitgym', 'Gemini 4 Carbon', 54.8, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('exploitgym', 'Gemini 4 Argon', 42.0, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    -- sec-bench-pro
    ('sec-bench-pro', 'Gemini 4 Carbon', 88.2, null, null, 'Google', false, date'2026-10-28', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null),
    ('sec-bench-pro', 'Gemini 4 Argon', 83.4, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-carbon/', 'vendor_reported', null);
