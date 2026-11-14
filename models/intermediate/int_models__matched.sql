with openrouter_models as (

    select
        model_id,
        model_display_name,
        provider_slug,
        snapshot_date
    from {{ ref('stg_openrouter__models') }}

),

epoch_models as (

    select model_name
    from {{ ref('stg_epoch__notable_models') }}

),

overrides as (

    select
        openrouter_model_id,
        epoch_model_name,
        match_note
    from {{ ref('model_match_overrides') }}

),

-- one row per OpenRouter model, using its most recent display name
openrouter_latest as (

    select
        model_id,
        model_display_name,
        provider_slug
    from openrouter_models
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
            when model_display_name rlike '\\(free\\)\\s*$' then 'free'
            else 'standard'
        end as pricing_variant,

        -- strip "Provider: " prefix, then (batch)/(free) tag, then trailing
        -- MMDD date code
        regexp_replace(
            regexp_replace(
                trim(regexp_replace(model_display_name, '^[^:]*: ', '')),
                '\\s*\\((batch|free)\\)$',
                ''
            ),
            '\\s+(0[1-9]|1[0-2])[0-3][0-9]$',
            ''
        ) as base_model_name

    from openrouter_latest

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
    from epoch_models

),

final as (

    select
        openrouter_keyed.model_id as openrouter_model_id,
        openrouter_keyed.model_display_name as openrouter_display_name,
        openrouter_keyed.provider_slug,
        openrouter_keyed.pricing_variant,
        coalesce(
            overrides.epoch_model_name, epoch_keyed.epoch_model_name
        ) as epoch_model_name,
        case
            when overrides.epoch_model_name is not null then 'manual'
            when epoch_keyed.epoch_model_name is not null then 'automatic'
            else 'unmatched'
        end as match_method,
        overrides.match_note

    from openrouter_keyed
    left join overrides
        on openrouter_keyed.model_id = overrides.openrouter_model_id
    left join epoch_keyed
        on openrouter_keyed.match_key = epoch_keyed.match_key

)

select * from final
