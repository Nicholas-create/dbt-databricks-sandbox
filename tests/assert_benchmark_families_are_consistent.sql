-- A benchmark family is shown as one split pill, so all its versions must sit
-- in the same category, and every version in a family of two or more needs a
-- label for its segment. Returns each family that breaks either rule.
with benchmarks as (

    select * from {{ ref('dim_benchmarks') }}

),

families as (

    select
        benchmark_family,
        count(*) as n_versions,
        count(distinct category) as n_categories,
        count_if(variant_label is null) as n_unlabelled
    from benchmarks
    group by 1

)

select *
from families
where
    n_versions > 1
    and (n_categories > 1 or n_unlabelled > 0)
