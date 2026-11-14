-- Release batch: GPT-5.5 Instant, announced 5 May 2026
-- Source: https://openai.com/index/gpt-5-5-instant/ (charts; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). Values from the charts' data.
-- GPT-5.5 Instant answers without extended thinking or tools; CharXiv is entered as no tools.
-- Not entered: GPT-5.3 Instant (not in our model list, no release date); OmniDocBench (lower is
-- better).

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- charxiv-reasoning
    ('charxiv-reasoning', 'GPT-5.5 Instant', 81.6, null, null, 'OpenAI', false, date'2026-05-05', 'https://openai.com/index/gpt-5-5-instant/', 'vendor_reported', 'From the page\'s chart data.'),
    -- mmmu-pro
    ('mmmu-pro', 'GPT-5.5 Instant', 76.0, null, null, 'OpenAI', false, date'2026-05-05', 'https://openai.com/index/gpt-5-5-instant/', 'vendor_reported', 'From the page\'s chart data.'),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5.5 Instant', 85.6, null, null, 'OpenAI', false, date'2026-05-05', 'https://openai.com/index/gpt-5-5-instant/', 'vendor_reported', 'From the page\'s chart data.'),
    -- aime-2025
    ('aime-2025', 'GPT-5.5 Instant', 81.2, null, null, 'OpenAI', false, date'2026-05-05', 'https://openai.com/index/gpt-5-5-instant/', 'vendor_reported', 'From the page\'s chart data.');
