-- The seed manual_models fills the gap until Epoch lists a new release. Once
-- Epoch's file has the model too (after a refresh), the hand-entered line is
-- usually redundant: it still wins on the columns it fills, which can hide a
-- correction Epoch made. Warns, listing each such model, so the line can be
-- reviewed and deleted. Matches on the normalised name, so a different
-- spelling in Epoch ("GPT 6.2 Astra") is caught too.
{{ config(severity='warn') }}

with manual_models as (

    select * from {{ ref('stg_manual__models') }}

),

epoch_models as (

    select * from {{ ref('stg_epoch__notable_models') }}

),

final as (

    select
        manual_models.model_name as manual_model_name,
        epoch_models.model_name as epoch_model_name,
        manual_models.published_date as manual_published_date,
        epoch_models.published_date as epoch_published_date
    from manual_models
    inner join epoch_models
        on
            {{ model_match_key('manual_models.model_name') }}
            = {{ model_match_key('epoch_models.model_name') }}

)

select * from final
