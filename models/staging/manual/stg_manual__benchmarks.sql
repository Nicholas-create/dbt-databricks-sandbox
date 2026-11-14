with source as (

    select * from {{ source('manual', 'benchmarks') }}

),

-- append-only: the latest row per benchmark_id is the current definition
latest_entry as (

    select *
    from source
    qualify row_number() over (
        partition by trim(benchmark_id)
        order by entered_at desc
    ) = 1

),

final as (

    select
        trim(benchmark_id)                                                   as benchmark_id,
        trim(benchmark_name)                                                 as benchmark_name,
        trim(category)                                                       as category,
        nullif(trim(publisher), '')                                          as publisher,
        nullif(trim(source_url), '')                                         as source_url,
        unit,
        unit_max,
        nullif(trim(benchmark_family), '')                                   as benchmark_family,
        nullif(trim(variant_label), '')                                      as variant_label,
        nullif(trim(notes), '')                                              as notes,
        is_retracted,
        entered_at
    from latest_entry

)

select * from final
