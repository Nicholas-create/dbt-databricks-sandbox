with source as (

    select * from {{ ref('manual_benchmark_scores') }}

),

-- The seed holds the current state only: a correction is an edited line, a
-- withdrawal a deleted line, and Git history keeps what was there before. So
-- there is nothing to deduplicate here, only light tidying.
final as (

    select
        -- keys
        trim(benchmark_id)
        || '|'
        || {{ model_match_key('model_name') }} as benchmark_model_key,
        trim(benchmark_id) as benchmark_id,
        trim(model_name) as model_name,

        -- result, exactly as published (49.1 means 49.1%); converted to site
        -- units downstream
        score as score_as_published,
        nullif(trim(harness), '') as harness,
        nullif(trim(effort), '') as effort,

        -- model metadata (null = fall back to Epoch)
        nullif(trim(lab), '') as lab,
        is_open_weights,
        released_date,

        -- provenance
        trim(source_url) as source_url,
        source_type,
        nullif(trim(notes), '') as notes

    from source

)

select * from final
