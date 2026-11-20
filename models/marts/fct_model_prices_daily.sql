with prices as (

    select
        model_snapshot_key,
        model_id,
        provider_slug,
        snapshot_date,
        input_price_usd_per_mtok,
        output_price_usd_per_mtok,
        cached_input_price_usd_per_mtok,
        context_length_tokens,
        is_variable_priced
    from {{ ref('stg_openrouter__models') }}

),

matched as (

    select
        openrouter_model_id,
        model_name,
        match_method,
        pricing_variant
    from {{ ref('int_models__matched') }}

),

final as (

    select
        -- keys
        prices.model_snapshot_key,
        prices.model_id as openrouter_model_id,
        matched.model_name,
        prices.snapshot_date,

        -- attributes for slicing
        prices.provider_slug,
        matched.pricing_variant,
        matched.match_method,
        prices.is_variable_priced,

        -- measures
        round(prices.input_price_usd_per_mtok, 4) as input_price_usd_per_mtok,
        round(
            prices.output_price_usd_per_mtok, 4
        ) as output_price_usd_per_mtok,
        round(
            prices.cached_input_price_usd_per_mtok, 4
        ) as cached_input_price_usd_per_mtok,
        prices.context_length_tokens

    from prices
    left join matched
        on prices.model_id = matched.openrouter_model_id

)

select * from final
