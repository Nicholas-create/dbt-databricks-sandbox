# Project Conventions

How this project is built and why. Every model, file and change should follow these rules so the pipeline stays predictable and easy to review.

**Stack:** Databricks (storage + compute) · dbt (transformations) · GitHub (version control)

---

## 1. Data layers

Data flows in one direction only:

```
raw  →  staging  →  intermediate  →  marts
```

| Layer | Where it lives | Built as | Purpose |
|---|---|---|---|
| **Raw** | `workspace.raw_<source>` | Delta table (loaded outside dbt) | Source data exactly as published |
| **Staging** | `models/staging/<source>/` | View | Rename, retype, light tidying. One model per source table |
| **Intermediate** | `models/intermediate/` | View or table | Joins, reshaping, business logic shared by several marts |
| **Marts** | `models/marts/` | Table | Final, dashboard-ready tables |

### Raw data is never edited
Raw tables are a faithful copy of the source. If a load is wrong, fix it **at load time** and reload. Never patch raw data by hand, and never make dbt repair problems that the loader caused.

> **Why:** if raw data is untouched, any downstream mistake can be fixed by rebuilding. Once raw data is edited, the original is lost.

✅ CSV parsed incorrectly → change the upload settings and overwrite the raw table
❌ CSV parsed incorrectly → write dbt logic to filter out the broken rows

### API data lands as untouched JSON
When loading from an API, store each record's **full JSON as text** alongside a `loaded_at` timestamp. Parse it into columns in dbt staging, not in the loader.

> **Why:** APIs add and rename fields. A loader that picks out specific fields breaks when the API changes; a loader that stores the whole record never does, and nothing the source sent is lost.

✅ `Row(model_id=m["id"], raw_json=json.dumps(m), loaded_at=loaded_at)`
❌ `Row(model_id=m["id"], price=m["pricing"]["prompt"])`, which fails the day `pricing` changes shape and discards every other field

### Snapshot loads append, never overwrite
Scheduled loads that capture changing data (e.g. daily prices) use `.mode("append")`.

> **Why:** history only exists if old snapshots are kept. Overwriting makes it impossible to chart change over time.

✅ `.mode("append")`
❌ `.mode("overwrite")`

---

## 2. Staging rules

Staging models do **only** these things:
- rename columns to `snake_case`
- cast data types
- drop columns that will never be used (e.g. long free-text)
- light tidying (trimming whitespace, standardising nulls)
- parse raw JSON into typed columns
- remove duplicates caused by ingestion (e.g. a manual re-run producing two snapshots for the same day, keeping the latest)

Staging models **never**:
- join to other models
- filter rows based on business meaning
- choose between conflicting columns

> **Why:** staging is a clean mirror of the source. Business decisions hidden in staging are invisible to anyone reading the marts.

### Placeholder codes become null, with a flag
Some sources use a magic number to mean "no real value" (OpenRouter reports a price of `-1` for routers, whose price depends on the model routed to). Staging turns the placeholder into `null` and adds an `is_` flag that records what the placeholder meant.

> **Why:** a placeholder left in place is read as a real number: `-1` drags down an average price, and summing it is meaningless. Turning it into null alone loses information, because null usually means "unknown", while `-1` meant something specific. The flag keeps that meaning. Never turn a placeholder into `0`: `0` is a real price (free).

✅
```sql
case when price >= 0 then price end   as output_price_usd_per_mtok,
coalesce(price < 0, false)            as is_variable_priced
```
❌ `price as output_price_usd_per_mtok`: `-1` reaches the dashboard as a real price
❌ `greatest(price, 0)`: a router now looks free

A singular test on the mart (`tests/assert_model_prices_not_negative.sql`) fails the build if a new negative code ever appears.

✅ Good staging:
```sql
select
    `Model`             as model_name,
    `Publication date`  as published_date
from {{ source('epoch', 'notable_ai_models') }}
```

❌ Bad staging (business logic buried in the wrong layer):
```sql
select
    `Model` as model_name
from {{ source('epoch', 'notable_ai_models') }}
where `Domain` = 'Language'          -- filtering belongs downstream
```

---

## 3. Naming

| Thing | Pattern | Example |
|---|---|---|
| Raw schema | `raw_<source>` | `raw_epoch` |
| Staging model | `stg_<source>__<entity>` | `stg_epoch__notable_models` |
| Intermediate model | `int_<entity>__<verb>` | `int_models__joined_pricing` |
| Mart | `fct_<event>` / `dim_<thing>` | `dim_models`, `fct_model_prices_daily` |
| Source YAML | `_<source>__sources.yml` | `_epoch__sources.yml` |
| Model YAML | `_<source>__models.yml` | `_epoch__models.yml` |
| Columns | `snake_case`, units in the name | `training_compute_flop`, `training_time_hours` |
| Booleans | `is_` / `has_` prefix | `is_frontier_model` |

