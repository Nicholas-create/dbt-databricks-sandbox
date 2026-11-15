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
| **Raw** | `ai_model_tracker.raw_<source>` | Delta table (loaded outside dbt) | Source data exactly as published |
| **Seeds** | `seeds/` (CSV in the repo) | Table, loaded by `dbt build` into each environment | Small data authored in the repo: lookups, the benchmark catalog, hand-entered results |
| **Staging** | `models/staging/<source>/` | View | Rename, retype, light tidying. One model per source table |
| **Intermediate** | `models/intermediate/` | View or table | Joins, reshaping, business logic shared by several marts |
| **Marts** | `models/marts/` | Table | Final, dashboard-ready tables |

### The project owns one catalog
Everything this project reads or writes lives in the Unity Catalog catalog **`ai_model_tracker`**: the raw schemas, and every schema dbt builds (dev, ci, prod; see §6). Other projects in the same Databricks workspace (sql-gym, sakila) use their own catalogs. Sources name the catalog explicitly with `database:`.

> **Why:** the catalog is the top of the three-part name `catalog.schema.table`. When one project owns it, a table's name says which project it belongs to, and access and cleanup can be done for the whole project in one place. Raw data lives in one place whatever the environment, so the sources name its catalog instead of inheriting the one the dbt target happens to use.

✅ `database: ai_model_tracker` on every source, `catalog: ai_model_tracker` in every dbt profile
❌ Leaving `database:` off a source: it then follows the target's catalog, so a target pointed at another catalog quietly reads the wrong raw tables (or none)
❌ A new raw schema in the shared `workspace` catalog

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

### Hand-entered data lives in Git, as seeds
Some data has no feed and is typed in by hand: benchmark results from model release pages. It lives in the repo as dbt seeds (`seeds/manual/*.csv`, runbook in `ingestion/manual/README.md`), not in a warehouse table. A **source** is data that arrives from outside (an API, a file someone publishes); a **seed** is small data authored in the repo itself.

- **Each CSV holds the current state.** A correction is an edited line; a withdrawal is a deleted line. Git history is the audit trail: every earlier value, when it changed, who changed it and in which PR.
- **Every row says where it came from** (`source_url`, `source_type`), and each release gets a short note in `ingestion/manual/releases/`: what was entered from which page, and what was skipped and why.
- **Bad values fail the build:** every column has an explicit type in the seed YAML, and tests reject an unknown unit or source type, a negative score, a duplicate key or an unknown category.

> **Why:** a hand-filled warehouse table is shared by every environment, so a value is live before anyone reviews it, and reverting the PR doesn't revert the data. With a seed, the PR diff *is* the review, CI tests the PR's own copy of the data, each environment loads its own copy, and nothing reaches production before the merge. Keeping only the current state works because Git already keeps the history.

✅ Typo in a score → edit that line of `manual_benchmark_scores.csv` in a PR
❌ Typo in a score → `INSERT` or `UPDATE` a warehouse table by hand

