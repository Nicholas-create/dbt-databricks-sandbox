-- Definition change (not a release), 14 Nov 2026: Google backfill, final definitions
-- Families that gained versions in this backfill, entered again in the order the pill should
-- read (a pill orders versions by when each definition was last entered; this file is dated last).

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
    ('agents-last-exam', 'Agents\' Last Exam', 'agents', null, null, 'pct', 1,
     'agents-last-exam', 'v1',
     'Long-horizon professional work on a computer across 55 sub-industries (v1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('agents-last-exam-v1-1', 'Agents\' Last Exam v1.1', 'agents', null, null, 'pct', 1,
     'agents-last-exam', 'v1.1',
     'Agents\' Last Exam version 1.1, score.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('agents-last-exam-pass-rate', 'Agents\' Last Exam (pass rate)', 'agents', null, null, 'pct', 1,
     'agents-last-exam', 'pass rate',
     'Agents\' Last Exam reported as the share of tasks fully passed.');

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
    ('legal-agent-benchmark', 'Legal Agent Benchmark', 'agents', 'Harvey', null, 'pct', 1,
     'legal-agent-benchmark', 'Legal Agent Benchmark',
     'Legal agent tasks (held-out set).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('legal-agent-benchmark-allpass', 'Legal Agent Benchmark (all pass rate)', 'agents', 'Harvey', null, 'pct', 1,
     'legal-agent-benchmark', 'all pass rate',
     'Harvey\'s Legal Agent Benchmark: share of tasks with every check passed.');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('financeagent', 'FinanceAgent v1.1', 'agents', 'Vals AI', null, 'pct', 1,
     'financeagent', 'v1.1',
     'Financial-analyst agent tasks (v1.1).');

insert into workspace.raw_manual.benchmarks
    (benchmark_id, benchmark_name, category, publisher, source_url, unit, unit_max,
     benchmark_family, variant_label, notes)
values
    ('financeagent-v2', 'Finance Agent v2', 'agents', 'Vals AI', null, 'pct', 1,
     'financeagent', 'v2',
     'Financial-analyst agent tasks, version 2.');

