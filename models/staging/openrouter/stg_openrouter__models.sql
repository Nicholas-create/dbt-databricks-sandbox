with source as (

    select * from {{ source('openrouter', 'models_daily') }}

),

-- keep only the latest load per model per day, so manual re-runs never double-count
deduplicated as (

    select *
    from source
    qualify row_number() over (
        partition by model_id, to_date(loaded_at)
        order by loaded_at desc
    ) = 1

),

parsed as (

    select
        -- keys
        model_id || '|' || cast(to_date(loaded_at) as string)          as model_snapshot_key,
        model_id,
        raw_json:canonical_slug::string                                as canonical_slug,
        split_part(model_id, '/', 1)                                   as provider_slug,
        raw_json:name::string                                          as model_display_name,
        raw_json:hugging_face_id::string                               as hugging_face_id,

        -- dates
        timestamp_seconds(raw_json:created::bigint)                    as listed_at,
        try_to_date(raw_json:knowledge_cutoff::string)                 as knowledge_cutoff_date,
        try_to_date(raw_json:expiration_date::string)                  as expiration_date,

        -- capabilities
        raw_json:context_length::int                                   as context_length_tokens,
        raw_json:top_provider.max_completion_tokens::int               as max_output_tokens,
        raw_json:architecture.modality::string                         as modality,
        from_json(raw_json:architecture.input_modalities,  'array<string>') as input_modalities,
        from_json(raw_json:architecture.output_modalities, 'array<string>') as output_modalities,

        -- pricing: OpenRouter gives USD per token as text; convert to USD per million tokens.
        -- Routers report -1 (price varies by routed model), so negatives become null.
        case when cast(raw_json:pricing.prompt as decimal(20, 12)) >= 0
             then cast(raw_json:pricing.prompt as decimal(20, 12)) * 1000000
        end                                                            as input_price_usd_per_mtok,
        case when cast(raw_json:pricing.completion as decimal(20, 12)) >= 0
             then cast(raw_json:pricing.completion as decimal(20, 12)) * 1000000
        end                                                            as output_price_usd_per_mtok,
        case when cast(raw_json:pricing.input_cache_read as decimal(20, 12)) >= 0
             then cast(raw_json:pricing.input_cache_read as decimal(20, 12)) * 1000000
        end                                                            as cached_input_price_usd_per_mtok,
        -- true if any price carried the placeholder, so every nulled-out price keeps its meaning
        coalesce(
            cast(raw_json:pricing.prompt           as decimal(20, 12)) < 0
         or cast(raw_json:pricing.completion       as decimal(20, 12)) < 0
         or cast(raw_json:pricing.input_cache_read as decimal(20, 12)) < 0,
            false
        )                                                              as is_variable_priced,

        -- snapshot
        to_date(loaded_at)                                             as snapshot_date,
        loaded_at

    from deduplicated

)

select * from parsed