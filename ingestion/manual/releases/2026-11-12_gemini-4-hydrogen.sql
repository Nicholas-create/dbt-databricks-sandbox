-- Release batch: Gemini 4 Hydrogen, announced 12 Nov 2026
-- Source: https://deepmind.google/models/model-cards/gemini-4-hydrogen/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill. Gemini 4 Hydrogen is newer than the Epoch baseline, so
-- these are its first results in our data.
--   * New: Terminal-Bench 4.1 (cheating-adjusted), MKA (Multimodal Knowledge Agents),
--     HLE-Diamond.
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- Also not entered: AutomationBench-AA (run by Artificial Analysis).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-4-1', 'Terminal-Bench 4.1', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '4.1',
     'Terminal-Bench 4.1, cheating-adjusted score.'),
    ('mka', 'Multimodal Knowledge Agents', 'agents', 'Google DeepMind', null, 'pct', 1,
     null, null,
     'Agents answering knowledge questions from images, video and documents (Climb WSR accuracy).'),
    ('hle-diamond', 'Humanity\'s Last Exam (Diamond)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'Diamond',
     'The Diamond subset of Humanity\'s Last Exam.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-sweep
    ('swe-sweep', 'Gemini 4 Hydrogen', 13.5, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- terminal-bench-4-1
    ('terminal-bench-4-1', 'Gemini 4 Hydrogen', 57.0, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- agents-last-exam-v1-1
    ('agents-last-exam-v1-1', 'Gemini 4 Hydrogen', 71.6, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- vending-bench-2-balance
    ('vending-bench-2-balance', 'Gemini 4 Hydrogen', 14549, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- osworld-2-1
    ('osworld-2-1', 'Gemini 4 Hydrogen', 77.6, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- mka
    ('mka', 'Gemini 4 Hydrogen', 53.4, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- chartography
    ('chartography', 'Gemini 4 Hydrogen', 66.6, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- terminal-bench-science
    ('terminal-bench-science', 'Gemini 4 Hydrogen', 51.4, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null),
    -- hle-diamond
    ('hle-diamond', 'Gemini 4 Hydrogen', 58.8, null, null, 'Google', false, date'2026-11-12', 'https://deepmind.google/models/model-cards/gemini-4-hydrogen/', 'vendor_reported', null);
