-- Definition change (not a release), 14 Nov 2026: DeepSeek backfill, final definitions
-- Families that gained versions in this backfill, entered again in pill order (dated last, so the
-- order holds however the batches are replayed).

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-1', 'Terminal-Bench 1.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '1.0',
     'Agentic coding in a terminal, version 1.0.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-2-1', 'Terminal-Bench 2.1', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '2.1',
     'Agentic coding in a terminal, version 2.1.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-3', 'Terminal-Bench 3.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '3.0',
     'Terminal-Bench 3.0, general agent capabilities.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-4', 'Terminal-Bench 4.0', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '4.0',
     'Agentic coding in a terminal, version 4.0.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('terminal-bench-4-1', 'Terminal-Bench 4.1', 'coding', 'Terminal-Bench', null, 'pct', 1,
     'terminal-bench', '4.1',
     'Terminal-Bench 4.1, cheating-adjusted score.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('hmmt-feb-2025', 'HMMT February 2025', 'maths', null, null, 'pct', 1,
     'hmmt', 'Feb 2025',
     'Harvard-MIT Mathematics Tournament, February 2025, no tools.');

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
    ('hmmt-feb-2026', 'HMMT February 2026', 'maths', null, null, 'pct', 1,
     'hmmt', 'Feb 2026',
     'Harvard-MIT Mathematics Tournament, February 2026, no tools.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('toolathlon', 'Toolathlon', 'agents', null, null, 'pct', 1,
     'toolathlon', 'Toolathlon',
     'Tool use across many real applications.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('toolathlon-verified', 'Toolathlon (Verified)', 'agents', null, null, 'pct', 1,
     'toolathlon', 'Verified',
     'The verified Toolathlon task set.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('matharena-apex', 'MathArena Apex', 'maths', null, null, 'pct', 1,
     'matharena-apex', 'MathArena Apex',
     'The hardest recent maths-competition problems.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('matharena-apex-shortlist', 'MathArena Apex (Shortlist)', 'maths', null, null, 'pct', 1,
     'matharena-apex', 'Shortlist',
     'The shortlist of MathArena Apex candidate problems.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('livecodebench-2025', 'LiveCodeBench (Jan–May 2025)', 'coding', null, null, 'pct', 1,
     'livecodebench', 'Jan–May 2025',
     'Code generation, problems published 1 Jan to 1 May 2025.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('livecodebench-2408-2505', 'LiveCodeBench (Aug 2024–May 2025)', 'coding', null, null, 'pct', 1,
     'livecodebench', 'Aug 2024–May 2025',
     'Code generation, problems published Aug 2024 to May 2025.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('livecodebench-v6', 'LiveCodeBench v6', 'coding', null, null, 'pct', 1,
     'livecodebench', 'v6',
     'Competitive coding problems, LiveCodeBench release v6.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('automationbench', 'AutomationBench', 'agents', 'Zapier', null, 'pct', 1,
     'automationbench', 'AutomationBench',
     'Business workflow automation.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('automationbench-private', 'AutomationBench (private set)', 'agents', 'Zapier', null, 'pct', 1,
     'automationbench', 'private set',
     'Zapier\'s AutomationBench, private task set.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('automationbench-public', 'AutomationBench (public, DeepSeek runs)', 'agents', null, null, 'pct', 1,
     'automationbench', 'public (DeepSeek)',
     'AutomationBench public set as run by DeepSeek; not comparable with the other labs\' runs.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('automationbench-v106-deepseek', 'AutomationBench v1.0.6 (DeepSeek runs)', 'agents', null, null, 'pct', 1,
     'automationbench', 'v1.0.6 (DeepSeek)',
     'AutomationBench 1.0.6 as run by DeepSeek; other labs\' 1.0.6 runs of the same models score far lower.');

