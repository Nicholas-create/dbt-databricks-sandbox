-- Release batch: Grok 4 and Grok 4 Heavy, announced 9 Jul 2025
-- Source: https://x.ai/news/grok-4 (bar charts with printed values; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill (one batch per page, page order; newest page wins).
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
--   * Humanity's Last Exam, full set: Grok 4 Heavy and Grok 4 "w/ Python + Internet" are the
--     with-tools benchmark; plain Grok 4 is no tools. The 50.7% text-only subset isn't entered.
--   * Grok 4 Heavy (parallel test-time compute) is entered as its own model, like GPT-5.6 Sol
--     Ultra; its other results are all "w/ Python" and not entered.
--   * Vending-Bench here is the original version (net worth $4,694.15, from the text): new
--     vending-bench-1 in the Vending-Bench family. New: USAMO 2025 (maths).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, Grok 4: 25.4 here; 25.4 on https://x.ai/news/grok-4-fast
--   * gpqa-diamond, Grok 4: 87.5 here; 87.5 on https://x.ai/news/grok-4-fast
--   * livecodebench-2025, Grok 4: 79.0 here; 79.0 on https://x.ai/news/grok-4-fast
--   * hmmt-feb-2025, Grok 4: 90.0 here; 90.0 on https://x.ai/news/grok-4-fast
--   * aime-2025, Grok 4: 91.7 here; 91.7 on https://x.ai/news/grok-4-fast

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('usamo-2025', 'USAMO 2025', 'maths', null, null, 'pct', 1,
     null, null,
     'USA Mathematical Olympiad 2025: graded proofs.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('vending-bench-1', 'Vending-Bench (v1, net worth)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', 'v1',
     'The original Vending-Bench: mean net worth in dollars.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- hle-with-tools
    ('hle-with-tools', 'Grok 4 Heavy', 44.4, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4', 'vendor_reported', 'Full set, with Python and internet tools.'),
    ('hle-with-tools', 'Grok 4', 38.6, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4', 'vendor_reported', 'Full set, with Python and internet tools.'),
    -- usamo-2025
    ('usamo-2025', 'Grok 4', 37.5, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4', 'vendor_reported', null),
    -- arc-agi-2
    ('arc-agi-2', 'Grok 4', 15.9, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4', 'vendor_reported', null),
    -- vending-bench-1
    ('vending-bench-1', 'Grok 4', 4694.15, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4', 'vendor_reported', 'Average of 5 runs (page text).');
