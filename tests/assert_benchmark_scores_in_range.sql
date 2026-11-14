-- Every score must sit inside its benchmark's scale: 0 to unit_max in site units.
-- Catches a manual entry that is too big for its scale: a typo like 491 for
-- 49.1%, or a points score above the benchmark's maximum. (It can't catch 0.491
-- typed for 49.1%: that becomes 0.5%, which is a valid, just wrong, value. The
-- spot check after each entry covers that.)
select
    s.benchmark_model_key,
    s.score,
    b.unit,
    b.unit_max
from {{ ref('fct_benchmark_scores') }} s
inner join {{ ref('dim_benchmarks') }} b
    on s.benchmark_id = b.benchmark_id
where s.score < 0
   or (b.unit_max is not null and s.score > b.unit_max)
