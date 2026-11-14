-- Every score must sit inside its benchmark's scale: 0 to unit_max in site
-- units. Catches a manual entry that is too big for its scale: a typo like 491
-- for 49.1%, or a points score above the benchmark's maximum. (It can't catch
-- 0.491 typed for 49.1%: that becomes 0.5%, which is a valid, just wrong,
-- value. The spot check after each entry covers that.)
with scores as (

    select * from {{ ref('fct_benchmark_scores') }}

),

benchmarks as (

    select * from {{ ref('dim_benchmarks') }}

),

out_of_range as (

    select
        scores.benchmark_model_key,
        scores.score,
        benchmarks.unit,
        benchmarks.unit_max
    from scores
    inner join benchmarks
        on scores.benchmark_id = benchmarks.benchmark_id
    where
        scores.score < 0
        or (
            benchmarks.unit_max is not null
            and scores.score > benchmarks.unit_max
        )

)

select * from out_of_range