✅ Score withdrawn → delete its line in a PR (Epoch's score, if any, shows again)
❌ Score withdrawn → keep the line and add an `is_retracted` flag

✅ Seed column with an explicit type: `variant_label: string` in `column_types`
❌ Leaving dbt to guess types from the values: `variant_label` "2.0" is read as the number 2

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
case when price >= 0 then price end as output_price_usd_per_mtok,
coalesce(price < 0, false) as is_variable_priced
```
❌ `price as output_price_usd_per_mtok`: `-1` reaches the dashboard as a real price
❌ `greatest(price, 0)`: a router now looks free

A singular test on the mart (`tests/assert_model_prices_not_negative.sql`) fails the build if a new negative code ever appears.

✅ Good staging:
```sql
select
    `Model` as model_name,
    `Publication date` as published_date
from {{ source('epoch', 'notable_ai_models') }}
```

❌ Bad staging (business logic buried in the wrong layer):
```sql
select
    `Model` as model_name
from {{ source('epoch', 'notable_ai_models') }}
where `Domain` = 'Language'  -- filtering belongs downstream
```

---

## 3. Naming

| Thing | Pattern | Example |
|---|---|---|
| Raw schema | `raw_<source>` | `raw_epoch` |
| Staging model | `stg_<source>__<entity>` | `stg_epoch__notable_models` |
| Intermediate model | `int_<entity>__<verb>` | `int_models__joined_pricing` |
| Mart | `fct_<event>` / `dim_<thing>` | `dim_models`, `fct_model_prices_daily` |
| Hand-entered seed | `manual_<entity>` in `seeds/manual/` | `manual_benchmark_scores` |
| Source YAML | `_<source>__sources.yml` | `_epoch__sources.yml` |
| Model YAML | `_<source>__models.yml` | `_epoch__models.yml` |
| Seed YAML | `_<folder>__seeds.yml` (`_seeds.yml` at the top) | `_manual__seeds.yml` |
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
❌ `from ai_model_tracker.dbt_nicholas.stg_epoch__notable_models`

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
- `dbt build` must pass before a pull request is merged. GitHub Actions (`.github/workflows/dbt-ci.yml`) runs it on every PR into `main`, building into its own `dbt_ci` schema. Never merge on a red or pending check.

> **Why:** "it worked on my machine" isn't proof. CI builds the branch from a clean install with pinned versions, the same way every time, and the result sits on the PR for anyone reviewing it.

✅ PR shows **dbt CI / dbt build ✓**, then merge
❌ Merge because the local build passed while the CI check is still failing
- Commit messages say *what* changed in the imperative mood.

### Environments
| Environment | Schema | Built by | Who reads it |
|---|---|---|---|
| dev | `dbt_<name>` (e.g. `dbt_nsampson`) | You, locally or in dbt Studio, from any branch | Only you, while developing |
| ci | `dbt_ci` | GitHub Actions on every pull request (`dbt-ci.yml`) | The PR check |
| prod | `analytics` | GitHub Actions from `main` only (`dbt-prod.yml`): on every merge that can change the build or the site, and daily at 07:17 UTC | The website (via `scripts/export_site_data.py`), dashboards and anyone using the data |

> **Why:** dashboards and the website must never read a dev schema. Dev tables change whenever someone runs a half-finished branch; prod only changes when reviewed code reaches `main`.

The website is published only after a successful production build (`site.yml` runs on `workflow_run`), never straight from a push, so it always reads marts built from the same `main`.

✅ Merge the PR → **dbt production build** runs on the push to `main` → **Publish site** runs when it succeeds
❌ Publish the site on every push to `main`: a page that needs a new mart column goes live before prod has that column, and fails

✅ Dashboard dataset: `from rpt_models_latest_price`, with the dataset schema set to `analytics`
❌ Dashboard dataset reading `dbt_nsampson.rpt_models_latest_price`

✅ `Add Epoch source and staging model with grain tests`
❌ `updates`

---

## 7. SQL style

All SQL follows [dbt Labs' SQL style guide](https://docs.getdbt.com/best-practices/how-we-style/2-how-we-style-our-sql): models, tests and macros, and also the queries in `scripts/export_site_data.py` and the dashboard JSON. SQLFluff checks models, tests and macros on every pull request (the **sql lint** check; rules in `.sqlfluff`).

> **Why:** when every file is laid out the same way, a diff shows only what changed in meaning, and anyone can read any model without learning its author's habits first. Because a machine checks the layout, review time goes on the logic.

### Basics
- Lowercase keywords, function names and field names. Indent 4 spaces. Trailing commas. Lines of 80 characters or fewer.
- Every alias uses an explicit `as`, with **one space** before it. Don't pad `as` out to line up in a column. If an expression doesn't fit in 80 characters, break it over lines inside its brackets.

> **Why:** with padding, one longer line means re-aligning (and re-diffing) every line around it, and the padding pushes lines past 80 characters.

✅
```sql
nullif(trim(publisher), '') as publisher,
nullif(trim(benchmark_family), '') as benchmark_family,
round(
    prices.cached_input_price_usd_per_mtok, 4
) as cached_input_price_usd_per_mtok
```
❌
```sql
nullif(trim(publisher), '')                    as publisher,
nullif(trim(benchmark_family), '')             as benchmark_family,
round(prices.cached_input_price_usd_per_mtok, 4) cached_input_price_usd_per_mtok
```

### Joins
- When a query joins two or more CTEs, prefix **every** column with its CTE's full name. Don't give tables aliases, least of all initials. (A single-table select needs no prefix.)
- Exception: when one CTE is joined twice, give each copy a descriptive alias with `as` (`version_names as names_by_version`).
- Always name the join type: `inner join`, `left join`, `full outer join`, never a bare `join`. Join left to right, never `right join`.
- Use `union all` unless duplicates really have to be removed.

> **Why:** `scores.benchmark_id` says where a column comes from wherever you are in the file; `s.benchmark_id` makes you scroll back to find out what `s` was.

✅
```sql
select
    scores.benchmark_id,
    benchmarks.category,
    scores.score
from scores
left join benchmarks
    on scores.benchmark_id = benchmarks.benchmark_id
```
❌ (initials, a bare `join`, and `score` without a prefix)
```sql
select s.benchmark_id, b.category, score
from scores s
join benchmarks b on s.benchmark_id = b.benchmark_id
```

### Import CTEs, then one step per CTE
- Every `{{ ref() }}` and `{{ source() }}` gets its own CTE at the top of the file, named after what it references. Pick only the columns and rows you need there, if that helps.
- After the imports, each CTE does one logical step and has a name that says what it does. The model ends with `select * from final` (or whatever the last CTE is called).
- A singular test that is one plain `select` from one model may keep its `ref()` inline. A test with CTEs or joins uses import CTEs.

> **Why:** the top of the file lists everything the model depends on, so you can see its inputs without reading its logic.

✅
```sql
with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}

),

