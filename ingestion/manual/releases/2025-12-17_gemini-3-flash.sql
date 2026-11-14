-- Release batch: Gemini 3 Flash, announced 17 Dec 2025
-- Source: https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/ (table is an
-- image, transcribed; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3 Flash, and Gemini 3 Pro
-- where it adds a result (Toolathlon, MCP Atlas); its other cells repeat the Gemini 3 post (the
-- Vending-Bench figure only rounded, $5,478).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
-- Not entered: AIME with code execution; tau2-bench (domain not stated).
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, Gemini 3 Flash: 33.7 here; 33.7 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * arc-agi-2, Gemini 3 Flash: 33.6 here; 33.6 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * mmmu-pro, Gemini 3 Flash: 81.2 here; 81.2 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * charxiv-reasoning, Gemini 3 Flash: 80.3 here; 80.3 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * toolathlon, Gemini 3 Flash: 49.4 here; 49.4 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * mcp-atlas, Gemini 3 Flash: 57.4 here; 62.0 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * gdm-mrcr-128k, Gemini 3 Flash: 67.2 here; 67.2 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * gdm-mrcr-1m, Gemini 3 Flash: 22.1 here; 22.1 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * mcp-atlas, Gemini 3 Pro: 54.1 here; 54.1 on https://deepmind.google/models/model-cards/gemini-3-1-pro/

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemini 3 Flash', 90.4, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- aime-2025
    ('aime-2025', 'Gemini 3 Flash', 95.2, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- screenspot-pro
    ('screenspot-pro', 'Gemini 3 Flash', 69.1, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- videommmu
    ('videommmu', 'Gemini 3 Flash', 86.9, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- livecodebench-pro
    ('livecodebench-pro', 'Gemini 3 Flash', 2316, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- terminal-bench
    ('terminal-bench', 'Gemini 3 Flash', 47.6, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', 'Terminal-Bench 2.0, Terminus-2 harness.'),
    -- swe-bench-verified
    ('swe-bench-verified', 'Gemini 3 Flash', 78.0, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- vending-bench-2
    ('vending-bench-2', 'Gemini 3 Flash', 3635, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- facts
    ('facts', 'Gemini 3 Flash', 61.9, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- simpleqa-verified
    ('simpleqa-verified', 'Gemini 3 Flash', 68.7, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- mmmlu
    ('mmmlu', 'Gemini 3 Flash', 91.8, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- global-piqa
    ('global-piqa', 'Gemini 3 Flash', 92.8, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Gemini 3 Flash', 43.5, null, null, 'Google', false, date'2025-12-17', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', 'Search and code execution.'),
    -- toolathlon
    ('toolathlon', 'Gemini 3 Pro', 36.4, null, null, 'Google', false, date'2025-11-18', 'https://blog.google/products-and-platforms/products/gemini/gemini-3-flash/', 'vendor_reported', null);