> **Why:** a name should say which layer a model is in and where its data comes from, without opening the file.

✅ `stg_epoch__notable_models.sql`
❌ `epoch_clean.sql`

✅ `training_power_draw_watts`
❌ `power`

### Units and money
- Every measured value carries its **unit in the column name**, including currency and scale.
- Prices are standardised to **USD per million tokens** (`_usd_per_mtok`), the industry convention, regardless of how the source publishes them.
- Money is stored as `decimal`, never `double`.
- Keep full precision in staging and round only in marts, where values are meant to be read.

> **Why:** a price column without a unit is a millionfold mistake waiting to happen in a dashboard. `double` stores fractions inexactly (0.1 + 0.2 ≠ 0.3), and the error grows when prices are multiplied up.

✅ `cast(raw_json:pricing.prompt as decimal(20, 12)) * 1000000 as input_price_usd_per_mtok`
❌ `cast(raw_json:pricing.prompt as double) as input_price`

---

## 4. Referencing other data

- Reference raw tables with `{{ source('<source>', '<table>') }}`
- Reference other dbt models with `{{ ref('<model_name>') }}`
- Never hard-code a table path

> **Why:** `source()` and `ref()` let dbt work out build order and draw lineage. A hard-coded path breaks both and ties the code to one environment.

✅ `from {{ ref('stg_epoch__notable_models') }}`
❌ `from workspace.dbt_nicholas.stg_epoch__notable_models`

---

## 5. Testing

- Every model's primary key has `unique` and `not_null` tests.
- Check the grain (what one row represents) by hand **before** writing a model, then encode it as a test.
- Use `data_tests:` in YAML (current dbt syntax).

> **Why:** if the key isn't unique, every later join and count is quietly wrong. Tests turn a one-off check into a guarantee on every build.

```yaml
columns:
  - name: model_name
    data_tests:
      - unique
      - not_null
```

- When the grain is more than one column (e.g. one row per model **per day**), build a combined key column and test that instead.

```sql
model_id || '|' || cast(snapshot_date as string) as model_snapshot_key
```

- Use `accepted_values` on category columns that drive logic, so a new category from the source fails the build instead of being silently mis-classified.
- After a build passes, **spot-check one known value by hand** (e.g. a price you can read in the raw JSON). Tests prove shape; a spot check proves meaning.

### Source freshness
Every source loaded on a schedule declares freshness, inside `config:`:

```yaml
tables:
  - name: models_daily
    config:
      loaded_at_field: loaded_at
      freshness:
        warn_after: {count: 26, period: hour}
        error_after: {count: 50, period: hour}
```

Check it with `dbt source freshness --select source:<source>`.

> **Why:** a broken schedule fails silently. Freshness checks turn "no new data" into a visible warning before gaps appear in the history.

✅ `freshness` and `loaded_at_field` nested under `config:`
❌ `freshness` as a top-level property of the table (deprecated in current dbt)

---

## 6. Version control

- `main` holds only finished, working code and is never edited directly.
- All work happens on a branch: `feature/<short-description>` or `setup/<short-description>`.
- Changes reach `main` through a pull request.
- `dbt build` must pass before a pull request is merged.
- Commit messages say *what* changed in the imperative mood.

✅ `Add Epoch source and staging model with grain tests`
❌ `updates`

---

## 7. YAML formatting

- Indent with **2 spaces**. Never use tabs.
- Top-level keys (`models:`, `sources:`, `clean-targets:`) start at the left margin.
- If a YAML file won't parse, check indentation first.

✅
```yaml
clean-targets:
  - "target"

models:
  ai_model_tracker:
```

❌ (`models:` indented, so it's read as part of the list above)
```yaml
clean-targets:
  - "target"

  models:
    ai_model_tracker:
```

---

## 8. Data sources and licensing

| Source | Licence | Notes |
|---|---|---|
| Epoch AI (Notable AI Models) | CC-BY 4.0 | Credit Epoch AI wherever the data is shown |
| OpenRouter | Public API (`/api/v1/models`, no key needed) | Model catalogue and pricing; loaded daily at 06:00 Europe/London by the Databricks notebook `ingest_openrouter_models` into `raw_openrouter.models_daily` |

### Loading notes
- **Epoch CSV:** upload with *Rows span multiple lines* ticked and *Escape character* set to `"`. Without these, multi-paragraph text fields break into extra rows (first load produced 6,407 rows instead of 1,091).
- **Missing values:** many recent closed models have no published parameter count. These nulls are genuine gaps in the source, not load errors.
- **OpenRouter benchmarks:** the API response includes a `benchmarks.artificial_analysis` block. It is deliberately not parsed or published, because Artificial Analysis's free terms don't allow redistribution.