-- Epoch Capabilities Index: one row per model. Also Epoch's own record of each
-- model's organization, release date and weights access, used as a fallback for
-- benchmark rows that leave those blank.
with rows as (

    select * from {{ ref('stg_epoch__benchmark_rows') }}
    where file_name = 'epoch_capabilities_index/eci_scores.csv'

),

final as (

    select
        nullif(trim(fields['Model']), '')                                    as model_name,
        nullif(trim(fields['Display name']), '')                             as display_name,
        try_cast(fields['eci'] as double)                                    as eci_score,
        try_cast(fields['eci_ci_low'] as double)                             as eci_ci_low,
        try_cast(fields['eci_ci_high'] as double)                            as eci_ci_high,
        try_to_date(nullif(trim(fields['date']), ''))                        as release_date,
        nullif(trim(fields['Organization']), '')                             as organization,
        nullif(trim(fields['Model accessibility']), '')                      as model_accessibility,
        nullif(trim(fields['Accessibility group']), '')                      as accessibility_group,
        row_number
    from rows

)

select * from final
