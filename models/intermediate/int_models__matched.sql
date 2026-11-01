with openrouter_models as (

    -- one row per OpenRouter model, using its most recent display name
    select
        model_id,
        model_display_name,
        provider_slug
    from {{ ref('stg_openrouter__models') }}
    qualify row_number() over (
        partition by model_id
        order by snapshot_date desc
    ) = 1

),

cleaned as (

    select
        model_id,
        model_display_name,
        provider_slug,

        case
            when model_display_name rlike '\\(batch\\)\\s*$' then 'batch'
            when model_display_name rlike '\\(free\\)\\s*$'  then 'free'
            else 'standard'
        end as pricing_variant,

        -- strip "Provider: " prefix, then (batch)/(free) tag, then trailing MMDD date code
        regexp_replace(
            regexp_replace(
                trim(regexp_replace(model_display_name, '^[^:]*: ', '')),
                '\\s*\\((batch|free)\\)$', ''),
            '\\s+(0[1-9]|1[0-2])[0-3][0-9]$', ''
        ) as base_model_name

    from openrouter_models

),

openrouter_keyed as (

    select
        *,
        {{ model_match_key('base_model_name') }} as match_key
    from cleaned

),

epoch_keyed as (

    select
        model_name as epoch_model_name,
        {{ model_match_key('model_name') }} as match_key
    from {{ ref('stg_epoch__notable_models') }}

),

overrides as (

    select
        openrouter_model_id,
        epoch_model_name,
        match_note
    from {{ ref('model_match_overrides') }}

),

final as (

    select
        o.model_id                                          as openrouter_model_id,
        o.model_display_name                                as openrouter_display_name,
        o.provider_slug,
        o.pricing_variant,
        coalesce(m.epoch_model_name, e.epoch_model_name)    as epoch_model_name,
        case
            when m.epoch_model_name is not null then 'manual'
            when e.epoch_model_name is not null then 'automatic'
            else 'unmatched'
        end                                                 as match_method,
        m.match_note

    from openrouter_keyed o
    left join overrides m
        on o.model_id = m.openrouter_model_id
    left join epoch_keyed e
        on o.match_key = e.match_key

)

select * from final