-- Release batch: Claude Haiku 5.5, announced 7 Oct 2026
-- Source: https://www.anthropic.com/claude-haiku-5-5 (HTML table; read 14 Nov 2026)
-- Entered: 14 Nov 2026, Claude 5-family backfill (newest page wins per score).
--
-- Entered: Haiku 5.5, Haiku 4.5 and the Sonnet 5.5 reference column.
--   * OSWorld 2.1 "Offline subset" = the existing osworld-2-1 (offline set, partial).
--
-- Not entered, and why:
--   * GPT-6 Luna column: competitor's model.
--   * GDPval-AA v2.1 and AA-Briefcase v1.1: Artificial Analysis data.
--   * Haiku 4.5 FrontierCode: shown as a dash.

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- osworld-2-1
    ('osworld-2-1', 'Claude Haiku 5.5', 72.4, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('osworld-2-1', 'Claude Haiku 4.5', 15.7, null, null, 'Anthropic', false, date'2025-10-15', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('osworld-2-1', 'Claude Sonnet 5.5', 83.9, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'Claude Haiku 5.5', 45.9, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('hle-no-tools', 'Claude Haiku 4.5', 10.2, null, null, 'Anthropic', false, date'2025-10-15', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('hle-no-tools', 'Claude Sonnet 5.5', 56.9, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    -- hle-with-tools
    ('hle-with-tools', 'Claude Haiku 5.5', 57.4, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('hle-with-tools', 'Claude Haiku 4.5', 18.7, null, null, 'Anthropic', false, date'2025-10-15', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('hle-with-tools', 'Claude Sonnet 5.5', 64.5, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    -- terminal-bench-4
    ('terminal-bench-4', 'Claude Haiku 5.5', 39.2, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('terminal-bench-4', 'Claude Haiku 4.5', 0.0, null, null, 'Anthropic', false, date'2025-10-15', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('terminal-bench-4', 'Claude Sonnet 5.5', 70.6, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    -- frontiercode
    ('frontiercode', 'Claude Haiku 5.5', 46.4, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', 'FrontierCode v1.1, Main.'),
    ('frontiercode', 'Claude Sonnet 5.5', 52.1, null, 'xhigh', 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', 'FrontierCode v1.1, Main. Max effort scored 46.2 (Sonnet 5.5 page).'),
    -- chartography
    ('chartography', 'Claude Haiku 5.5', 46.4, null, null, 'Anthropic', false, date'2026-10-07', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('chartography', 'Claude Haiku 4.5', 6.4, null, null, 'Anthropic', false, date'2025-10-15', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null),
    ('chartography', 'Claude Sonnet 5.5', 61.6, null, null, 'Anthropic', false, date'2026-09-28', 'https://www.anthropic.com/claude-haiku-5-5', 'vendor_reported', null);
