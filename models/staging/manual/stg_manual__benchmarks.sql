with source as (

    select * from {{ ref('manual_benchmarks') }}

),

-- one row per benchmark_id in the seed (tested there), so only light tidying
-- here
final as (

    select
        trim(benchmark_id) as benchmark_id,
        trim(benchmark_name) as benchmark_name,
        trim(category) as category,
        nullif(trim(publisher), '') as publisher,
        nullif(trim(source_url), '') as source_url,
        unit,
        unit_max,
        nullif(trim(benchmark_family), '') as benchmark_family,
        nullif(trim(variant_label), '') as variant_label,
        sort_order,
        nullif(trim(notes), '') as notes
    from source

)

select * from final
