with source as (

    select * from {{ ref('manual_models') }}

),

-- one row per model_name in the seed (tested there), so only light tidying
-- here; empty text becomes null so int_models__unioned falls back to Epoch
final as (

    select
        trim(model_name) as model_name,
        nullif(trim(organization), '') as organization,
        nullif(trim(organization_country), '') as organization_country,
        published_date,
        nullif(trim(model_accessibility), '') as model_accessibility,
        nullif(trim(domains), '') as domains,
        nullif(trim(source_url), '') as source_url,
        nullif(trim(notes), '') as notes
    from source

)

select * from final