benchmark_rows as (

    select * from {{ ref('stg_epoch__benchmark_rows') }}

),

harnesses_seen as (

    select
        benchmarks.benchmark_id,
        benchmark_rows.harness
    from benchmark_rows
    inner join benchmarks
        on benchmark_rows.file_name = benchmarks.epoch_file

)
```
❌ (a `ref()` buried in the logic)
```sql
with benchmarks as (

    select * from {{ ref('int_benchmarks__unioned') }}

),

harnesses_seen as (

    select b.benchmark_id, r.harness
    from {{ ref('stg_epoch__benchmark_rows') }} r
    inner join benchmarks b
        on r.file_name = b.epoch_file

)
```

### Fields, aggregates and grouping
- Plain fields first, then aggregates and window functions.
- Aggregate as early as possible, before joining.
- `group by` and `order by` use column numbers, not names. Exception: a query sorted by a column it doesn't select has to use the name.

> **Why:** the select list already says what each column is. A number avoids repeating a long expression in the `group by`, and stays correct when a column is renamed.

✅
```sql
select
    benchmark_id,
    array_sort(collect_set(harness)) as harnesses
from harnesses_seen
group by 1
```
❌ `group by benchmark_id`

### Layout
Lay files out as in the examples above:
- a blank line after `with x as (` and before its closing `)`. Each `),` that separates CTEs sits on its own line, followed by a blank line
- `select` on its own line, then one column per line when there's more than one
- `where` / `and` / `or` conditions on their own lines, indented 4 spaces under `where`; `case` branches indented under `case`
- every file ends with one newline

Keep the `--` comments that explain logic, re-wrapped to fit. Use Jinja comments `{# ... #}` for notes that shouldn't appear in the compiled SQL.

### Checking it
- **On a pull request:** the **sql lint** check runs `sqlfluff lint models tests macros`. It must be green, like **dbt build**. It needs no warehouse and no secrets.
- **Locally:** install once with `uv pip install -r requirements-lint.txt --python .venv/bin/python`. Then `.venv/bin/sqlfluff lint models tests macros` lists every problem, and `.venv/bin/sqlfluff fix <file>` rewrites the layout of one file. Read what `fix` changed: it can't remove aliases, add import CTEs or reorder columns.
- **dbt Studio:** the **Lint** and **Format** buttons in the editor use SQLFluff with the rules in this repo's `.sqlfluff`, instead of their default sqlfmt. Restart the Studio IDE after `.sqlfluff` changes.
- **Exceptions:** if a rule can't be met without changing a model's output (for example, `tasks` and `fields` are keywords to SQLFluff, but they are existing column names), put `-- noqa: <rule>` on that one line, with a comment above saying why. Never exclude a whole file. One SQLFluff rule is switched off project-wide, with the reason in `.sqlfluff`: ST06 (`structure.column_order`), which is stricter than the guide's field-order rule above.

---

## 8. YAML formatting

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

## 9. Data sources and licensing

| Source | Licence | Notes |
|---|---|---|
| Epoch AI (Notable AI Models) | CC-BY 4.0 | Credit Epoch AI wherever the data is shown |
| Epoch AI (Capabilities & benchmarking) | CC-BY 4.0 | Benchmark **baseline**: loaded once on 14 Nov 2026 from `epoch.ai/data/benchmark_data.zip` into `raw_epoch.benchmark_rows` (notebook `ingestion/ingest_epoch_benchmarks.py`, not scheduled). Credit Epoch AI on the site |
| Model release pages (manual) | Published results, cited with their URL | Every benchmark result since the baseline, entered from the developer's announcement into the seeds `seeds/manual/manual_benchmarks.csv` and `manual_benchmark_scores.csv` (one release note per release in `ingestion/manual/releases/`). Only a developer's results for its own models; marked as developer-reported on the site. The earlier warehouse tables `workspace.raw_manual.*` are retired and left untouched |
| OpenRouter | Public API (`/api/v1/models`, no key needed) | Model catalogue and pricing; loaded daily at 06:00 Europe/London by the Databricks notebook `ingest_openrouter_models` (copy in `ingestion/`) into `raw_openrouter.models_daily` |

### Loading notes
- **Epoch CSV:** upload with *Rows span multiple lines* ticked and *Escape character* set to `"`. Without these, multi-paragraph text fields break into extra rows (first load produced 6,407 rows instead of 1,091).
- **Missing values:** many recent closed models have no published parameter count. These nulls are genuine gaps in the source, not load errors.
- **OpenRouter benchmarks:** the API response includes a `benchmarks.artificial_analysis` block. It is deliberately not parsed or published, because Artificial Analysis's free terms don't allow redistribution.