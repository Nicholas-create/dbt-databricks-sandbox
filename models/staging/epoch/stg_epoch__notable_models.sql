with source as (

    select * from {{ source('epoch', 'notable_ai_models') }}

),

renamed as (

    select
        -- identity
        `Model`                             as model_name,
        `Organization`                      as organization,
        `Organization categorization`       as organization_category,
        `Country (of organization)`         as organization_country,
        `Base model`                        as base_model_name,

        -- release and classification
        `Publication date`                  as published_date,
        `Domain`                            as domains,
        `Task`                              as tasks,
        `Notability criteria`               as notability_criteria,
        `Frontier model`                    as is_frontier_model,

        -- openness
        `Model accessibility`               as model_accessibility,
        `Open model weights?`               as open_model_weights,
        `Training code accessibility`       as training_code_accessibility,
        `Inference code accessibility`      as inference_code_accessibility,

        -- scale and training
        `Parameters`                        as parameter_count,
        `Training compute (FLOP)`           as training_compute_flop,
        `Finetune compute (FLOP)`           as finetune_compute_flop,
        `Training dataset`                  as training_dataset,
        `Training dataset size (total)`     as training_dataset_size,
        `Epochs`                            as training_epochs,
        `Batch size`                        as batch_size,
        `Training time (hours)`             as training_time_hours,
        `Training hardware`                 as training_hardware,
        `Hardware quantity`                 as hardware_quantity,
        `Hardware utilization (MFU)`        as hardware_utilization_mfu,
        `Hardware utilization (HFU)`        as hardware_utilization_hfu,
        `Training power draw (W)`           as training_power_draw_watts,
        `Numerical format`                  as numerical_format,

        -- cost estimates
        `Training compute cost (2023 USD)`  as training_compute_cost_2023_usd,
        `Training compute cost (cloud)`     as training_compute_cost_cloud,
        `Training compute cost (upfront)`   as training_compute_cost_upfront,
        `Hardware acquisition cost`         as hardware_acquisition_cost,

        -- provenance
        `Confidence`                        as estimate_confidence,
        `Citations`                         as citation_count,
        `Link`                              as source_url,
        `Reference`                         as reference_title

    from source

)

select * from renamed