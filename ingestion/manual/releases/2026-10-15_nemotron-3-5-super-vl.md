# Nemotron 3.5 Super VL, released 15 Oct 2026 (open weights)

**Source:** https://huggingface.co/nvidia/NVIDIA-Nemotron-3.5-Super-VL-120B-A12B-BF16 (HTML table; read 19 Nov 2026)

**Entered:** 19 Nov 2026. Nemotron 3.5 Super VL (labelled "Nemotron 3.5 SuperGA BF16" in the table header)
and NVIDIA's older Nemotron 3 Ultra from the same table.

- HLE: the full-set score goes in hle-no-tools (29.20; text-only 31.79 in the notes). Nemotron 3 Ultra has
  only a text-only score (29.2), entered with that note.
- "APEX shortlist" = MathArena Apex (Shortlist). SciCode is the subtask score.
- Rows from the table's "[offline]" section are entered with that note (WebVoyager, Terminal-Bench 4.0,
  DeepSWE); BrowseComp [offline] repeats the main BrowseComp row.
- New: MMLU-ProX, CritPt, IFBench, WMT24++, τ³-bench (banking), BabyVision (no tools), MMLongBench-Doc,
  V*, OCR-Reasoning, MathVision, OCRBench v2 (English, Chinese), Video-MME v2, WebVoyager.

**Not entered, and why:** AA-Omniscience, AA-LCR, GDPval-AA, AA-Briefcase-Lite, AutomationBench-AA and
GDP.pdf (Artificial Analysis); LMArena v3 proxy (a crowd-leaderboard proxy); GraphWalks (context length
not stated); other developers' columns.
