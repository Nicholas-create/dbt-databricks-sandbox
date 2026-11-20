-- Every model the project knows about: Epoch's notable-models file plus models
-- added by hand in the seed manual_models (new releases Epoch doesn't list
-- yet). One row per model_name. On a clash, a value filled in by hand wins and
-- Epoch fills the rest, the same rule as int_benchmarks__unioned. Columns only
-- Epoch has (parameters, compute, tasks) stay null for hand-entered models.
with epoch_models as (

    select * from {{ ref('stg_epoch__notable_models') }}

),

manual_models as (

    select * from {{ ref('stg_manual__models') }}

),

final as (

    select
        -- identity
        coalesce(
            manual_models.model_name, epoch_models.model_name
        ) as model_name,
        coalesce(
            manual_models.organization, epoch_models.organization
        ) as organization,
        epoch_models.organization_category,
        coalesce(
            manual_models.organization_country,
            epoch_models.organization_country
        ) as organization_country,
        epoch_models.base_model_name,

        -- release and classification
        coalesce(
            manual_models.published_date, epoch_models.published_date
        ) as published_date,
        coalesce(manual_models.domains, epoch_models.domains) as domains,
        epoch_models.tasks, -- noqa: RF04
        epoch_models.is_frontier_model,

        -- openness
        coalesce(
            manual_models.model_accessibility,
            epoch_models.model_accessibility
        ) as model_accessibility,

        -- scale and cost (Epoch only)
        epoch_models.parameter_count,
        epoch_models.training_compute_flop,
        epoch_models.training_compute_cost_2023_usd,

        -- provenance
        coalesce(
            manual_models.source_url, epoch_models.source_url
        ) as source_url,
        case
            when
                epoch_models.model_name is not null
                and manual_models.model_name is not null
                then 'epoch+manual'
            when epoch_models.model_name is not null then 'epoch'
            else 'manual'
        end as model_source

    from epoch_models
    full outer join manual_models
        on epoch_models.model_name = manual_models.model_name

)

select * from final
