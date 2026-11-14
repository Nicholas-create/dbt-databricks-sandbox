-- Epoch's benchmark results, one row per benchmark per model: the model's best
-- run, with model names resolved to Epoch's own naming.
{% set effort_suffix = "(?i)_(max|xhigh|high|medium|low|minimal|none"
    ~ "|unknown|thinking|[0-9]+k)$" %}
{% set effort_words = "(?i)\\s*(\\((x?high|medium|low|max|minimal|none"
    ~ "|thinking)\\)|\\s+(x?high|medium|low|max|minimal)$)" %}

with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}
    where epoch_file is not null

),

benchmark_rows as (

    select * from {{ ref('stg_epoch__benchmark_rows') }}

),

eci_model_versions as (

    select
        model_version,
        model_name,
        row_number
    from {{ ref('stg_epoch__eci_model_versions') }}
    where
        model_version is not null
        and model_name is not null

),

-- each API model version without its effort suffix (_high, _32k...)
version_bases as (

    select
        regexp_replace(
            lower(model_version), r'{{ effort_suffix }}', ''
        ) as version_base,
        model_name,
        row_number
    from eci_model_versions

),

-- Epoch's pairing of API model versions with model names. A version can appear
-- on many rows; the first row's name wins, so the result never changes between
-- runs.
version_names as (

    select
        version_base,
        model_name
    from version_bases
    qualify row_number() over (
        partition by version_base
        order by row_number
    ) = 1

),

scored as (

    select
        benchmarks.benchmark_id,
        benchmarks.unit,
        benchmark_rows.row_number,
        benchmark_rows.model_version,
        benchmark_rows.fields['Model'] as eci_model_name,
        -- display name without "(high)"-style effort labels
        trim(
            regexp_replace(
                benchmark_rows.display_name, r'{{ effort_words }}', ''
            )
        ) as clean_display_name,
        try_cast(
            benchmark_rows.fields[benchmarks.score_column] as double
        ) * benchmarks.score_scale as score,
        benchmark_rows.harness,
        benchmark_rows.effort,
        benchmark_rows.release_date,
        coalesce(
            benchmark_rows.organization, benchmark_rows.model_org
        ) as organization
    from benchmark_rows
    inner join benchmarks
        on benchmark_rows.file_name = benchmarks.epoch_file

),

-- version_names is joined twice, once per way of finding a model's name, so
-- each join gets a descriptive alias
named as (

    select
        scored.*,
        case
            -- the capabilities index is already keyed by Epoch's model name
            when scored.unit = 'index' then scored.eci_model_name
            else coalesce(
                -- 1. Epoch's map, by API version
                names_by_version.model_name,
                -- 2. Epoch's map, by display name
                names_by_display.model_name,
                -- 3. the file's display name
                nullif(scored.clean_display_name, ''),
                -- 4. readable version string
                nullif(
                    trim(
                        replace(
                            regexp_replace(
                                scored.model_version, r'{{ effort_suffix }}', ''
                            ),
                            '-',
                            ' '
                        )
                    ),
                    ''
                )
            )
        end as model_name
    from scored
    left join version_names as names_by_version
        on
            regexp_replace(
                lower(scored.model_version), r'{{ effort_suffix }}', ''
            )
            = names_by_version.version_base
    left join version_names as names_by_display
        on
            regexp_replace(
                lower(replace(scored.clean_display_name, ' ', '-')),
                r'{{ effort_suffix }}',
                ''
            )
            = names_by_display.version_base
    where scored.score is not null

),

keyed as (

    select
        *,
        {{ model_match_key('model_name') }} as model_key
    from named
    where model_name is not null

),

best_run as (

    select
        *,
        -- spellings differ between rows ("gpt-6 astra" / "GPT-6 Astra"): prefer
        -- one with capitals
        first_value(model_name) over (
            partition by benchmark_id, model_key
            order by
                case when model_name = lower(model_name) then 1 else 0 end,
                row_number
        ) as preferred_name
    from keyed
    qualify row_number() over (
        partition by benchmark_id, model_key
        order by score desc, row_number asc
    ) = 1

),

final as (

    select
        benchmark_id || '|' || model_key as benchmark_model_key,
        benchmark_id,
        model_key,
        preferred_name as model_name,
        score,
        case when unit = 'index' then null else harness end as harness,
        case when unit = 'index' then null else effort end as effort,
        release_date,
        organization
    from best_run

)

select * from final
