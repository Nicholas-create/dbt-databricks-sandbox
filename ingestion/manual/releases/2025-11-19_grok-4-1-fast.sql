-- Release batch: Grok 4.1 Fast (with the Agent Tools API), announced 19 Nov 2025
-- Source: https://x.ai/news/grok-4-1-fast (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill. Grok 4.1 Fast, run through xAI's Agent Tools API.
--   * New: FRAMES (agents). X Browse: hidden 'internal'.
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.
-- Not entered: average cost per task.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frames', 'FRAMES', 'agents', 'Google', null, 'pct', 1,
     null, null,
     'Multi-hop factual questions answered with retrieval.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- research-eval-reka
    ('research-eval-reka', 'Grok 4.1 Fast', 63.9, null, null, 'xAI', false, date'2025-11-19', 'https://x.ai/news/grok-4-1-fast', 'vendor_reported', null),
    -- frames
    ('frames', 'Grok 4.1 Fast', 87.6, null, null, 'xAI', false, date'2025-11-19', 'https://x.ai/news/grok-4-1-fast', 'vendor_reported', null),
    -- x-browse
    ('x-browse', 'Grok 4.1 Fast', 56.3, null, null, 'xAI', false, date'2025-11-19', 'https://x.ai/news/grok-4-1-fast', 'vendor_reported', null);
