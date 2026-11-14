-- One row per benchmark the site can show, from the Epoch catalog seed or a
-- manual definition, with its category, how many models have a score, and its
-- place in the category (relevance_rank: 1 = leftmost pill after "Overall").
{% set recent_days = 180 %}  {# a model counts as "current" if released in this window #}
{% set leaders = 5 %}        {# headroom is measured on this many best current scores #}

with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}

),

categories as (

    select * from {{ ref('benchmark_categories') }}

),

scores as (

    select * from {{ ref('fct_benchmark_scores') }}

),

-- every agent harness seen on the benchmark (all runs, not only each model's best),
-- so the site can list them
harnesses_seen as (

    select b.benchmark_id, r.harness
    from {{ ref('stg_epoch__benchmark_rows') }} r
    inner join benchmarks b
        on r.file_name = b.epoch_file
    where r.harness is not null
      and b.unit <> 'index'

    union

    select benchmark_id, harness
    from scores
    where score_source = 'manual'
      and harness is not null

),

harness_lists as (

    select benchmark_id, array_sort(collect_set(harness)) as harnesses
    from harnesses_seen
    group by benchmark_id

),

scores_ranked as (

    select
        s.*,
        s.released_date >= date_sub(current_date(), {{ recent_days }})       as is_recent,
        row_number() over (
            partition by s.benchmark_id
            order by s.released_date >= date_sub(current_date(), {{ recent_days }}) desc, s.score desc
        )                                                                    as score_rank
    from scores s

),

coverage as (

    select
        r.benchmark_id,
        count(*)                                                             as n_models,
        count_if(r.score_source = 'manual')                                  as n_manual_scores,
        max(r.released_date)                                                 as latest_release_date,
        count_if(r.is_recent)                                                as n_recent_models,
        -- share of the scale the best current models have NOT yet reached:
        -- near 0 = saturated, it can no longer separate the leaders
        1 - avg(case when r.is_recent and r.score_rank <= {{ leaders }} then r.score end)
            / max(b.unit_max)                                                as leader_headroom
    from scores_ranked r
    inner join benchmarks b
        on r.benchmark_id = b.benchmark_id
    group by r.benchmark_id

),

-- Most relevant first: a benchmark matters when current models are tested on it
-- (n_recent_models) AND it still separates the best of them (leader_headroom).
-- Re-evaluated every build, so stale or saturated benchmarks drift right on their own.
relevance as (

    select
        benchmark_id,
        coalesce(n_recent_models * leader_headroom, 0)                       as relevance_score
    from coverage

),

final as (

    select
        b.benchmark_id,
        b.benchmark_name,
        b.category,
        c.label                                                              as category_label,
        c.sort_order                                                         as category_sort_order,
        b.sort_order,
        b.publisher,
        b.source_url,
        b.unit,
        b.unit_max,
        coalesce(h.harnesses, array())                                       as harnesses,
        coalesce(v.n_models, 0)                                              as n_models,
        coalesce(v.n_manual_scores, 0)                                       as n_manual_scores,
        v.latest_release_date,
        coalesce(v.n_recent_models, 0)                                       as n_recent_models,
        v.leader_headroom,
        coalesce(r.relevance_score, 0)                                       as relevance_score,
        row_number() over (
            partition by b.category
            order by coalesce(r.relevance_score, 0) desc,
                     v.latest_release_date desc nulls last,
                     b.benchmark_id
        )                                                                    as relevance_rank,
        b.defined_in
    from benchmarks b
    left join categories c
        on b.category = c.category_id
    left join harness_lists h
        on b.benchmark_id = h.benchmark_id
    left join coverage v
        on b.benchmark_id = v.benchmark_id
    left join relevance r
        on b.benchmark_id = r.benchmark_id

)

select * from final
