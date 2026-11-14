-- Release batch (additions): Claude Fable 5.2 and Claude Mythos 5.2, announced 9 Nov 2026
-- Source: https://www.anthropic.com/claude-fable-and-mythos-5-2 (HTML table; read again 14 Nov 2026)
-- Entered: 14 Nov 2026. The first batch (2026-11-09_claude-fable-5-2.sql) skipped rows with
-- no site category and the Mythos cells; the database is now meant to hold every result on
-- a release page, and the site has cyber and life-sciences categories.
--
-- Entered:
--   * The cell labelled "75.3% (Mythos 5.2)" (Terminal-Bench-Science).
--   * Cyber and protein design rows: Mythos 5.2 and Mythos 5.1 as labelled; the Opus 5.5
--     column is "without safeguards" (in the notes). CyScenarioBench: each lab's scores
--     are on unique tasks (footnote).
--   * De novo binder design: the page prints a score with no unit or scale, so it is an
--     'index' benchmark, shown exactly as published and left out of the Overall fit.
--   * RoboDojo Sim (Agents): run internally at the highest available effort.
--   * Chartography (no tools).
-- Definition fixes (append-only, newest row wins):
--   * osworld-2-1 joins the osworld family as "2.1 offline".
--   * hle-with-tools: its name had lost the apostrophe ("Humanitys"). Databricks SQL reads
--     'Humanity''s' as two string literals glued together; apostrophes are now escaped as \'.
--
-- Still not entered: GPT-6 Astra / Gemini 4 Carbon / GPT-6 Cyber columns (competitors),
-- AA-Briefcase (Artificial Analysis), effort-curve charts (no printed values; BenchCAD 2.1
-- only appears there).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('osworld-2-1', 'OSWorld 2.1 (offline set)', 'agents', null, null, 'pct', 1,
     'osworld', '2.1 offline',
     'Computer use, version 2.1, offline set, partial credit.'),
    ('hle-with-tools', 'Humanity\'s Last Exam (with tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'with tools',
     'Same questions as Humanity\'s Last Exam, with tool use allowed.'),
    ('cyscenariobench', 'CyScenarioBench', 'cyber', null, null, 'pct', 1,
     null, null,
     'Realistic cyber-operation scenarios; each lab\'s scores are based on unique tasks.'),
    ('cve-rediscovery', 'CVE Rediscovery', 'cyber', null, null, 'pct', 1,
     null, null,
     'Anthropic internal evaluation: rediscovering known vulnerabilities (CVEs).'),
    ('binder-design', 'De novo binder design (24 hr)', 'life-sciences', null, null, 'index', null,
     null, null,
     'Protein design within 24 hours; score as published, scale not stated.'),
    ('robodojo-sim', 'RoboDojo Sim', 'agents', null, null, 'pct', 1,
     null, null,
     'Controlling a simulated two-arm robot from camera images.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- terminal-bench-science
    ('terminal-bench-science', 'Claude Mythos 5.2', 75.3, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'Labelled Mythos 5.2 in the Fable 5.2 column.'),
    -- cyscenariobench
    ('cyscenariobench', 'Claude Mythos 5.2', 76.3, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('cyscenariobench', 'Claude Mythos 5.1', 61.7, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('cyscenariobench', 'Claude Opus 5.5', 67.6, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'Without safeguards.'),
    -- cve-rediscovery
    ('cve-rediscovery', 'Claude Mythos 5.2', 89.6, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('cve-rediscovery', 'Claude Mythos 5.1', 78.3, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('cve-rediscovery', 'Claude Opus 5.5', 81.3, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'Without safeguards.'),
    -- binder-design
    ('binder-design', 'Claude Mythos 5.2', 85.1, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('binder-design', 'Claude Mythos 5.1', 79.1, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('binder-design', 'Claude Opus 5.5', 82.6, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', 'Without safeguards.'),
    -- robodojo-sim
    ('robodojo-sim', 'Claude Fable 5.2', 64.9, null, 'max', 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('robodojo-sim', 'Claude Fable 5.1', 27.6, null, 'max', 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('robodojo-sim', 'Claude Opus 5.5', 39.4, null, 'max', 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    -- chartography
    ('chartography', 'Claude Fable 5.2', 73.4, null, null, 'Anthropic', false, date'2026-11-09', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('chartography', 'Claude Fable 5.1', 44.8, null, null, 'Anthropic', false, date'2026-09-01', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null),
    ('chartography', 'Claude Opus 5.5', 64.4, null, null, 'Anthropic', false, date'2026-09-22', 'https://www.anthropic.com/claude-fable-and-mythos-5-2', 'vendor_reported', null);
