-- Release batch: GPT-5.1 for developers, announced 13 Nov 2025
-- Source: https://openai.com/index/gpt-5-1-for-developers/ (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, OpenAI backfill (newest page wins). Both models at high effort.
-- The consumer post (https://openai.com/index/gpt-5-1/) has no benchmark results.
--
-- Superseded by a later page (the newer value is entered there):
--   * swe-bench-verified, GPT-5.1: 76.3 here; 76.3 on https://openai.com/index/introducing-gpt-5-2/
--   * gpqa-diamond, GPT-5.1: 88.1 here; 88.1 on https://openai.com/index/introducing-gpt-5-2/
--   * aime-2025, GPT-5.1: 94.0 here; 94.0 on https://openai.com/index/introducing-gpt-5-2/
--   * frontiermath-1-3-v1, GPT-5.1: 26.7 here; 31.0 on https://openai.com/index/introducing-gpt-5-2/
--   * tau2-telecom, GPT-5.1: 95.6 here; 95.6 on https://openai.com/index/introducing-gpt-5-2/
--   * tau2-retail, GPT-5.1: 77.9 here; 77.9 on https://openai.com/index/introducing-gpt-5-2/
--   * browsecomp-lc-128k, GPT-5.1: 90.0 here; 90.0 on https://openai.com/index/introducing-gpt-5-2/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-verified
    ('swe-bench-verified', 'GPT-5', 72.8, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', 'All 500 problems.'),
    -- gpqa-diamond
    ('gpqa-diamond', 'GPT-5', 85.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- aime-2025
    ('aime-2025', 'GPT-5', 94.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- frontiermath-1-3-v1
    ('frontiermath-1-3-v1', 'GPT-5', 26.3, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', 'With Python.'),
    -- mmmu
    ('mmmu', 'GPT-5.1', 85.4, null, 'high', 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    ('mmmu', 'GPT-5', 84.2, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- tau2-airline
    ('tau2-airline', 'GPT-5.1', 67.0, null, 'high', 'OpenAI', false, date'2025-11-13', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    ('tau2-airline', 'GPT-5', 62.6, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'GPT-5', 96.7, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- tau2-retail
    ('tau2-retail', 'GPT-5', 81.1, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null),
    -- browsecomp-lc-128k
    ('browsecomp-lc-128k', 'GPT-5', 90.0, null, 'high', 'OpenAI', false, date'2025-08-07', 'https://openai.com/index/gpt-5-1-for-developers/', 'vendor_reported', null);
