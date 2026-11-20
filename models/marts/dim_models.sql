with models as (

    select * from {{ ref('stg_manual__models') }}

),

final as (

    select
        -- identity
        model_name,
        organization,
        organization_country,

        -- release
        published_date,
        year(published_date) as release_year,

        -- classification
        domains,

        -- openness
        coalesce(model_accessibility, 'Unknown') as access_type,
        case
            when model_accessibility like 'Open weights%' then true
            when model_accessibility is null then null
            else false
        end as is_open_weights,

        -- provenance
        source_url

    from models

)

select * from final
