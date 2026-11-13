with epoch_models as (

    select * from {{ ref('dim_models') }}

),

latest_prices as (

    -- each standard listing at its most recent snapshot
    select *
    from {{ ref('fct_model_prices_daily') }}
    where epoch_model_name is not null
      and pricing_variant = 'standard'
    qualify row_number() over (
        partition by openrouter_model_id
        order by snapshot_date desc
    ) = 1

),

ranked as (

    select
        *,
        count(*) over (partition by epoch_model_name)          as standard_listings,
        row_number() over (
            partition by epoch_model_name
            order by
                -- 1. main listing before dated checkpoints (-0324, -2507, -2024-08-06) and previews
                case
                    when openrouter_model_id rlike '-[0-9]{4}(-[0-9]{2}-[0-9]{2})?$|-preview' then 1
                    else 0
                end,
                -- 2. then the cheaper listing
                output_price_usd_per_mtok nulls last,
                -- 3. then alphabetical, so the result never changes between runs
                openrouter_model_id
        )                                                      as listing_rank
    from latest_prices

),

chosen as (

    select * from ranked
    where listing_rank = 1

),

final as (

    select
        -- Epoch: the spine
        e.model_name,
        e.organization,
        e.published_date,
        e.release_year,
        e.access_type,
        e.is_open_weights,
        e.domains,

        -- OpenRouter: the enrichment
        c.openrouter_model_id is not null                      as has_price,
        c.openrouter_model_id                                  as priced_listing_id,
        c.standard_listings,
        c.input_price_usd_per_mtok,
        c.output_price_usd_per_mtok,
        c.cached_input_price_usd_per_mtok,
        c.context_length_tokens,
        c.snapshot_date                                        as price_as_of_date

    from epoch_models e
    left join chosen c
        on e.model_name = c.epoch_model_name

)

select * from final
