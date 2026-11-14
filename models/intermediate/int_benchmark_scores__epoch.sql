-- Epoch's benchmark results, one row per benchmark per model: the model's best
-- run, with model names resolved to Epoch's own naming.
{% set effort_suffix = "(?i)_(max|xhigh|high|medium|low|minimal|none|unknown|thinking|[0-9]+k)$" %}
{% set effort_words  = "(?i)\\s*(\\((x?high|medium|low|max|minimal|none|thinking)\\)|\\s+(x?high|medium|low|max|minimal)$)" %}

with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}
    where epoch_file is not null

),

rows as (

    select * from {{ ref('stg_epoch__benchmark_rows') }}

),

-- Epoch's pairing of API model versions with model names. A version can appear on
-- many rows; the first row's name wins, so the result never changes between runs.
version_names as (

    select version_base, model_name
    from (
        select
            regexp_replace(lower(model_version), r'{{ effort_suffix }}', '')  as version_base,
            model_name,
            row_number
        from {{ ref('stg_epoch__eci_model_versions') }}
        where model_version is not null
          and model_name is not null
    )
    qualify row_number() over (partition by version_base order by row_number) = 1

),

scored as (

    select
        b.benchmark_id,
        b.unit,
        r.row_number,
        r.model_version,
        r.fields['Model']                                                    as eci_model_name,
        -- display name without "(high)"-style effort labels
        trim(regexp_replace(r.display_name, r'{{ effort_words }}', ''))       as clean_display_name,
        try_cast(r.fields[b.score_column] as double) * b.score_scale         as score,
        r.harness,
        r.effort,
        r.release_date,
        coalesce(r.organization, r.model_org)                                as organization
    from rows r
    inner join benchmarks b
        on r.file_name = b.epoch_file

),

named as (

    select
        s.*,
        case
            -- the capabilities index is already keyed by Epoch's model name
            when s.unit = 'index' then s.eci_model_name
            else coalesce(
                v_version.model_name,                                        -- 1. Epoch's map, by API version
                v_display.model_name,                                        -- 2. Epoch's map, by display name
                nullif(s.clean_display_name, ''),                            -- 3. the file's display name
                nullif(trim(replace(                                         -- 4. readable version string
                    regexp_replace(s.model_version, r'{{ effort_suffix }}', ''), '-', ' ')), '')
            )
        end                                                                  as model_name
    from scored s
    left join version_names v_version
        on regexp_replace(lower(s.model_version), r'{{ effort_suffix }}', '') = v_version.version_base
    left join version_names v_display
        on regexp_replace(lower(replace(s.clean_display_name, ' ', '-')), r'{{ effort_suffix }}', '')
           = v_display.version_base
    where s.score is not null

),

keyed as (

    select
        *,
        {{ model_match_key('model_name') }}                                  as model_key
    from named
    where model_name is not null

),

best_run as (

    select
        *,
        -- spellings differ between rows ("gpt-6 astra" / "GPT-6 Astra"): prefer one with capitals
        first_value(model_name) over (
            partition by benchmark_id, model_key
            order by case when model_name = lower(model_name) then 1 else 0 end, row_number
        )                                                                    as preferred_name
    from keyed
    qualify row_number() over (
        partition by benchmark_id, model_key
        order by score desc, row_number
    ) = 1

),

final as (

    select
        benchmark_id || '|' || model_key                                     as benchmark_model_key,
        benchmark_id,
        model_key,
        preferred_name                                                       as model_name,
        score,
        case when unit = 'index' then null else harness end                  as harness,
        case when unit = 'index' then null else effort end                   as effort,
        release_date,
        organization
    from best_run

)

select * from final
