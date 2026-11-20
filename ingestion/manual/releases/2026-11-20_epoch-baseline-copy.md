# Epoch baseline copied into the seeds, 20 Nov 2026

**Why:** the project no longer reads anything from Epoch AI. The Epoch data still in use was
copied into our own seeds once, and the Epoch loader, source and staging models were removed. From
here on every row is maintained in this repo, and new results come only from release pages.

**Copied from:** the production marts as they stood on 20 Nov 2026 (`ai_model_tracker.analytics`),
not Epoch's raw files, so the copy is exactly the data the site showed. Licence: CC BY 4.0, credit
kept on the site and in the README.

## What was copied

| Into | Rows | What |
|---|---|---|
| `manual_benchmark_scores.csv` | 1,677 | Every Epoch result the site showed (26 benchmarks, 403 models). `source_type` = `independent`, `source_url` = https://epoch.ai/benchmarks, note "Epoch AI baseline (CC BY 4.0), copied 20 Nov 2026." Percentages written as published (0.491 → 49.1), to 4 decimals. Results a release page had already superseded were not copied. |
| `manual_benchmarks.csv` | 26 | The definitions from `seeds/benchmark_catalog.csv` (deleted), keeping their sort order 1–27. |
| `manual_models.csv` | 142 | The Epoch models the project uses: priced on OpenRouter, named in `model_match_overrides`, or with a benchmark result. The other 949 (mostly pre-2023 research models) were left behind. Columns parameters, training compute, tasks and frontier flag were dropped: nothing used them, and release pages rarely publish them. |

**Not copied:** Epoch's Capabilities Index (256 rows). It is Epoch's own combined score; the Overall
tab is now our own fit (`fct_benchmark_category_scores`, category `overall`).

Parity check after the build: all 3,274 results identical to production (score, lab, release date,
open weights, harness, effort, price, category); price marts identical (110 priced models, 8,831
daily rows).

## Gaps filled

Every result now needs a lab and a release date (not-null tests on the seed). Epoch had left 22
models without one or both. Filled, in order of preference:

1. **From Epoch's own model list** (same normalised name): lab for 2 models, date for 2, open weights for 25 rows.
2. **From our existing seed rows** for the same model: Gemini 3 Deep Think (2/26) → Google, 12 Feb 2026.
3. **By hand**, labs from the model name (chutes/… and deepinfra/… are provider runs of Z.ai and
   Alibaba models; granite → IBM; TRM → Samsung; OpenHands LM → All Hands AI; Seed-OSS → ByteDance), and dates:

| Model | Date | Source |
|---|---|---|
| SWE-1.7 | 2026-07-08 | Cognition launch, 8 Jul 2026 (press coverage) |
| glm 4.7 flash | 2026-01-19 | Z.ai announcement, 19 Jan 2026 |
| xiaomi/mimo-v2.5 | 2026-04-22 | MiMo-V2.5 launch |
| xiaomi/mimo-v2.5-pro | 2026-04-23 | Epoch's own model list (MiMo-V2.5-Pro) |
| davinci 002 | 2020-05-28 | METR runs davinci-002 as its GPT-3 data point (May 2020) |
| o3-preview* | 2024-12-20 | Announced with o3 |

Three copied models had no source link (`GPT-5.1-Codex`, `GPT-5.2`, `GPT-6 Astra`); filled from our
release notes.

**Publisher corrected** where the catalog credited Epoch, which only ran the benchmark: GPQA Diamond
→ Rein et al. (NYU), SWE-bench Verified → OpenAI, SimpleQA Verified → Google, OTIS Mock AIME → OTIS
(Evan Chen). FrontierMath, MirrorCode and Chess Puzzles are Epoch's own benchmarks and keep "Epoch AI".

## Benchmark release dates (new column `released_date`)

Every benchmark now has a release date, which sets its weight in the Overall. Results can't date a
benchmark: Epoch evaluates old models on new benchmarks (GPQA's earliest result is GPT-4, 8 months
before GPQA existed) and release pages also report older models. So:

- **97 benchmarks: the publication date**, for well-known benchmarks, e.g. ARC-AGI 2019-11-05,
  GPQA Diamond 2023-11-20, SWE-bench Verified 2024-08-13, FrontierMath (v1) 2024-11-07, Aider
  Polyglot 2024-12-21, Humanity's Last Exam 2025-01-23, ARC-AGI-2 2025-03-24, METR tasks 2025-03-19,
  GraphWalks and OpenAI MRCR 2025-04-14 (released with GPT-4.1), GDPval 2025-09-25, Terminal-Bench
  2.0 2025-11-07. FrontierMath 1–3 and Tier 4 in the site's catalog are Epoch's v2 sets, dated by
  their first run (2026-06-09); OTIS Mock AIME by Epoch's first run (2025-02-25). Competitions use
  the contest date (AIME 2025: 2025-02-06).
- **210 benchmarks: the earliest evidence in our data.** For a release page, the page's date (the
  release date of the newest model on it); for a leaderboard or Epoch row, the model's release date.
  Most of these are benchmarks introduced on the release pages themselves, where the first page
  that reports them is a good estimate.

Correct any of these by editing `released_date` in a PR: the weights follow at the next build.
