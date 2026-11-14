-- Definition change (not a release), 14 Nov 2026: put Chartography's no-tools version first
-- A split pill orders its versions by when each definition was last entered. Chartography
-- (with tools) was defined before the no-tools version, so the pill read "with tools | no
-- tools", the reverse of Humanity's Last Exam ("no tools | with tools"). Entering the
-- with-tools definition again, unchanged, moves it after the no-tools one.

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('chartography-with-tools', 'Chartography (with tools)', 'reasoning', 'Surge AI', null, 'pct', 1,
     'chartography', 'with tools',
     'Visual chart recognition, tool use allowed.');
