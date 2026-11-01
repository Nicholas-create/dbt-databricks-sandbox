with models as (

    select * from {{ ref('stg_epoch__notable_models') }}

),

final as (

    select
        -- identity
        model_name,
        organization,
        organization_category,
        organization_country,
        base_model_name,

        -- release
        published_date,
        year(published_date)                        as release_year,

        -- classification
        domains,
        tasks,
        is_frontier_model,

        -- openness
        coalesce(model_accessibility, 'Unknown')    as access_type,
        case
            when model_accessibility like 'Open weights%' then true
            when model_accessibility is null              then null
            else false
        end                                         as is_open_weights,

        -- scale and cost
        parameter_count,
        training_compute_flop,
        training_compute_cost_2023_usd,

        -- provenance
        source_url

    from models

)

select * from final