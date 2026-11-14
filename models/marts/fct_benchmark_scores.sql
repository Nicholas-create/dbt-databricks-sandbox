-- One row per benchmark per model: the score the site shows, where it came from,
-- and the model details the leaderboard needs. Blank model details fall back to
-- Epoch's Capabilities Index, then to the priced-models mart.
with scores as (

    select * from {{ ref('int_benchmark_scores__unioned') }}

),

benchmarks as (

    select benchmark_id, category from {{ ref('int_benchmarks__unioned') }}

),

eci as (

    select * from {{ ref('stg_epoch__eci_scores') }}

),

prices as (

    select model_name, is_open_weights, output_price_usd_per_mtok
    from {{ ref('rpt_models_latest_price') }}
    where has_price
      and output_price_usd_per_mtok > 0

),

final as (

    select
        -- keys
        s.benchmark_model_key,
        s.benchmark_id,
        b.category,
        s.model_name,
        s.model_key,

        -- result (site units: a share 0-1 for pct benchmarks)
        s.score,
        s.harness,
        s.effort,

        -- provenance
        s.score_source,
        s.source_type,
        s.source_url,
        s.notes,

        -- model details
        coalesce(
            s.lab,
            -- first listed organization, with long names shortened for the site
            case trim(split_part(coalesce(e.organization, s.organization), ',', 1))
                when 'Google DeepMind'  then 'Google'
                when 'Meta AI'          then 'Meta'
                when 'Z.ai (Zhipu AI)'  then 'Z.ai'
                when 'Xiaomi Corp'      then 'Xiaomi'
                when 'Mistral AI'       then 'Mistral'
                else trim(split_part(coalesce(e.organization, s.organization), ',', 1))
            end
        )                                                                    as lab,
        coalesce(
            s.is_open_weights,
            case when e.accessibility_group is not null
                 then e.accessibility_group = 'Open weights' end,
            p.is_open_weights
        )                                                                    as is_open_weights,
        coalesce(s.release_date, e.release_date)                             as released_date,
        p.output_price_usd_per_mtok

    from scores s
    left join benchmarks b
        on s.benchmark_id = b.benchmark_id
    left join eci e
        on s.model_name = e.model_name
    left join prices p
        on s.model_name = p.model_name

)

select * from final
