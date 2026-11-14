-- Release batch: Claude Sonnet 5, announced 30 Jun 2026
-- Source: https://www.anthropic.com/news/claude-sonnet-5 (benchmark table is an image; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Sonnet 5, Sonnet 4.6 and Opus 4.8 (all Anthropic). Page footnotes: Sonnet 4.6's
-- HLE (grader update) and OSWorld-Verified (harness change) scores were re-run for this page.
--
-- Not entered, and why:
--   * GDPval-AA v2: Artificial Analysis data (CONVENTIONS.md section 8).
--   * BrowseComp and OSWorld-Verified effort charts: no printed values.
--   * Superseded by a later page: HLE with tools Sonnet 5 57.4 (Sonnet 5.5 page: 54.9);
--     HLE values for Opus 4.8 are entered from the Opus 5 page (same numbers).

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- swe-bench-pro
    ('swe-bench-pro', 'Claude Sonnet 5', 63.2, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('swe-bench-pro', 'Claude Sonnet 4.6', 58.1, null, null, 'Anthropic', false, date'2026-02-17', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('swe-bench-pro', 'Claude Opus 4.8', 69.2, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    -- terminal-bench-2-1
    ('terminal-bench-2-1', 'Claude Sonnet 5', 80.4, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('terminal-bench-2-1', 'Claude Sonnet 4.6', 67.0, null, null, 'Anthropic', false, date'2026-02-17', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('terminal-bench-2-1', 'Claude Opus 4.8', 82.7, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Claude Sonnet 5', 43.2, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('hle-no-tools', 'Claude Sonnet 4.6', 34.6, null, null, 'Anthropic', false, date'2026-02-17', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', 'Re-graded for this page (footnote).'),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Sonnet 4.6', 46.8, null, null, 'Anthropic', false, date'2026-02-17', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', 'Re-graded for this page (footnote).'),
    -- osworld-verified
    ('osworld-verified', 'Claude Sonnet 5', 81.2, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null),
    ('osworld-verified', 'Claude Sonnet 4.6', 78.5, null, null, 'Anthropic', false, date'2026-02-17', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', 'Re-run with an updated harness for this page (footnote).'),
    ('osworld-verified', 'Claude Opus 4.8', 83.4, null, null, 'Anthropic', false, date'2026-05-28', 'https://www.anthropic.com/news/claude-sonnet-5', 'vendor_reported', null);
