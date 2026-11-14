-- Definition change (not a release), 14 Nov 2026: a hidden 'internal' category
-- A developer's own internal evaluations only ever score that developer's models, so they
-- can't rank models across labs. They stay in the database under category 'internal'
-- (seeds/benchmark_categories.csv: is_on_site = false), which the site doesn't show.
-- Anthropic's CVE Rediscovery is one ("our internal evaluation" on the Fable 5.2 page).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('cve-rediscovery', 'CVE Rediscovery (Anthropic internal)', 'internal', 'Anthropic', null, 'pct', 1,
     null, null,
     'Anthropic internal evaluation: rediscovering known vulnerabilities (CVEs).');
