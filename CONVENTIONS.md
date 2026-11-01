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

---

## 2. Staging rules

Staging models do **only** these things:
- rename columns to `snake_case`
- cast data types
- drop columns that will never be used (e.g. long free-text)
- light tidying (trimming whitespace, standardising nulls)

Staging models **never**:
- join to other models
- filter rows based on business meaning
- choose between conflicting columns

> **Why:** staging is a clean mirror of the source. Business decisions hidden in staging are invisible to anyone reading the marts.

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
| Mart | `fct_<event>` / `dim_<thing>` | `dim_models`, `fct_daily_prices` |
| Source YAML | `_<source>__sources.yml` | `_epoch__sources.yml` |
| Model YAML | `_<source>__models.yml` | `_epoch__models.yml` |
| Columns | `snake_case`, units in the name | `training_compute_flop`, `training_time_hours` |
| Booleans | `is_` / `has_` prefix | `is_frontier_model` |

> **Why:** a name should say which layer a model is in and where its data comes from, without opening the file.

✅ `stg_epoch__notable_models.sql`
❌ `epoch_clean.sql`

✅ `training_power_draw_watts`
❌ `power`

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
| OpenRouter (planned) | Public API | Model pricing; to be loaded daily and tracked with dbt snapshots |

### Loading notes
- **Epoch CSV:** upload with *Rows span multiple lines* ticked and *Escape character* set to `"`. Without these, multi-paragraph text fields break into extra rows (first load produced 6,407 rows instead of 1,091).
- **Missing values:** many recent closed models have no published parameter count. These nulls are genuine gaps in the source, not load errors.