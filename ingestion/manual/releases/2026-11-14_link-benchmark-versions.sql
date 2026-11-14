-- Definition change (not a release): link benchmark versions into families, 14 Nov 2026
-- FrontierCode 2.0 is a newer version of FrontierCode, and Humanity's Last Exam (with
-- tools) a variant of Humanity's Last Exam. They keep separate results, but the site
-- shows each family as one split pill. The Epoch side is set in seeds/benchmark_catalog.csv.

-- One-off migration: add the two columns to the existing table (already in the CREATE
-- in create_manual_tables.sql for a fresh build). Fails harmlessly if run twice.
alter table workspace.raw_manual.benchmarks add columns (
    benchmark_family string comment 'Links versions of one benchmark into one split pill, e.g. frontiercode (null = stands alone)',
    variant_label    string comment 'Label of this version inside the split pill, e.g. 2.0 or with tools'
);

-- Append-only: the definitions are inserted again with the family set; the newest row wins.
insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('frontiercode-2', 'FrontierCode 2.0', 'coding', null, null, 'pct', 1,
     'frontiercode', '2.0',
     'Would the maintainers of open-source repositories merge the model''s code changes. A newer version than Epoch''s FrontierCode.'),
    ('hle-with-tools', 'Humanity''s Last Exam (with tools)', 'science', null, null, 'pct', 1,
     'humanity-s-last-exam', 'with tools',
     'Same questions as Humanity''s Last Exam, with tool use allowed.');
