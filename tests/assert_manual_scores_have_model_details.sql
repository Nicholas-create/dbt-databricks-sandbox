-- Models entered from a release page are usually newer than the Epoch baseline,
-- so there is nothing to fall back on: the manual row itself must give the lab
-- and release date (the leaderboard colours by lab; the race plots by date).
-- Fails listing every manual score still missing either one.
select
    benchmark_model_key,
    model_name,
    lab,
    released_date
from {{ ref('fct_benchmark_scores') }}
where score_source = 'manual'
  and (lab is null or lab = '' or released_date is null)
