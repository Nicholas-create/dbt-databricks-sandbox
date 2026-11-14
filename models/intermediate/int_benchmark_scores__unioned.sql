-- One score per benchmark per model, from either source. When both Epoch and a
-- manual entry exist for the same benchmark and model, the manual entry wins:
-- it comes from the model's own release page, the newer and primary source.
with benchmarks as (

    select
        benchmark_id,
        unit
    from {{ ref('int_benchmarks__unioned') }}

),

epoch_benchmark_scores as (

    select * from {{ ref('int_benchmark_scores__epoch') }}

),

manual_benchmark_scores as (

    select * from {{ ref('stg_manual__benchmark_scores') }}

),

-- both sources in the same column layout, in the same column order, so they
-- can be stacked with union all
epoch_scores as (

    select
        benchmark_model_key,
        benchmark_id,
        model_key,
        model_name,
        score,
        harness,
        effort,
        release_date,
        organization,
        cast(null as string) as lab,
        cast(null as boolean) as is_open_weights,
        'epoch' as score_source,
        cast(null as string) as source_type,
        cast(null as string) as source_url,
        cast(null as string) as notes
    from epoch_benchmark_scores

),

manual_scores as (

    select
        manual_benchmark_scores.benchmark_model_key,
        manual_benchmark_scores.benchmark_id,
        {{ model_match_key('manual_benchmark_scores.model_name') }}
            as model_key,
        manual_benchmark_scores.model_name,
        -- entered as published (49.1 = 49.1%); the site works in shares (0.491)
        case
            when benchmarks.unit = 'pct'
                then manual_benchmark_scores.score_as_published / 100
            else manual_benchmark_scores.score_as_published
        end as score,
        manual_benchmark_scores.harness,
        manual_benchmark_scores.effort,
        manual_benchmark_scores.released_date as release_date,
        cast(null as string) as organization,
        manual_benchmark_scores.lab,
        manual_benchmark_scores.is_open_weights,
        'manual' as score_source,
        manual_benchmark_scores.source_type,
        manual_benchmark_scores.source_url,
        manual_benchmark_scores.notes
    from manual_benchmark_scores
    -- left join: an unknown benchmark_id still comes through, so the
    -- relationships test on fct_benchmark_scores fails loudly instead of the
    -- row vanishing
    left join benchmarks
        on manual_benchmark_scores.benchmark_id = benchmarks.benchmark_id

),

unioned as (

    select * from manual_scores
    union all
    select * from epoch_scores

),

superseded as (

    select *
    from unioned
    -- each source already has one row per key (Epoch: best run; manual: one
    -- seed line), so the only clash is manual vs Epoch, and the priority is
    -- spelled out rather than relying on alphabetical order of the source names
    qualify row_number() over (
        partition by benchmark_model_key
        order by case score_source when 'manual' then 1 else 2 end
    ) = 1

)

select * from superseded
