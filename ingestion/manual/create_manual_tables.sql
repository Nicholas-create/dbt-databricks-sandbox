-- Manually curated benchmark data: definitions and scores typed in by hand,
-- usually on a model's launch day, before Epoch AI publishes its own runs.
-- dbt reads these as the `manual` source; manual scores supersede Epoch's for
-- the same benchmark and model.
--
-- Both tables are APPEND-ONLY (CONVENTIONS.md section 1, "Manually curated
-- sources"). Never UPDATE or DELETE:
--   * correct a value  -> insert a new row; the latest entered_at wins
--   * withdraw a value -> insert a new row with is_retracted = true
-- Templates for adding rows: ingestion/manual/add_benchmark_score.sql
--
-- Run once (Databricks SQL Editor, or the CLI). Safe to re-run.

create schema if not exists workspace.raw_manual
comment 'Data entered by hand. Append-only: corrections and retractions are new rows.';

create table if not exists workspace.raw_manual.benchmarks (
    benchmark_id    string    not null comment 'Lowercase slug used everywhere downstream, e.g. automationbench',
    benchmark_name  string    not null comment 'Display name, e.g. AutomationBench',
    category        string    not null comment 'One of: overall, coding, writing, maths, science, reasoning, agents',
    publisher       string             comment 'Who maintains the benchmark',
    source_url      string             comment 'Benchmark home page',
    unit            string    not null comment 'pct (share of tasks, entered as 0-100), points, or index',
    unit_max        double             comment 'Top of the scale in site units: 1 for pct, e.g. 10 for points out of 10',
    benchmark_family string            comment 'Links versions of one benchmark into one split pill, e.g. frontiercode (null = stands alone)',
    variant_label   string             comment 'Label of this version inside the split pill, e.g. 2.0 or with tools',
    notes           string,
    is_retracted    boolean   not null default false,
    entered_at      timestamp not null default current_timestamp()
)
comment 'Benchmark definitions entered by hand (append-only, latest row per benchmark_id wins).'
tblproperties ('delta.feature.allowColumnDefaults' = 'supported');

create table if not exists workspace.raw_manual.benchmark_scores (
    entry_id         bigint    generated always as identity,
    benchmark_id     string    not null comment 'Must exist in dim_benchmarks (Epoch catalog or raw_manual.benchmarks)',
    model_name       string    not null comment 'Model name spelled as Epoch spells it, e.g. Claude Fable 5.2',
    score            double    not null comment 'Exactly as published: 49.1 for 49.1%, 7.8 for 7.8/10',
    harness          string             comment 'Agent harness, e.g. claude-code',
    effort           string             comment 'Reasoning effort as published, e.g. xhigh',
    lab              string             comment 'Developer, e.g. Anthropic (falls back to Epoch when blank)',
    is_open_weights  boolean            comment 'Falls back to Epoch when null',
    released_date    date               comment 'Model release date (falls back to Epoch when null)',
    source_url       string    not null comment 'Where the number was published',
    source_type      string    not null comment 'vendor_reported (the lab about its own model) or independent',
    notes            string,
    is_retracted     boolean   not null default false,
    entered_at       timestamp not null default current_timestamp()
)
comment 'Benchmark scores entered by hand (append-only, latest row per benchmark and model wins).'
tblproperties ('delta.feature.allowColumnDefaults' = 'supported');

-- CHECK constraints reject a bad value the moment it's inserted, before dbt
-- ever sees it. Databricks only accepts them through ALTER TABLE; dropping
-- first keeps this file safe to re-run.
alter table workspace.raw_manual.benchmarks drop constraint if exists unit_known;
alter table workspace.raw_manual.benchmarks
    add constraint unit_known check (unit in ('pct', 'points', 'index'));

alter table workspace.raw_manual.benchmark_scores drop constraint if exists score_not_negative;
alter table workspace.raw_manual.benchmark_scores
    add constraint score_not_negative check (score >= 0);

alter table workspace.raw_manual.benchmark_scores drop constraint if exists source_type_known;
alter table workspace.raw_manual.benchmark_scores
    add constraint source_type_known check (source_type in ('vendor_reported', 'independent'));
