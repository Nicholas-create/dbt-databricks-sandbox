-- Release batch: Grok Code Fast 1, announced 28 Aug 2025
-- Source: https://x.ai/news/grok-code-fast-1 (page text; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill. The only benchmark result on the page is in the text.
-- Not entered: the tokens-per-second chart (speed, not a benchmark).

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-verified
    ('swe-bench-verified', 'Grok Code Fast 1', 70.8, null, null, 'xAI', false, date'2025-08-28', 'https://x.ai/news/grok-code-fast-1', 'vendor_reported', 'Full set, xAI\'s own harness (page text).');
