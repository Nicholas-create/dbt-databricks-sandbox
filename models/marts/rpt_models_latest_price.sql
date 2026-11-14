with epoch_models as (

    select * from {{ ref('dim_models') }}

),

model_prices_daily as (

    select * from {{ ref('fct_model_prices_daily') }}

),

-- each standard listing at its most recent snapshot
latest_prices as (

    select *
    from model_prices_daily
    where
        epoch_model_name is not null
        and pricing_variant = 'standard'
    qualify row_number() over (
        partition by openrouter_model_id
        order by snapshot_date desc
    ) = 1

),

ranked as (

    select
        *,
        count(*) over (partition by epoch_model_name) as standard_listings,
        row_number() over (
            partition by epoch_model_name
            order by
                -- 1. main listing before dated checkpoints (-0324, -2507,
                -- -2024-08-06) and previews
                case
                    when
                        openrouter_model_id
                        rlike '-[0-9]{4}(-[0-9]{2}-[0-9]{2})?$|-preview'
                        then 1
                    else 0
                end,
                -- 2. then the cheaper listing
                output_price_usd_per_mtok nulls last,
                -- 3. then alphabetical, so the result never changes between
                -- runs
                openrouter_model_id
        ) as listing_rank
    from latest_prices

),

chosen as (

    select * from ranked
    where listing_rank = 1

),

final as (

    select
        -- Epoch: the spine
        epoch_models.model_name,
        epoch_models.organization,
        epoch_models.published_date,
        epoch_models.release_year,
        epoch_models.access_type,
        epoch_models.is_open_weights,
        epoch_models.domains,

        -- OpenRouter: the enrichment
        chosen.openrouter_model_id is not null as has_price,
        chosen.openrouter_model_id as priced_listing_id,
        chosen.standard_listings,
        chosen.input_price_usd_per_mtok,
        chosen.output_price_usd_per_mtok,
        chosen.cached_input_price_usd_per_mtok,
        chosen.context_length_tokens,
        chosen.snapshot_date as price_as_of_date

    from epoch_models
    left join chosen
        on epoch_models.model_name = chosen.epoch_model_name

)

select * from final
