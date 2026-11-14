-- One row per benchmark the site can show, from the Epoch catalog seed or a
-- manual definition, with its category, how many models have a score, and its
-- place in the category (relevance_rank: 1 = leftmost pill after "Overall").
{# a model counts as "current" if released in this window #}
{% set recent_days = 180 %}
{# headroom is measured on this many best current scores #}
{% set leaders = 5 %}

with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}

),

categories as (

    select * from {{ ref('benchmark_categories') }}

),

scores as (

    select * from {{ ref('fct_benchmark_scores') }}

),

benchmark_rows as (

    select
        file_name,
        harness
    from {{ ref('stg_epoch__benchmark_rows') }}

),

-- every agent harness seen on the benchmark (all runs, not only each model's
-- best), so the site can list them. union all: harness_lists removes
-- duplicates with collect_set, so a distinct union would be wasted work.
harnesses_seen as (

    select
        benchmarks.benchmark_id,
        benchmark_rows.harness
    from benchmark_rows
    inner join benchmarks
        on benchmark_rows.file_name = benchmarks.epoch_file
    where
        benchmark_rows.harness is not null
        and benchmarks.unit <> 'index'

    union all

    select
        benchmark_id,
        harness
    from scores
    where
        score_source = 'manual'
        and harness is not null

),

harness_lists as (

    select
        benchmark_id,
        array_sort(collect_set(harness)) as harnesses
    from harnesses_seen
    group by 1

),

scores_ranked as (

    select
        *,
        released_date
        >= date_sub(current_date(), {{ recent_days }}) as is_recent,
        row_number() over (
            partition by benchmark_id
            order by
                released_date
                >= date_sub(current_date(), {{ recent_days }}) desc,
                score desc
        ) as score_rank
    from scores

),

coverage as (

    select
        scores_ranked.benchmark_id,
        count(*) as n_models,
        count_if(scores_ranked.score_source = 'manual') as n_manual_scores,
        max(scores_ranked.released_date) as latest_release_date,
        count_if(scores_ranked.is_recent) as n_recent_models,
        -- share of the scale the best current models have NOT yet reached:
        -- near 0 = saturated, it can no longer separate the leaders
        1 - avg(
            case
                when
                    scores_ranked.is_recent
                    and scores_ranked.score_rank <= {{ leaders }}
                    then scores_ranked.score
            end
        ) / max(benchmarks.unit_max) as leader_headroom
    from scores_ranked
    inner join benchmarks
        on scores_ranked.benchmark_id = benchmarks.benchmark_id
    group by 1

),

-- Most relevant first: a benchmark matters when current models are tested on
-- it (n_recent_models) AND it still separates the best of them
-- (leader_headroom). Re-evaluated every build, so stale or saturated
-- benchmarks drift right on their own.
relevance as (

    select
        benchmark_id,
        coalesce(n_recent_models * leader_headroom, 0) as relevance_score
    from coverage

),

final as (

    select
        benchmarks.benchmark_id,
        benchmarks.benchmark_name,
        benchmarks.category,
        categories.label as category_label,
        categories.sort_order as category_sort_order,
        categories.is_on_site,
        benchmarks.sort_order,
        benchmarks.publisher,
        benchmarks.source_url,
        benchmarks.unit,
        benchmarks.unit_max,
        -- a benchmark with no family is a family of one
        coalesce(
            benchmarks.benchmark_family, benchmarks.benchmark_id
        ) as benchmark_family,
        benchmarks.variant_label,
        coalesce(harness_lists.harnesses, array()) as harnesses,
        coalesce(coverage.n_models, 0) as n_models,
        coalesce(coverage.n_manual_scores, 0) as n_manual_scores,
        coverage.latest_release_date,
        coalesce(coverage.n_recent_models, 0) as n_recent_models,
        coverage.leader_headroom,
        coalesce(relevance.relevance_score, 0) as relevance_score,
        benchmarks.defined_in,
        row_number() over (
            partition by benchmarks.category
            order by
                coalesce(relevance.relevance_score, 0) desc,
                coverage.latest_release_date desc nulls last,
                benchmarks.benchmark_id asc
        ) as relevance_rank
    from benchmarks
    left join categories
        on benchmarks.category = categories.category_id
    left join harness_lists
        on benchmarks.benchmark_id = harness_lists.benchmark_id
    left join coverage
        on benchmarks.benchmark_id = coverage.benchmark_id
    left join relevance
        on benchmarks.benchmark_id = relevance.benchmark_id

),

-- Pill order on the site: a family sits where its most relevant version ranks,
-- and its versions stay together, oldest definition first (FrontierCode, then
-- 2.0).
ordered as (

    select
        *,
        row_number() over (
            partition by category
            order by
                min(relevance_rank) over (
                    partition by category, benchmark_family
                ),
                sort_order
        ) as display_rank
    from final

)

select * from ordered
