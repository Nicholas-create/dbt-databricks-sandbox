-- Release batch: DeepSeek-V3.2 and DeepSeek-V3.2-Speciale, released 1 Dec 2025
-- Source: https://api-docs.deepseek.com/news/news251201 (benchmark tables are images, transcribed; the model cards have no
-- tables; read 14 Nov 2026)
-- Entered: 14 Nov 2026, DeepSeek backfill (newest wins). V3.2 (thinking) and V3.2 Speciale; the
-- figures in brackets on the image are token counts, not scores.
--   * Tool-Decathlon = Toolathlon (Gemini 3 Pro 36.4% here and on Google's page).
--   * New: HMMT Nov 2025, IMOAnswerBench (maths); MCP-Universe, MCP-Mark (agents).
-- Entered: DeepSeek's own models from V3.1 onwards (open weights); older DeepSeek models and other
-- developers' columns are not. Not entered anywhere: base-model (pre-trained, few-shot) tables,
-- GDPval-AA (Artificial Analysis), harness-comparison tables (one model across harnesses),
-- token counts, and HLE text-only-subset cells (marked with a dagger).
-- Also not entered: LiveCodeBench (problem window not stated); tau2-bench (domain not stated).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hmmt-nov-2025', 'HMMT November 2025', 'maths', null, null, 'pct', 1,
     'hmmt', 'Nov 2025',
     'Harvard-MIT Mathematics Tournament, November 2025, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('imo-answerbench', 'IMO-AnswerBench', 'maths', null, null, 'pct', 1,
     null, null,
     'Olympiad-level problems with short verifiable answers.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mcp-universe', 'MCP-Universe', 'agents', null, null, 'pct', 1,
     null, null,
     'Tasks over real MCP servers.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('mcp-mark', 'MCPMark', 'agents', null, null, 'pct', 1,
     null, null,
     'Stress-testing realistic MCP tool use.');

insert into workspace.raw_manual.benchmark_scores
    (benchmark_id, model_name, score, harness, effort, lab, is_open_weights, released_date,
     source_url, source_type, notes)
values
    -- aime-2025
    ('aime-2025', 'DeepSeek-V3.2', 93.1, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('aime-2025', 'DeepSeek V3.2 Speciale', 96.0, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- hmmt-feb-2025
    ('hmmt-feb-2025', 'DeepSeek-V3.2', 92.5, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('hmmt-feb-2025', 'DeepSeek V3.2 Speciale', 99.2, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- hmmt-nov-2025
    ('hmmt-nov-2025', 'DeepSeek-V3.2', 90.2, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('hmmt-nov-2025', 'DeepSeek V3.2 Speciale', 94.4, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- imo-answerbench
    ('imo-answerbench', 'DeepSeek-V3.2', 78.3, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('imo-answerbench', 'DeepSeek V3.2 Speciale', 84.5, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- codeforces
    ('codeforces', 'DeepSeek-V3.2', 2386, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('codeforces', 'DeepSeek V3.2 Speciale', 2701, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- gpqa-diamond
    ('gpqa-diamond', 'DeepSeek-V3.2', 82.4, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('gpqa-diamond', 'DeepSeek V3.2 Speciale', 85.7, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- hle-no-tools
    ('hle-no-tools', 'DeepSeek-V3.2', 25.1, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    ('hle-no-tools', 'DeepSeek V3.2 Speciale', 30.6, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- mcp-universe
    ('mcp-universe', 'DeepSeek-V3.2', 45.9, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- mcp-mark
    ('mcp-mark', 'DeepSeek-V3.2', 38.0, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', null),
    -- toolathlon
    ('toolathlon', 'DeepSeek-V3.2', 35.2, null, null, 'DeepSeek', true, date'2025-12-01', 'https://api-docs.deepseek.com/news/news251201', 'vendor_reported', 'Tool-Decathlon.');
