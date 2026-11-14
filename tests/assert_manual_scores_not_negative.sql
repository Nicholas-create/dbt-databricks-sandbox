-- No benchmark reports a negative score, so a minus sign in the seed is a typo.
-- Checked on the seed itself, so the failure points at the line to fix.
-- Returns every negative score; the test passes when nothing comes back.
select
    benchmark_id,
    model_name,
    score
from {{ ref('manual_benchmark_scores') }}
where score < 0
