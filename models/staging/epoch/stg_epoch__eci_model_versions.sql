-- The inputs Epoch fed into its Capabilities Index: one row per model version per
-- benchmark result. Its value here is the pairing of each API model version
-- (claude-opus-5-5_medium) with Epoch's model name (Claude Opus 5.5): Epoch's own
-- mapping, used to put benchmark rows under the right model.
with rows as (

    select * from {{ ref('stg_epoch__benchmark_rows') }}
    where file_name = 'epoch_capabilities_index/processed_data_for_eci.csv'

),

final as (

    select
        benchmark_row_key,
        nullif(trim(fields['model_version']), '')                            as model_version,
        nullif(trim(fields['Model']), '')                                    as model_name,
        nullif(trim(fields['benchmark']), '')                                as benchmark_name,
        row_number
    from rows

)

select * from final
