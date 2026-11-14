# Claude Fable 5.2 and Claude Mythos 5.2, announced 9 Nov 2026 (additions)

**Source:** https://www.anthropic.com/claude-fable-and-mythos-5-2 (HTML table; read again 14 Nov 2026)

**Entered:** 14 Nov 2026. The first batch (2026-11-09_claude-fable-5-2.md) skipped rows with
no site category and the Mythos cells; the database is now meant to hold every result on
a release page, and the site has cyber and life-sciences categories.

**Entered:**

- The cell labelled "75.3% (Mythos 5.2)" (Terminal-Bench-Science).
- Cyber and protein design rows: Mythos 5.2 and Mythos 5.1 as labelled; the Opus 5.5
  column is "without safeguards" (in the notes). CyScenarioBench: each lab's scores
  are on unique tasks (footnote).
- De novo binder design: the page prints a score with no unit or scale, so it is an
  'index' benchmark, shown exactly as published and left out of the Overall fit.
- RoboDojo Sim (Agents): run internally at the highest available effort.
- Chartography (no tools).

Definition fixes (append-only, newest row wins):

- osworld-2-1 joins the osworld family as "2.1 offline".
- hle-with-tools: its name had lost the apostrophe ("Humanitys"). Databricks SQL reads
  `'Humanity''s'` as two string literals glued together; apostrophes are now escaped as `\'`.

**Still not entered:** GPT-6 Astra / Gemini 4 Carbon / GPT-6 Cyber columns (competitors),
AA-Briefcase (Artificial Analysis), effort-curve charts (no printed values; BenchCAD 2.1
only appears there).
