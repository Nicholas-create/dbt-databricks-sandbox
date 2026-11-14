with source as (

    select * from {{ source('epoch', 'benchmark_rows') }}

),

-- the baseline is loaded once, but a re-run appends a complete second copy:
-- only the latest load counts, so nothing is ever double-counted
latest_load as (

    select *
    from source
    where loaded_at = (select max(loaded_at) from source)

),

parsed as (

    select
        file_name,
        row_number,
        -- every column of the row, whatever this file calls it; the score column differs per
        -- file, so it's picked downstream using the benchmark_catalog seed
        from_json(raw_json, 'map<string,string>')                            as fields,
        loaded_at
    from latest_load

),

final as (

    select
        -- keys
        file_name || '|' || cast(row_number as string)                       as benchmark_row_key,
        file_name,
        row_number,

        -- model identity, as each benchmark file names it
        nullif(trim(fields['Model version']), '')                            as model_version,
        nullif(trim(fields['Name']), '')                                     as display_name,

        -- run details. Files call the agent setup Harness, Agent or Scaffold, and the effort
        -- setting Reasoning effort or Reasoning level: one field each under different names,
        -- never two competing values in the same file.
        nullif(trim(coalesce(fields['Harness'], fields['Agent'], fields['Scaffold'])), '')
                                                                             as harness,
        nullif(trim(coalesce(fields['Reasoning effort'], fields['Reasoning level'])), '')
                                                                             as effort,

        -- model metadata carried in the benchmark file
        try_to_date(nullif(trim(fields['Release date']), ''))                as release_date,
        nullif(trim(fields['Organization']), '')                             as organization,
        nullif(trim(fields['Model Org']), '')                                as model_org,

        fields,
        loaded_at

    from parsed

)

select * from final
