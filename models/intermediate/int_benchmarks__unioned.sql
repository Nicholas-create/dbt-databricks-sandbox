-- Every benchmark the site can show: the Epoch catalog seed plus definitions
-- entered by hand in raw_manual.benchmarks. One row per benchmark_id.
-- On a clash, the manual row overrides how the benchmark is displayed (name,
-- category, publisher...), while the seed still says how to read Epoch's file.
with catalog as (

    select * from {{ ref('benchmark_catalog') }}

),

manual as (

    select * from {{ ref('stg_manual__benchmarks') }}
    where not is_retracted

),

final as (

    select
        coalesce(m.benchmark_id, c.benchmark_id)                             as benchmark_id,
        coalesce(m.benchmark_name, c.benchmark_name)                         as benchmark_name,
        coalesce(m.category, c.category)                                     as category,
        coalesce(m.publisher, c.publisher)                                   as publisher,
        coalesce(m.source_url, c.source_url)                                 as source_url,
        coalesce(m.unit, c.unit)                                             as unit,
        -- a share-of-tasks benchmark tops out at 1 even when the entry left it blank
        coalesce(m.unit_max, c.unit_max, case when coalesce(m.unit, c.unit) = 'pct' then 1 end)
                                                                             as unit_max,
        -- versions of one benchmark share a family (one split pill on the site)
        coalesce(m.benchmark_family, c.benchmark_family)                     as benchmark_family,
        coalesce(m.variant_label, c.variant_label)                           as variant_label,
        -- seed order first, then hand-added benchmarks in the order they were defined
        coalesce(c.sort_order, 1000 + row_number() over (order by m.entered_at, m.benchmark_id))
                                                                             as sort_order,

        -- how to read Epoch's file (null for benchmarks Epoch doesn't carry)
        c.epoch_file,
        c.score_column,
        c.score_scale,

        case
            when c.benchmark_id is not null and m.benchmark_id is not null then 'epoch_catalog+manual'
            when c.benchmark_id is not null                                then 'epoch_catalog'
            else 'manual'
        end                                                                  as defined_in

    from catalog c
    full outer join manual m
        on c.benchmark_id = m.benchmark_id

)

select * from final
