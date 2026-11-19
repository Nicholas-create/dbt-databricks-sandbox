# MiniMax M3.1 Flash, released 19 Oct 2026

**Source:** https://www.minimax.io/blog/minimax-m31f (benchmark table as an image; read 19 Nov 2026)

**Entered:** 19 Nov 2026, transcribed from the image. MiniMax M3.1 Flash only. Weights "will be released
later", so `is_open_weights = false` for now.

**Benchmark mapping:**

- Automation-Bench v1.0.6 (600 public tasks): DeepSeek-V4.1-Flash-1017 60.5% and V4.1-Flash 54.8% match
  our "AutomationBench v1.0.6 (DeepSeek runs)" exactly, so that benchmark is the public task set, not a
  DeepSeek-only set-up: renamed "AutomationBench v1.0.6 (public tasks)" (id unchanged).
- Terminal Bench 4.0 and NL2Repo-Bench: DeepSeek values match ours. OSWorld 2.0: Claude Opus 5 70.6% matches.
- HLE (w/o tools) is the text-only subset; entered in hle-no-tools (developers' own runs) with that note.
- New: BankerToolBench, LOCA-Bench (256K), SWE Refactor Bench, Agents' Last Exam v1.1 (leaderboard overall).

**Not entered:** GDP.pdf AA (Artificial Analysis).
