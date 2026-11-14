-- One row per benchmark the site can show, from the Epoch catalog seed or a
-- manual definition, with its category and how many models have a score.
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

coverage as (

    select
        benchmark_id,
        count(*)                                                             as n_models,
        count_if(score_source = 'manual')                                    as n_manual_scores,
        max(released_date)                                                   as latest_release_date
    from scores
    group by benchmark_id

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
        b.defined_in
    from benchmarks b
    left join categories c
        on b.category = c.category_id
    left join harness_lists h
        on b.benchmark_id = h.benchmark_id
    left join coverage v
        on b.benchmark_id = v.benchmark_id

)

select * from final
