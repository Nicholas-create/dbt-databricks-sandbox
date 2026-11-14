-- One row per benchmark per model: the score the site shows, where it came
-- from, and the model details the leaderboard needs. Blank model details fall
-- back to Epoch's Capabilities Index, then to the priced-models mart.
with scores as (

    select * from {{ ref('int_benchmark_scores__unioned') }}

),

benchmarks as (

    select
        benchmark_id,
        category
    from {{ ref('int_benchmarks__unioned') }}

),

eci_scores as (

    select * from {{ ref('stg_epoch__eci_scores') }}

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

        -- result (site units: a share 0-1 for pct benchmarks)
        scores.score,
        scores.harness,
        scores.effort,

        -- provenance
        scores.score_source,
        scores.source_type,
        scores.source_url,
        scores.notes,

        -- model details
        coalesce(
            scores.lab,
            -- first listed organization, with long names shortened for the
            -- site
            case trim(
                split_part(
                    coalesce(eci_scores.organization, scores.organization),
                    ',',
                    1
                )
            )
                when 'Google DeepMind' then 'Google'
                when 'Meta AI' then 'Meta'
                when 'Z.ai (Zhipu AI)' then 'Z.ai'
                when 'Xiaomi Corp' then 'Xiaomi'
                when 'Mistral AI' then 'Mistral'
                else trim(
                    split_part(
                        coalesce(eci_scores.organization, scores.organization),
                        ',',
                        1
                    )
                )
            end
        ) as lab,
        coalesce(
            scores.is_open_weights,
            case
                when eci_scores.accessibility_group is not null
                    then eci_scores.accessibility_group = 'Open weights'
            end,
            prices.is_open_weights
        ) as is_open_weights,
        coalesce(scores.release_date, eci_scores.release_date) as released_date,
        prices.output_price_usd_per_mtok

    from scores
    left join benchmarks
        on scores.benchmark_id = benchmarks.benchmark_id
    left join eci_scores
        on scores.model_name = eci_scores.model_name
    left join prices
        on scores.model_name = prices.model_name

)

select * from final
