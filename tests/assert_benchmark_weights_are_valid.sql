-- The combined scores are only as sound as their weights. Checks that each
-- category's benchmark weights add up to 1, that the Overall's add up to 1,
-- and that no category is given a negative share. Returns one row per broken
-- rule; the test passes when nothing comes back.
with benchmarks as (

    select * from {{ ref('dim_benchmarks') }}

),

categories as (

    select * from {{ ref('benchmark_categories') }}

),

category_totals as (

    select
        category,
        sum(weight_in_category) as total_weight
    from benchmarks
    where is_in_combined_scores
    group by 1

),

category_problems as (

    select
        'weights in category ' || category || ' add up to '
        || cast(total_weight as string) as problem
    from category_totals
    where abs(total_weight - 1) > 1e-9

),

overall_total as (

    select
        'weights in the Overall add up to '
        || cast(sum(weight_in_overall) as string) as problem
    from benchmarks
    where is_in_combined_scores
    having abs(sum(weight_in_overall) - 1) > 1e-9

),

negative_categories as (

    select
        concat(
            'category ', category_id, ' has a negative overall_weight'
        ) as problem
    from categories
    where overall_weight < 0

)

select * from category_problems
union all
select * from overall_total
union all
select * from negative_categories
