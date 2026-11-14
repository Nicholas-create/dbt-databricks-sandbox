-- Release batch: Gemini 4 Argon, announced 30 Sep 2026, generally available 13 Oct 2026
-- Source: https://deepmind.google/models/model-cards/gemini-4-argon/ (HTML table, published 13 Oct 2026; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Release date: the first
-- announcement (30 Sep 2026); our Epoch data also carries the 13 Oct availability date.
--   * Chartography = chartography (no tools): GPT-6 Astra 71.0% here and on Anthropic's page.
--   * GraphWalks "up to 128k" / "256k to 1M" BFS = graphwalks-bfs-128k / -256k-1m.
--   * OSWorld-2.0 "offline subset, partial score" = osworld-2-0-offline (GPT-6 Astra 72.6%
--     here and on OpenAI's page). FrontierSWE v2 = frontierswe.
--   * New: Vibe Code Bench, PostTrainBench (coding); RiemannBench (maths); CWE-bench (cyber).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Superseded by a later page (the newer value is entered there):
--   * automationbench, Gemini 4 Argon: 51.3 here; 51.3 on https://deepmind.google/models/model-cards/gemini-4-carbon/
--   * frontierswe, Gemini 4 Argon: 55.0 here; 55.0 on https://deepmind.google/models/model-cards/gemini-4-carbon/
--   * riemannbench, Gemini 4 Argon: 76.0 here; 76.0 on https://deepmind.google/models/model-cards/gemini-4-carbon/
--   * graphwalks-bfs-256k-1m, Gemini 4 Argon: 84.2 here; 84.2 on https://deepmind.google/models/model-cards/gemini-4-carbon/
--   * chartography, Gemini 4 Argon: 71.6 here; 71.6 on https://deepmind.google/models/model-cards/gemini-4-carbon/
--   * cwe-bench, Gemini 4 Argon: 68.0 here; 68.0 on https://deepmind.google/models/model-cards/gemini-4-carbon/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('vibe-code-bench', 'Vibe Code Bench', 'coding', 'Vals AI', null, 'pct', 1,
     null, null,
     'Building working apps from natural-language specs.'),
    ('posttrainbench', 'PostTrainBench', 'coding', null, null, 'pct', 1,
     null, null,
     'Post-training a language model as an ML engineer would.'),
    ('riemannbench', 'RiemannBench', 'maths', null, null, 'pct', 1,
     null, null,
     'Research-level mathematics.'),
    ('cwe-bench', 'CWE-bench', 'cyber', null, null, 'pct', 1,
     null, null,
     'Finding weakness classes (CWEs) in real code.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- financeagent-v2
    ('financeagent-v2', 'Gemini 4 Argon', 65.4, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- legal-agent-benchmark-allpass
    ('legal-agent-benchmark-allpass', 'Gemini 4 Argon', 19.6, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- deepswe
    ('deepswe', 'Gemini 4 Argon', 77.9, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', 'DeepSWE v1.1.'),
    -- vibe-code-bench
    ('vibe-code-bench', 'Gemini 4 Argon', 91.9, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'Gemini 4 Argon', 57.4, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- posttrainbench
    ('posttrainbench', 'Gemini 4 Argon', 45.3, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- terminal-bench-science
    ('terminal-bench-science', 'Gemini 4 Argon', 57.6, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- labbench2
    ('labbench2', 'Gemini 4 Argon', 88.8, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- graphwalks-bfs-128k
    ('graphwalks-bfs-128k', 'Gemini 4 Argon', 99.7, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- agents-last-exam-pass-rate
    ('agents-last-exam-pass-rate', 'Gemini 4 Argon', 39.5, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- osworld-2-0-offline
    ('osworld-2-0-offline', 'Gemini 4 Argon', 69.2, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null),
    -- lvbench
    ('lvbench', 'Gemini 4 Argon', 91.7, null, null, 'Google', false, date'2026-09-30', 'https://deepmind.google/models/model-cards/gemini-4-argon/', 'vendor_reported', null);
