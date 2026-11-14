-- Release batch: Claude Sonnet 5.5, announced 28 Sep 2026
-- Source: https://www.anthropic.com/claude-sonnet-5-5 (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Sonnet 5.5, Sonnet 5 and Opus 5.5.
--   * FrontierCode: the page shows Sonnet 5.5 at Max (46.2%) and Xhigh (52.1%); one score
--     per model, so the higher (Xhigh) is entered and Max is in the notes (footnote: Max
--     effort ran a code-review skill that added out-of-scope edits).
--
-- Not entered, and why:
--   * GPT-6 Sol column: competitor's model.
--   * GDPval-AA v2.1 and AA-Briefcase v1.1: Artificial Analysis data.
--   * Repeats of Opus 5.5 values entered from the Opus 5.5 page (Terminal-Bench 4.0,
--     CursorBench 4.0, HLE with tools, OSWorld 2.1), except FrontierCode and
--     Chartography (no tools), first entered here or later.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('chartography', 'Chartography (no tools)', 'reasoning', 'Surge AI', null, 'pct', 1,
     'chartography', 'no tools',
     'Visual chart recognition, no tools.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-4
    ('terminal-bench-4', 'Claude Opus 5.5', 66.4, null, 'xhigh', 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'Xhigh is Opus 5.5\'s highest score (footnote 1).'),
    ('terminal-bench-4', 'Claude Sonnet 5', 10.3, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', null),
    -- frontiercode
    ('frontiercode', 'Claude Opus 5.5', 54.4, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    ('frontiercode', 'Claude Sonnet 5', 42.4, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    -- cursorbench
    ('cursorbench', 'Claude Opus 5.5', 57.8, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'CursorBench 4.0.'),
    ('cursorbench', 'Claude Sonnet 5.5', 55.5, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'CursorBench 4.0.'),
    ('cursorbench', 'Claude Sonnet 5', 34.1, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'CursorBench 4.0.'),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Sonnet 5', 54.9, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', 'The Sonnet 5 page reported 57.4.'),
    -- osworld-2-1-full
    ('osworld-2-1-full', 'Claude Opus 5.5', 81.8, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', null),
    ('osworld-2-1-full', 'Claude Sonnet 5.5', 80.1, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', null),
    ('osworld-2-1-full', 'Claude Sonnet 5', 57.0, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', null),
    -- chartography
    ('chartography', 'Claude Sonnet 5', 15.6, null, null, 'Anthropic', false, date'2026-06-30', 'https://www.anthropic.com/claude-sonnet-5-5', 'vendor_reported', null);
