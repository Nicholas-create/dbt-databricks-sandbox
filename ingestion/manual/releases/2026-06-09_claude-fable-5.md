# Claude Fable 5 and Claude Mythos 5, announced 9 Jun 2026

**Source:** https://www.anthropic.com/news/claude-fable-5-mythos-5 (benchmark table is an image; read 14 Nov 2026)

**Entered:** 14 Nov 2026, as part of the Claude 5-family backfill (one batch per page,
run in page order; each score comes from the newest page that reports it).

**Entered:** Anthropic's own models. The highlighted column is "Mythos 5 / Fable 5"
combined: per the page's methodology note it shows the HIGHER of the two models.

- Starred (*) cells differ because Fable 5's safeguards fall back to Opus 4.8, so
  the starred value is Claude Mythos 5's: entered as Claude Mythos 5.
- Unstarred cells could be either model (within 1-3 points): not entered. Fable 5's
  own scores come from the Opus 5 page, which gives it a column of its own.
- Claude Mythos Preview and Claude Opus 4.8 columns are clean: entered.

**Not entered, and why:**

- GPT 5.5 and Gemini 3.1 Pro columns: competitors' models.
- GDPval-AA: Artificial Analysis data (CONVENTIONS.md section 8).
- Superseded by a later page (newer value entered there): AutomationBench Opus 4.8
  15.5 (Opus 5 page: 17.0); BioMysteryBench hard Opus 4.8 40.0 (42.4); human solved
  Opus 4.8 80.4 (88.5) and Mythos 5 83.9 (89.0); HealthBench Professional Opus 4.8
  56.9 (57.4). HLE, OSWorld-Verified, Terminal-Bench 2.1, SWE-bench Pro and Legal
  values for Opus 4.8 repeat on later pages and are entered from the latest one.

**New benchmarks:** SWE-bench Pro (family swe-bench, with Epoch's SWE-bench Verified),
FrontierCode Diamond (family frontiercode), Terminal-Bench 2.1 (family terminal-bench,
with Epoch's 2.0), OSWorld-Verified (family osworld), HLE no tools (family
humanity-s-last-exam: Anthropic's no-tools runs differ from Epoch's HLE, e.g.
Sonnet 5.5 56.9% vs 46.1%), GDP.pdf, Blueprint-Bench 2, Legal Agent Benchmark,
BioMysteryBench (hard / human solved), ExploitBench, HealthBench Professional.

**New site categories:** cyber and life-sciences (seeds/benchmark_categories.csv).
