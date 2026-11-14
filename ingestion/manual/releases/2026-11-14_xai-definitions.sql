-- Definition change (not a release), 14 Nov 2026: xAI backfill, final definitions
-- Families that gained versions in this backfill, entered again in pill order (this file is
-- dated last, so the order holds however the batches are replayed).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('vending-bench-1', 'Vending-Bench (v1, net worth)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', 'v1',
     'The original Vending-Bench: mean net worth in dollars.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('vending-bench-2', 'Vending-Bench 2 (net worth)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', '2 net worth',
     'Running a simulated vending business for a year: mean net worth in dollars.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('vending-bench-2-balance', 'Vending-Bench 2 (bank balance)', 'agents', 'Andon Labs', null, 'index', null,
     'vending-bench-2', '2 bank balance',
     'Running a simulated vending business: final bank balance in dollars.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp', 'BrowseComp', 'agents', 'OpenAI', null, 'pct', 1,
     'browsecomp', 'BrowseComp',
     'Agentic search: hard-to-find facts on the web.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('browsecomp-zh', 'BrowseComp (zh)', 'agents', null, null, 'pct', 1,
     'browsecomp', 'zh',
     'Chinese-language BrowseComp.');

