# Inkling 2 Small (Thinking Machines), released 5 Nov 2026 (weights on Hugging Face since 12 Nov)

**Source:** https://thinkingmachines.ai/news/inkling-2-small/ (HTML table; read 19 Nov 2026)

**Entered:** 19 Nov 2026. Inkling 2 Small only (xhigh effort).

**Most results are not Thinking Machines' own runs.** The page says it uses "externally reported
evaluations" and names the source of each:

- Artificial Analysis rows are **not entered** (licence): AA-3D, AA-AnalystAgent, AA-Briefcase, AA-LCR,
  AA-Omniscience, AutomationBench-AA, Code2Video-AA, CritPt v2, EnterpriseOps-Gym, FrontierCode v2.0,
  GDP.pdf, GDPVal-AA, HLE (text only), HLE-Diamond, MMMU Pro, Tau 3 Banking, Terminal Bench Science,
  Terminal Bench 2.1 and 4.0. (FrontierCode's Haiku 5.5 34.9 / GPT-6 Luna 25.2 equal Meta's
  "FrontierCode 2.0-AA" row, which confirms the source.)
- Rows from benchmark maintainers and leaderboards (Datacurve, Scale AI, Surge, Vals AI, Mercor,
  Thoughtful, Julius Research, Handshake, MathArena, ARC Prize) are entered as `independent`, with the
  source in the notes.
- The rest are Thinking Machines' own runs (`vendor_reported`).

**New benchmarks:** SWE-Atlas v1.1, Sudo L7, DeepSearchQA, JobBench, DAYJOB (Healthcare, Finance),
EnterpriseBench-CoreCraft, Finance Agent v2.1, Excel Modeling Benchmark v1.1, Tax Agent Bench,
APEX-Accounting v1.1, DeepFinance, Diligence Bench, ATLAS-Finance v1.1, Legal Agent Benchmark v1.1 (Vals),
Legal Research Bench, PerceptionBench, Humanity's Sixth Sense, OmniDocBench v1.6, SAGE v1.1, MuirBench,
ZeroBench (no tools), ArxivMath and BrokenArxiv (Oct 2026), MysteryMechanism, LongBench v2,
ComplexConstraints, Global-MMLU-Lite, MDPBench, CyberBench v1.1, PatchEval.

**Also not entered, and why:** Vals Index (composite); BioMysteryBench (Vals' terminus-v2 run; no shared
model with our v11 rows); SimpleVQA with search (Muse Spark Open 63.6 here vs 73.6 on Meta's page, so the
set-up differs); PMPP-Hard (an area-under-curve unit, not a share); BVB and VIALS (unclear benchmark, and
two set-ups in one cell); DesignArena and Code Arena (Elo); the safety and alignment tables.
