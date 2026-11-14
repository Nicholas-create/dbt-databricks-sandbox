-- Release batch: Gemini 3.1 Pro, announced 19 Feb 2026
-- Source: https://deepmind.google/models/model-cards/gemini-3-1-pro/ (HTML table; read 14 Nov 2026). The blog post's table is the
-- same evaluation as an image; the model card has it as text.
-- Entered: 14 Nov 2026, Google backfill (newest page wins). Gemini 3.1 Pro and Gemini 3 Pro
-- (both "Thinking (High)"). Terminal-Bench 2.0 is the Terminus-2 harness row; Gemini 3 Pro
-- scores 56.9% here vs 54.2% in its launch post (re-run; newest wins).
--   * New: SciCode (coding).
-- Entered: Google's own models from Gemini 3 onwards (and Gemma 4); Gemini 2.5 and other
-- developers' columns are not. Not entered anywhere: Artificial Analysis rows and composites
-- (AA Index, GDPval-AA, any "-AA" or "(AA)" benchmark, run by Artificial Analysis), Vals Index
-- (a third-party composite), Arena Elo snapshots (live crowd leaderboards), OmniDocBench
-- (lower is better), prices and speeds, and the safety tables.
--
-- Superseded by a later page (the newer value is entered there):
--   * hle-no-tools, Gemini 3.1 Pro: 44.4 here; 44.4 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * arc-agi-2, Gemini 3.1 Pro: 77.1 here; 77.1 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * swe-bench-pro, Gemini 3.1 Pro: 54.2 here; 54.2 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * mcp-atlas, Gemini 3.1 Pro: 69.2 here; 78.2 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * mmmu-pro, Gemini 3.1 Pro: 80.5 here; 80.5 on https://deepmind.google/models/model-cards/gemini-3-5-flash/
--   * gdm-mrcr-128k, Gemini 3.1 Pro: 84.9 here; 84.9 on https://deepmind.google/models/model-cards/gemini-3-6-flash/
--   * gdm-mrcr-1m, Gemini 3.1 Pro: 26.3 here; 26.3 on https://deepmind.google/models/model-cards/gemini-3-6-flash/

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('scicode', 'SciCode', 'coding', null, null, 'pct', 1,
     null, null,
     'Scientific research coding problems.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- hle-no-tools
    ('hle-no-tools', 'Gemini 3 Pro', 37.5, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Gemini 3.1 Pro', 51.4, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', 'Search (blocklist) and code.'),
    ('hle-with-tools', 'Gemini 3 Pro', 45.8, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', 'Search (blocklist) and code.'),
    -- arc-agi-2
    ('arc-agi-2', 'Gemini 3 Pro', 31.1, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'Gemini 3.1 Pro', 94.3, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('gpqa-diamond', 'Gemini 3 Pro', 91.9, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- terminal-bench
    ('terminal-bench', 'Gemini 3.1 Pro', 68.5, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', 'Terminal-Bench 2.0, Terminus-2 harness.'),
    ('terminal-bench', 'Gemini 3 Pro', 56.9, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', 'Terminal-Bench 2.0, Terminus-2 harness.'),
    -- swe-bench-verified
    ('swe-bench-verified', 'Gemini 3.1 Pro', 80.6, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('swe-bench-verified', 'Gemini 3 Pro', 76.2, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- swe-bench-pro
    ('swe-bench-pro', 'Gemini 3 Pro', 43.3, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- livecodebench-pro
    ('livecodebench-pro', 'Gemini 3.1 Pro', 2887, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('livecodebench-pro', 'Gemini 3 Pro', 2439, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- scicode
    ('scicode', 'Gemini 3.1 Pro', 59, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('scicode', 'Gemini 3 Pro', 56, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- apex-agents
    ('apex-agents', 'Gemini 3.1 Pro', 33.5, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('apex-agents', 'Gemini 3 Pro', 18.4, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- tau2-retail
    ('tau2-retail', 'Gemini 3.1 Pro', 90.8, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('tau2-retail', 'Gemini 3 Pro', 85.3, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- tau2-telecom
    ('tau2-telecom', 'Gemini 3.1 Pro', 99.3, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('tau2-telecom', 'Gemini 3 Pro', 98.0, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- mcp-atlas
    ('mcp-atlas', 'Gemini 3 Pro', 54.1, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- browsecomp
    ('browsecomp', 'Gemini 3.1 Pro', 85.9, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('browsecomp', 'Gemini 3 Pro', 59.2, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- mmmu-pro
    ('mmmu-pro', 'Gemini 3 Pro', 81.0, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- mmmlu
    ('mmmlu', 'Gemini 3.1 Pro', 92.6, null, null, 'Google', false, date'2026-02-19', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    ('mmmlu', 'Gemini 3 Pro', 91.8, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- gdm-mrcr-128k
    ('gdm-mrcr-128k', 'Gemini 3 Pro', 77.0, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null),
    -- gdm-mrcr-1m
    ('gdm-mrcr-1m', 'Gemini 3 Pro', 26.3, null, null, 'Google', false, date'2025-11-18', 'https://deepmind.google/models/model-cards/gemini-3-1-pro/', 'vendor_reported', null);
