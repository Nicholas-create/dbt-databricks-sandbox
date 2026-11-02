-- returns any row with a negative price; the test passes when nothing comes back
select
    model_snapshot_key,
    input_price_usd_per_mtok,
    output_price_usd_per_mtok,
    cached_input_price_usd_per_mtok
from {{ ref('fct_model_prices_daily') }}
where input_price_usd_per_mtok < 0
   or output_price_usd_per_mtok < 0
   or cached_input_price_usd_per_mtok < 0
