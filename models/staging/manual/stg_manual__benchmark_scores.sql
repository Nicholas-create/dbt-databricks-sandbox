with source as (

    select * from {{ source('manual', 'benchmark_scores') }}

),

-- the table is append-only: a correction or retraction is a newer row for the same
-- benchmark and model, so the latest row per key is the current state. Retracted rows
-- are kept here with their flag; dropping them is a downstream decision.
latest_entry as (

    select *
    from source
    qualify row_number() over (
        partition by benchmark_id, {{ model_match_key('model_name') }}
        order by entered_at desc, entry_id desc
    ) = 1

),

final as (

    select
        -- keys
        trim(benchmark_id) || '|' || {{ model_match_key('model_name') }}     as benchmark_model_key,
        entry_id,
        trim(benchmark_id)                                                   as benchmark_id,
        trim(model_name)                                                     as model_name,

        -- result, exactly as published (49.1 means 49.1%); converted to site units downstream
        score                                                                as score_as_published,
        nullif(trim(harness), '')                                            as harness,
        nullif(trim(effort), '')                                             as effort,

        -- model metadata (null = fall back to Epoch)
        nullif(trim(lab), '')                                                as lab,
        is_open_weights,
        released_date,

        -- provenance
        trim(source_url)                                                     as source_url,
        source_type,
        nullif(trim(notes), '')                                              as notes,
        is_retracted,
        entered_at

    from latest_entry

)

select * from final
