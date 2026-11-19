# Gemini 4 Neon, announced 18 Nov 2026

**Source:** https://deepmind.google/models/model-cards/gemini-4-neon/ (HTML table, published
18 Nov 2026; read 19 Nov 2026)

**Entered:** 19 Nov 2026. Gemini 4 Neon only; the table's other columns are Claude Opus 5.5
and GPT-6.2 Sol (other developers' models).

**Benchmark mapping:**

- SWE-sweep: the card splits two harnesses. "Mini-SWE harness" is our existing swe-sweep
  (Opus 5.5 3.6% here and on the Gemini 4 Carbon card), which now gets the family swe-sweep
  and the label "mini-SWE harness". "Provider harness" is new: swe-sweep-provider-harness.
- CursorBench 4.1: new variant in the cursorbench family (Opus 5.5 58.1% here vs 57.8% on 4.0).
- CWE-Bench v2 = cwe-bench (the Carbon card printed whole numbers: Opus 5.5 67.0% there,
  67.1% here).
- Terminal-bench 4.1 (cheating-adjusted) = terminal-bench-4-1. Chartography (no note) =
  chartography (no tools), as on the Carbon and Hydrogen cards. MKA = Climb WSR.
- New: WebExploitBench v1.2 (cyber).

**Not entered, and why:** AA Index (Artificial Analysis), Vals Index (a third-party
composite), and the safety tables.
