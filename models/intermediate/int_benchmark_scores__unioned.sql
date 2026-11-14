-- One score per benchmark per model, from either source. When both Epoch and a
-- manual entry exist for the same benchmark and model, the manual entry wins:
-- that table is where launch-day results are added, ahead of Epoch's own runs.
with benchmarks as (

    select benchmark_id, unit from {{ ref('int_benchmarks__unioned') }}

),

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
        cast(null as string)                                                 as lab,
        cast(null as boolean)                                                as is_open_weights,
        'epoch'                                                              as score_source,
        cast(null as string)                                                 as source_type,
        cast(null as string)                                                 as source_url,
        cast(null as string)                                                 as notes
    from {{ ref('int_benchmark_scores__epoch') }}

),

manual_scores as (

    select
        s.benchmark_model_key,
        s.benchmark_id,
        {{ model_match_key('s.model_name') }}                                as model_key,
        s.model_name,
        -- entered as published (49.1 = 49.1%); the site works in shares (0.491)
        case when b.unit = 'pct' then s.score_as_published / 100
             else s.score_as_published
        end                                                                  as score,
        s.harness,
        s.effort,
        s.released_date                                                      as release_date,
        cast(null as string)                                                 as organization,
        s.lab,
        s.is_open_weights,
        'manual'                                                             as score_source,
        s.source_type,
        s.source_url,
        s.notes
    from {{ ref('stg_manual__benchmark_scores') }} s
    -- left join: an unknown benchmark_id still comes through, so the relationships
    -- test on fct_benchmark_scores fails loudly instead of the row vanishing
    left join benchmarks b
        on s.benchmark_id = b.benchmark_id
    -- a retracted entry is withdrawn: Epoch's score (if any) shows again
    where not s.is_retracted

),

unioned as (

    select * from manual_scores
    union all
    select * from epoch_scores

),

superseded as (

    select *
    from unioned
    -- each source already has one row per key (Epoch: best run; manual: latest entry),
    -- so the only clash is manual vs Epoch, and the priority is spelled out rather
    -- than relying on alphabetical order of the source names
    qualify row_number() over (
        partition by benchmark_model_key
        order by case score_source when 'manual' then 1 else 2 end
    ) = 1

)

select * from superseded
