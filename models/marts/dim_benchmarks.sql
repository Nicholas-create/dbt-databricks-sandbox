-- One row per benchmark, with its category, how many models have a score, its
-- place in the category (relevance_rank: 1 = leftmost pill after "Overall"),
-- and its weight in the combined "Overall" scores
-- (fct_benchmark_category_scores).
{# a model counts as "current" if released in this window #}
{% set recent_days = 180 %}
{# headroom is measured on this many best current scores #}
{% set leaders = 5 %}
{# a benchmark's weight in the Overall halves every this many years #}
{% set half_life_years = var('benchmark_half_life_years') %}

with benchmarks as (

    select * from {{ ref('stg_manual__benchmarks') }}

),

categories as (

    select * from {{ ref('benchmark_categories') }}

),

scores as (

    select * from {{ ref('fct_benchmark_scores') }}

),

-- "now" for the recency weights: the newest model release in the data, not
-- the build date, so the weights only change when the data does and a rebuild
-- reproduces them exactly
reference_date as (

    select max(released_date) as reference_date
    from scores

),

-- every agent harness seen on the benchmark, so the site can list them
harness_lists as (

    select
        benchmark_id,
        array_sort(collect_set(harness)) as harnesses
    from scores
    where harness is not null
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
        benchmarks.released_date,
        coalesce(harness_lists.harnesses, array()) as harnesses,
        coalesce(coverage.n_models, 0) as n_models,
        coverage.latest_release_date,
        coalesce(coverage.n_recent_models, 0) as n_recent_models,
        coverage.leader_headroom,
        coalesce(relevance.relevance_score, 0) as relevance_score,
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

),

-- ── Weights for the combined scores ─────────────────────────────────────────
-- A benchmark joins the fit when it has a bounded scale (an open-ended index
-- like an Elo rating can't be a share of tasks) and at least two models: one
-- model alone compares nothing. Its recency weight halves every
-- half_life_years since its release: old benchmarks saturate and leak into
-- training data, so they say less about today's models.
recency as (

    select
        ordered.*,
        ordered.is_on_site
        and ordered.unit <> 'index'
        and ordered.n_models >= 2
        and ordered.category <> 'overall' as is_in_combined_scores,
        months_between(
            reference_date.reference_date, ordered.released_date
        ) / 12 as age_years,
        -- capped at 1: a release date after the newest model counts as new
        least(
            1.0,
            power(
                0.5,
                months_between(
                    reference_date.reference_date, ordered.released_date
                ) / 12 / {{ half_life_years }}
            )
        ) as recency_weight
    from ordered
    cross join reference_date

),

-- Versions of one benchmark (a family) share one benchmark's worth of weight,
-- so a benchmark published in three variants doesn't count three times.
-- Then each category's weights are scaled to add up to 1.
within_category as (

    select
        *,
        case
            when is_in_combined_scores
                then
                    recency_weight
                    / count_if(is_in_combined_scores) over (
                        partition by category, benchmark_family
                    )
        end as family_weight
    from recency

),

category_weights as (

    select
        *,
        family_weight
        / sum(family_weight) over (partition by category) as weight_in_category
    from within_category

),

-- Each category's share of the Overall: its overall_weight (seed
-- benchmark_categories, 1 = equal) over the total for the categories that have
-- a benchmark in the fit. Equal shares stop the category with the most
-- benchmarks (Agents) from outvoting the rest.
category_shares as (

    select
        categories_in_fit.category,
        categories.overall_weight
        / sum(categories.overall_weight) over () as category_share
    from (
        select distinct category
        from category_weights
        where is_in_combined_scores
    ) as categories_in_fit
    inner join categories
        on categories_in_fit.category = categories.category_id

),

weighted as (

    select
        category_weights.* except (family_weight),
        category_weights.weight_in_category
        * category_shares.category_share as weight_in_overall
    from category_weights
    left join category_shares
        on category_weights.category = category_shares.category

)

select * from weighted
