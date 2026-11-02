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
        epoch_model_name,
        match_method,
        pricing_variant
    from {{ ref('int_models__matched') }}

),

final as (

    select
        -- keys
        p.model_snapshot_key,
        p.model_id                                      as openrouter_model_id,
        m.epoch_model_name,
        p.snapshot_date,

        -- attributes for slicing
        p.provider_slug,
        m.pricing_variant,
        m.match_method,
        p.is_variable_priced,

        -- measures
        round(p.input_price_usd_per_mtok, 4)            as input_price_usd_per_mtok,
        round(p.output_price_usd_per_mtok, 4)           as output_price_usd_per_mtok,
        round(p.cached_input_price_usd_per_mtok, 4)     as cached_input_price_usd_per_mtok,
        p.context_length_tokens

    from prices p
    left join matched m
        on p.model_id = m.openrouter_model_id

)

select * from final
