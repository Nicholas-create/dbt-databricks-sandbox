-- Release batch: Grok 4.5, announced 16 Jul 2026 (page date; our Epoch data has 8 Jul)
-- Source: https://x.ai/news/grok-4-5 (tabbed bar charts; values from their accessible
-- description; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill (newest page wins). Grok 4.5 only.
--   * DeepSWE 1.0 is not entered: run by Artificial Analysis. DeepSWE 1.1 (run by Datacurve)
--     is, and the newer Grok 4.6 page revises it (53% here, 54% there).
--   * Terminal Bench 2.1 and SWE Bench Pro values match Google's Gemini 3.6 Flash card (83.3% /
--     64.7%). New: SWE Marathon (coding).
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
--
-- Superseded by a later page (the newer value is entered there):
--   * deepswe, Grok 4.5: 53 here; 54 on https://x.ai/news/grok-4-6

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('swe-marathon', 'SWE Marathon', 'coding', null, null, 'pct', 1,
     null, null,
     'Very long software-engineering tasks: resolution rate, pass@1.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-marathon
    ('swe-marathon', 'Grok 4.5', 29.0, null, null, 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-5', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Grok 4.5', 83.3, null, null, 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-5', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'Grok 4.5', 64.7, null, null, 'xAI', false, date'2026-07-16', 'https://x.ai/news/grok-4-5', 'vendor_reported', null);
