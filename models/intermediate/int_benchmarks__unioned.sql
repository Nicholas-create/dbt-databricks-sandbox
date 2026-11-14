-- Every benchmark the site can show: the Epoch catalog seed plus definitions
-- entered by hand in the seed manual_benchmarks. One row per benchmark_id.
-- On a clash, the manual row overrides how the benchmark is displayed (name,
-- category, publisher...), while the catalog still says how to read Epoch's
-- file.
with catalog as (

    select * from {{ ref('benchmark_catalog') }}

),

manual as (

    select * from {{ ref('stg_manual__benchmarks') }}

),

final as (

    select
        coalesce(manual.benchmark_id, catalog.benchmark_id) as benchmark_id,
        coalesce(
            manual.benchmark_name, catalog.benchmark_name
        ) as benchmark_name,
        coalesce(manual.category, catalog.category) as category,
        coalesce(manual.publisher, catalog.publisher) as publisher,
        coalesce(manual.source_url, catalog.source_url) as source_url,
        coalesce(manual.unit, catalog.unit) as unit,
        -- a share-of-tasks benchmark tops out at 1 even when the entry left it
        -- blank
        coalesce(
            manual.unit_max,
            catalog.unit_max,
            case when coalesce(manual.unit, catalog.unit) = 'pct' then 1 end
        ) as unit_max,
        -- versions of one benchmark share a family (one split pill on the site)
        coalesce(
            manual.benchmark_family, catalog.benchmark_family
        ) as benchmark_family,
        coalesce(manual.variant_label, catalog.variant_label) as variant_label,
        -- catalog order first (1, 2, ...), then hand-added benchmarks by their
        -- own sort_order (1010, 1020, ...); orders the versions inside a split
        -- pill
        coalesce(catalog.sort_order, manual.sort_order) as sort_order,

        -- how to read Epoch's file (null for benchmarks Epoch doesn't carry)
        catalog.epoch_file,
        catalog.score_column,
        catalog.score_scale,

        case
            when
                catalog.benchmark_id is not null
                and manual.benchmark_id is not null
                then 'epoch_catalog+manual'
            when catalog.benchmark_id is not null then 'epoch_catalog'
            else 'manual'
        end as defined_in

    from catalog
    full outer join manual
        on catalog.benchmark_id = manual.benchmark_id

)

select * from final
