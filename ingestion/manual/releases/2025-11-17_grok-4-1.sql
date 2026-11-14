-- Release batch: Grok 4.1 and Grok 4.1 Thinking, announced 17 Nov 2025
-- Source: https://x.ai/news/grok-4-1 (charts with printed values; read 14 Nov 2026)
-- Entered: 14 Nov 2026, xAI backfill. Grok 4.1, Grok 4.1 Thinking, and Grok 4 where shown.
--   * EQ-Bench 3 and Creative Writing v3 are EQ-Bench's LLM-judged benchmarks, reported as
--     normalised Elo (index): new. Creative Writing v3 is not Epoch's "Creative Writing" (Lech
--     Mazur's, scored out of 10). xAI ran both itself (page methodology note).
-- Entered: xAI's own models from Grok 4 onwards; Grok 3 and other developers' columns are not.
-- Not entered anywhere: Artificial Analysis data (AA Intelligence Index, GDPval-AA, AA
-- Briefcase, and any result "run by AA"), LMArena Elo (a live crowd leaderboard), safety rates,
-- and "w/ Python" results on normally tool-free exams (as for the other labs).
-- xAI's pages render their tables and charts in the browser; values are from the rendered page
-- text or the charts' printed labels and accessible descriptions.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('eq-bench-3', 'EQ-Bench 3', 'writing', null, null, 'index', null,
     null, null,
     'Emotional intelligence in role-played conversations, LLM-judged: normalised Elo.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('creative-writing-v3', 'Creative Writing v3 (EQ-Bench)', 'writing', null, null, 'index', null,
     null, null,
     '32 creative-writing prompts, LLM-judged: normalised Elo. Not Lech Mazur\'s Creative Writing.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- eq-bench-3
    ('eq-bench-3', 'Grok 4.1 Thinking', 1586, null, null, 'xAI', false, date'2025-11-17', 'https://x.ai/news/grok-4-1', 'vendor_reported', null),
    ('eq-bench-3', 'Grok 4.1', 1585, null, null, 'xAI', false, date'2025-11-17', 'https://x.ai/news/grok-4-1', 'vendor_reported', null),
    ('eq-bench-3', 'Grok 4', 1206, null, null, 'xAI', false, date'2025-07-09', 'https://x.ai/news/grok-4-1', 'vendor_reported', null),
    -- creative-writing-v3
    ('creative-writing-v3', 'Grok 4.1 Thinking', 1721.9, null, null, 'xAI', false, date'2025-11-17', 'https://x.ai/news/grok-4-1', 'vendor_reported', null),
    ('creative-writing-v3', 'Grok 4.1', 1708.6, null, null, 'xAI', false, date'2025-11-17', 'https://x.ai/news/grok-4-1', 'vendor_reported', null);
