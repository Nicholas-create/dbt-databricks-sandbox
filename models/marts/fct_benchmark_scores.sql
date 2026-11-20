-- One row per benchmark per model: the score the site shows, where it came
-- from, and the model details the leaderboard needs. Every row carries its own
-- lab and release date (tested on the seed); open weights falls back to the
-- priced-models mart when the row leaves it blank.
with scores as (

    select * from {{ ref('stg_manual__benchmark_scores') }}

),

benchmarks as (

    select
        benchmark_id,
        category,
        unit
    from {{ ref('stg_manual__benchmarks') }}

),

prices as (

    select
        model_name,
        is_open_weights,
        output_price_usd_per_mtok
    from {{ ref('rpt_models_latest_price') }}
    where
        has_price
        and output_price_usd_per_mtok > 0

),

final as (

    select
        -- keys
        scores.benchmark_model_key,
        scores.benchmark_id,
        benchmarks.category,
        scores.model_name,
        scores.model_key,

        -- result in site units: entered as published (49.1 = 49.1%), the site
        -- works in shares (0.491)
        case
            when benchmarks.unit = 'pct' then scores.score_as_published / 100
            else scores.score_as_published
        end as score,
        scores.harness,
        scores.effort,

        -- provenance
        scores.source_type,
        scores.source_url,
        scores.notes,

        -- model details
        scores.lab,
        coalesce(
            scores.is_open_weights, prices.is_open_weights
        ) as is_open_weights,
        scores.released_date,
        prices.output_price_usd_per_mtok

    from scores
    -- left join: an unknown benchmark_id still comes through, so the
    -- relationships test on benchmark_id fails loudly instead of the row
    -- vanishing
    left join benchmarks
        on scores.benchmark_id = benchmarks.benchmark_id
    left join prices
        on scores.model_name = prices.model_name

)

select * from final
