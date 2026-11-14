// Best AI model: notable models ranked on Epoch AI benchmarks, by category.
// Data: data/benchmarks.json. Everything here is presentation.

import * as d3 from "https://cdn.jsdelivr.net/npm/d3@7.9.0/+esm";
import { createRace } from "./race.js";

const TOP = 15;                     // most rows shown before "Show all"
const ROW_H = { min: 22, max: 30 }; // row height flexes in this range so the top rows fit on one screen

// Switching benchmark plays in three beats (ms): leavers fade, stayers re-sort, newcomers arrive.
const MOTION = { exit: 240, move: 800, enter: 600, enterAfter: 260, stagger: 18, maxStagger: 270 };
const reducedMotion = matchMedia("(prefers-reduced-motion: reduce)");

// Company colours: each company's own brand colour, fixed per company (never by rank).
// Brands collide (Google, DeepSeek, Kimi, Meta, Qwen and Zhipu are all bright blue), so only
// companies with a distinctive brand colour get one; DeepSeek's blue is deepened so it doesn't
// merge with Google's. Every row also carries the company logo, so identity never rests on
// colour alone (the one close pair for colour-blind readers is clay vs green).
// The hex values live in styles.css (--lab-*), with a light and a dark set, so switching
// theme recolours the chart in CSS alone, without re-rendering or interrupting an animation.
const LAB_COLORS = new Map([
  ["Anthropic", "var(--lab-anthropic)"], // Claude clay
  ["OpenAI", "var(--lab-openai)"],       // ChatGPT green
  ["Google", "var(--lab-google)"],       // Gemini blue
  ["xAI", "var(--lab-xai)"],             // xAI black (white in dark mode)
  ["DeepSeek", "var(--lab-deepseek)"],   // DeepSeek blue, deepened
]);
const OTHER = { label: "Other", color: "var(--lab-other)" };
const colorOf = (lab) => LAB_COLORS.get(lab) ?? OTHER.color;
const keyOf = (lab) => (LAB_COLORS.has(lab) ? lab : OTHER.label);

// Company logos: LobeHub's AI brand icons (MIT), single-colour SVGs used as a CSS mask
// and painted in the company colour. Companies without an icon get an empty slot.
const LOGO_URL = (icon) => `https://cdn.jsdelivr.net/npm/@lobehub/icons-static-svg@1.97.0/icons/${icon}.svg`;
const LOGOS = {
  Anthropic: "anthropic", OpenAI: "openai", Google: "google", xAI: "xai", DeepSeek: "deepseek",
  Alibaba: "alibaba", Meta: "meta", "Z.ai": "zai", Moonshot: "moonshot", Mistral: "mistral",
  ByteDance: "bytedance", MiniMax: "minimax", Nvidia: "nvidia", Microsoft: "microsoft",
  "Microsoft Research": "microsoft", Xiaomi: "xiaomimimo", "01.AI": "zeroone",
  "Technology Innovation Institute": "tii", Amazon: "aws", "Hugging Face": "huggingface",
  Cursor: "cursor", Cohere: "cohere", Baichuan: "baichuan", "Allen Institute for AI": "ai2",
  "Nous Research": "nousresearch", Poolside: "poolside", "Stability AI": "stability",
  "Cerebras Systems": "cerebras", Tencent: "tencent", StepFun: "stepfun", "Inception Labs": "inception",
};
const logoOf = (lab) => (LOGOS[lab] ? `url("${LOGO_URL(LOGOS[lab])}")` : null);
const markColor = (lab) => LAB_COLORS.get(lab) ?? "var(--muted)"; // logos of "Other" companies stay muted

const fmtPrice = (v) => "$" + (v >= 10 && Number.isInteger(v) ? v : v.toFixed(2));
const fmtMonth = (iso) => (iso ? d3.utcFormat("%b %Y")(new Date(iso + "T00:00:00Z")) : "");
const escapeHtml = (s) => String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

// How a score reads depends on the benchmark's unit.
const UNITS = {
  pct: { fmt: (s) => `${(s * 100).toFixed(1)}%`, tick: (t) => `${Math.round(t * 100)}%`, caption: "Share of tasks solved" },
  points: { fmt: (s) => s.toFixed(2), tick: (t) => `${t}`, caption: "Score out of 10" },
  index: { fmt: (s) => s.toFixed(1), tick: (t) => `${t}`, caption: "Index score" },
};

// ── Load ──────────────────────────────────────────────────────
const chartEl = document.querySelector(".chart");
let data;
try {
  const res = await fetch("data/benchmarks.json", { cache: "no-cache" });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  data = await res.json();
} catch (err) {
  chartEl.innerHTML = `<p>Couldn't load the benchmark data (${escapeHtml(err.message)}).</p>`;
  throw err;
}

const categories = data.categories.filter((c) => c.benchmarks.length);
const catById = new Map(categories.map((c) => [c.id, c]));
const benchById = new Map(data.benchmarks.map((b) => [b.id, b]));
for (const b of data.benchmarks) {
  // Competition ranking: tied scores share a rank.
  b.models.forEach((m) => { m.rank = 1 + b.models.filter((o) => o.score > m.score).length; });
}
document.querySelector('[data-stat="generated"]').title =
  `Epoch AI, Capabilities & benchmarking. Licensed CC BY 4.0, including results Epoch collects from each benchmark's publisher. As of ${d3.utcFormat("%-d %b %Y")(new Date(data.generated + "T00:00:00Z"))}.`;

// ── State, mirrored in the URL hash (#category/benchmark) ─────
const [hashCat, hashBench] = location.hash.slice(1).split("/");
const state = { cat: catById.has(hashCat) ? hashCat : categories[0].id, bench: null, pinned: null, showAll: false, layout: { rows: TOP, rh: ROW_H.max } };
state.bench = catById.get(state.cat).benchmarks.includes(hashBench) ? hashBench : catById.get(state.cat).benchmarks[0];

let emblem = null; // 3D category emblem, loaded after the chart (see bottom)
let race = null;   // "best over time" chart in the section below (see bottom)

function select(cat, bench) {
  emblem?.show(cat);
  race?.show(cat);
  state.cat = cat;
  state.bench = bench ?? catById.get(cat).benchmarks[0];
  state.showAll = false;
  history.replaceState(null, "", `#${state.cat}/${state.bench}`);
  render();
}

// ── Controls ──────────────────────────────────────────────────
const catButtons = d3.select(".categories").selectAll("button").data(categories).join("button")
  .attr("type", "button").attr("role", "tab")
  .text((c) => c.label)
  .on("click", (event, c) => select(c.id));

const pillsEl = d3.select(".bench-pills");

// ── Fit to screen ─────────────────────────────────────────────
// The chart frame gets whatever height the header, title and pills leave (CSS flex).
// Rows stretch between 22 and 30px to fit the top 15 there; on a very short window,
// fewer rows show at 22px. "Show all" lets the page grow and scroll instead.
const board = document.querySelector(".board");
const frame = document.querySelector(".chart-frame");
function fit() {
  const avail = frame.clientHeight;
  const rh = Math.max(ROW_H.min, Math.min(ROW_H.max, Math.floor(avail / TOP)));
  return { rh, rows: Math.max(5, Math.min(TOP, Math.floor(avail / rh))) };
}
// Window resized, or fonts finished loading and moved the title: refit if the answer changed.
new ResizeObserver(() => {
  if (state.showAll) return;
  const f = fit();
  if (f.rows !== state.layout.rows || f.rh !== state.layout.rh) render();
}).observe(frame);

// ── Render ────────────────────────────────────────────────────
function render() {
  const cat = catById.get(state.cat);
  const b = benchById.get(state.bench);
  const unit = UNITS[b.unit];
  board.classList.toggle("expanded", state.showAll);
  if (!state.showAll) state.layout = fit(); // measure after the class change
  const rh = state.layout.rh;
  document.documentElement.style.setProperty("--row-h", `${rh}px`);

  catButtons.attr("aria-selected", (c) => String(c.id === cat.id));
  document.querySelector(".phrase").textContent = cat.phrase;

  // Benchmark pills: only when the category has a choice to make.
  const benches = cat.benchmarks.map((id) => benchById.get(id));
  pillsEl.attr("hidden", benches.length > 1 ? null : "");
  pillsEl.selectAll("button").data(benches, (d) => d.id).join("button")
    .attr("type", "button").attr("role", "tab")
    .attr("aria-selected", (d) => String(d.id === b.id))
    .text((d) => d.name)
    .on("click", (event, d) => select(cat.id, d.id));

  const m = reducedMotion.matches ? 0 : 1; // 0 turns every duration and delay off

  // Axis: five gridlines from 0 to the benchmark's maximum, drawn behind the rows; their labels sit
  // in a separate row under the chart. Labels cross-fade when the scale changes.
  const ticks = [0, 0.25, 0.5, 0.75, 1].map((f) => f * b.max);
  const at = (t) => `${(t / b.max) * 100}%`;
  d3.select(".axis").selectAll("span").data(ticks).join("span").style("left", at);
  d3.select(".axis-scale").selectAll("span").data(ticks).join((enter) => enter.append("span").call((s) => s.append("b")))
    .style("left", at)
    .select("b").each(function (t) { swapText(this, unit.tick(t), m); });
  // A combined score is an estimate (see prep: IRT fit), so its caption says so.
  const caption = b.kind === "composite" ? `Est. share solved on a typical ${cat.label.toLowerCase()} benchmark` : unit.caption;
  d3.select(".axis-scale").selectAll("i").data([0]).join("i").each(function () { swapText(this, caption, m); });

  // Rows: as many as fit (up to 15). A followed model further down takes the last slot,
  // marked with a dotted rule so it doesn't read as the next rank.
  const pinnedModel = state.pinned && b.models.find((model) => model.name === state.pinned);
  let shown = state.showAll ? b.models : b.models.slice(0, state.layout.rows);
  const detached = pinnedModel && !shown.includes(pinnedModel);
  if (detached) shown = shown.slice(0, -1);
  const items = shown.map((model, i) => ({ m: model, slot: i }));
  if (detached) items.push({ m: pinnedModel, slot: shown.length, detached: true });

  // Company legend: only the companies on screen, in the fixed palette order, "Other" last.
  const present = new Set(items.map((d) => keyOf(d.m.lab)));
  const keys = [...LAB_COLORS.keys(), OTHER.label].filter((k) => present.has(k));
  d3.select(".companies").selectAll(".key").data(keys, (k) => k)
    .join((enter) => enter.append("span").attr("class", "key").call((s) => { s.append("i"); s.append("span"); }))
    .order()
    .call((s) => s.select("i")
      .attr("class", (k) => (k === OTHER.label ? "swatch" : "logo"))
      .style("background", (k) => (k === OTHER.label ? OTHER.color : null))
      .style("--mark", (k) => LAB_COLORS.get(k) ?? null)
      .style("--logo", (k) => logoOf(k)))
    .call((s) => s.select("span").text((k) => k));

  chartEl.style.height = `${(items.length ? d3.max(items, (d) => d.slot) + 1 : 0) * rh}px`;
  chartEl.classList.toggle("has-pin", Boolean(pinnedModel));

  // Rows still fading out are skipped, so a model that comes straight back gets a fresh row.
  const rows = d3.select(chartEl).selectAll(".row:not(.exiting)").data(items, (d) => d.m.name);

  // Beat 1: models not on this benchmark shrink their bars and fade out.
  const exiting = rows.exit().classed("exiting", true).attr("tabindex", null).attr("aria-hidden", "true");
  exiting.transition("row").duration(MOTION.exit * m).ease(d3.easeCubicIn).style("opacity", 0).remove();
  exiting.select(".bar").transition("bar").duration(MOTION.exit * m).ease(d3.easeCubicIn).tween("bar", barTween(() => 0));
  const t0 = exiting.empty() ? 0 : MOTION.exit * 0.6 * m; // beat 2 overlaps the tail of beat 1

  const entering = rows.enter().append("div")
    .attr("class", "row").attr("role", "listitem").attr("tabindex", 0)
    .style("opacity", 0)
    .style("transform", (d) => `translateY(${d.slot * rh + 10}px)`); // rises 10px into place
  entering.append("span").attr("class", "rank");
  const who = entering.append("span").attr("class", "who");
  who.append("i").attr("class", "logo").attr("aria-hidden", "true");
  who.append("span").attr("class", "name");
  const track = entering.append("span").attr("class", "track");
  track.append("span").attr("class", "bar");
  track.append("span").attr("class", "score");
  entering.on("click", (event, d) => togglePin(d.m.name))
    .on("keydown", (event, d) => { if (event.key === "Enter" || event.key === " ") { event.preventDefault(); togglePin(d.m.name); } })
    .on("mouseenter mousemove", (event, d) => showTip(event, d.m))
    .on("mouseleave", hideTip);

  // Beat 2: rows that stay re-sort, top of the list first, so the order settles as a cascade.
  // Beat 3: newcomers arrive a moment later, once the existing rows have started moving.
  const isNew = new Set(entering.nodes());
  const rowOf = (node) => node.closest(".row");
  const delayOf = (node, d) => (t0 + (isNew.has(rowOf(node)) ? MOTION.enterAfter : 0) + Math.min(d.slot * MOTION.stagger, MOTION.maxStagger)) * m;
  const durationOf = (node) => (isNew.has(rowOf(node)) ? MOTION.enter : MOTION.move) * m;
  const timed = (t) => t.delay(function (d) { return delayOf(this, d); }).duration(function () { return durationOf(this); }).ease(d3.easeCubicInOut);

  const all = entering.merge(rows)
    .classed("open", (d) => d.m.open_weights === true)
    .classed("pinned", (d) => d.m.name === state.pinned)
    .classed("detached", (d) => Boolean(d.detached))
    .style("--lab", (d) => colorOf(d.m.lab))
    .attr("aria-label", (d) => `${d.m.rank}. ${d.m.name}, ${unit.fmt(d.m.score)}`)
    .each(function (d) {
      // Rows climbing the ranking pass in front of rows sliding down.
      this.style.zIndex = this._slot != null && d.slot < this._slot ? 2 : 1;
      this._slot = d.slot;
    })
    .order(); // HTML order = rank order, so Tab and screen readers follow the ranking (position comes from transform)
  all.select(".name").text((d) => d.m.name);
  all.select(".logo")
    .classed("none", (d) => !logoOf(d.m.lab))
    .attr("title", (d) => d.m.lab || null)
    .style("--logo", (d) => logoOf(d.m.lab))
    .style("--mark", (d) => markColor(d.m.lab));

  all.transition("row").call(timed)
    .style("opacity", 1)
    .style("transform", (d) => `translateY(${d.slot * rh}px)`)
    .on("start", function () { this.querySelector(".rank").textContent = this.__data__.m.rank; });
  all.select(".bar").transition("bar").call(timed).tween("bar", barTween((d) => d.m.score / b.max));
  all.select(".score").transition("bar").call(timed).tween("score", scoreTween(b, unit));

  const btn = document.querySelector(".show-all");
  btn.hidden = b.n_models <= state.layout.rows;
  btn.textContent = state.showAll ? `Show top ${state.layout.rows}` : `Show all ${b.n_models}`;

  const note = document.querySelector(".pin-note");
  note.hidden = !state.pinned;
  if (state.pinned) {
    note.innerHTML = pinnedModel
      ? `<b>${escapeHtml(state.pinned)}</b> · #${pinnedModel.rank} of ${b.n_models}`
      : `<b>${escapeHtml(state.pinned)}</b> · not tested on ${escapeHtml(b.name)}`;
  }
}

// ── Tweens ────────────────────────────────────────────────────
// Bars are sized as a share of the track (0–1), stored on the element as _frac.
// D3's own style tween would read the browser's computed width in px and blend
// it with a % target, so these tweens interpolate the share themselves.
function barTween(target) {
  return function (d) {
    const from = this._frac ?? 0, to = target(d);
    return (t) => { this._frac = from + (to - from) * t; this.style.width = `${this._frac * 100}%`; };
  };
}

// The score label rides the end of its bar and counts to the new value. It starts
// from what the bar currently shows, read in this benchmark's scale, so the number
// always matches the bar's length, even when the scale changes (% to index).
function scoreTween(b, unit) {
  return function (d) {
    const from = this._frac ?? 0, to = d.m.score / b.max;
    return (t) => {
      this._frac = from + (to - from) * t;
      this.style.left = `${this._frac * 100}%`;
      this.textContent = unit.fmt(t === 1 ? d.m.score : this._frac * b.max);
    };
  };
}

// Cross-fade a label to new text. data-text holds the target, so quick clicks can't leave a stale label.
function swapText(node, text, m) {
  if (node.dataset.text === text) return;
  const first = node.dataset.text == null;
  node.dataset.text = text;
  if (first || !m) { d3.select(node).interrupt("swap").style("opacity", null); node.textContent = text; return; }
  d3.select(node).transition("swap").duration(140).style("opacity", 0)
    .on("end", () => { node.textContent = text; })
    .transition().duration(260).style("opacity", 1);
}

function togglePin(name) {
  state.pinned = state.pinned === name ? null : name;
  render();
}

document.querySelector(".show-all").addEventListener("click", () => {
  state.showAll = !state.showAll;
  render();
});

// ── Tooltip ───────────────────────────────────────────────────
const tooltip = document.querySelector(".tooltip");
function showTip(event, m) {
  const b = benchById.get(state.bench);
  tooltip.innerHTML = `
    <p class="tt-name">${escapeHtml(m.name)}</p>
    <p class="tt-meta">${[m.lab, fmtMonth(m.released), m.open_weights === true ? "Open weights" : m.open_weights === false ? "Closed" : ""].filter(Boolean).map(escapeHtml).join(" · ")}</p>
    <dl>
      <dt>${b.kind === "composite" ? `${escapeHtml(catById.get(b.category).label)} overall` : escapeHtml(b.name)}</dt><dd>${UNITS[b.unit].fmt(m.score)}</dd>
      <dt>Rank</dt><dd>${m.rank} of ${b.n_models}</dd>
      ${(m.parts ?? []).map(([id, score], i) => {
        const part = benchById.get(id);
        return `<dt class="${i === 0 ? "tt-first" : ""}">${escapeHtml(part.name)}</dt><dd class="${i === 0 ? "tt-first" : ""}">${UNITS[part.unit].fmt(score)}</dd>`;
      }).join("")}
      ${m.harness ? `<dt>Agent</dt><dd>${escapeHtml(m.harness)}</dd>` : ""}
      ${m.effort ? `<dt>Reasoning effort</dt><dd>${escapeHtml(m.effort)}</dd>` : ""}
      ${m.output_price != null ? `<dt>Output price</dt><dd>${fmtPrice(m.output_price)} / M tokens</dd>` : ""}
    </dl>`;
  placeTip(tooltip, board, event);
}
// Show a tooltip above-right of the pointer, flipping left near the container's right edge.
// Shared by both charts so their tooltips behave the same.
function placeTip(tip, container, event) {
  tip.hidden = false;
  const box = container.getBoundingClientRect();
  const x = event.clientX - box.left, y = event.clientY - box.top;
  const tw = tip.offsetWidth, th = tip.offsetHeight;
  tip.style.left = `${x + 18 + tw > box.width ? x - 18 - tw : x + 18}px`;
  tip.style.top = `${Math.max(0, y - th - 12)}px`;
}
function hideTip() { tooltip.hidden = true; }

// ── Theme: System / Light / Dark ──────────────────────────────
// "System" = no data-theme attribute and nothing saved, so the CSS follows the OS.
const themeButtons = document.querySelectorAll("[data-theme-choice]");
const root = document.documentElement;
function markTheme() {
  const current = root.dataset.theme ?? "system";
  themeButtons.forEach((btn) => btn.setAttribute("aria-pressed", String(btn.dataset.themeChoice === current)));
}
themeButtons.forEach((btn) => btn.addEventListener("click", () => {
  const choice = btn.dataset.themeChoice;
  if (choice === "system") delete root.dataset.theme; else root.dataset.theme = choice;
  try { choice === "system" ? localStorage.removeItem("theme") : localStorage.setItem("theme", choice); } catch {} // private windows can refuse storage
  markTheme();
}));
markTheme();

render();

// ── Best over time (section below the leaderboard) ────────────
race = createRace(document.querySelector(".race"), {
  data, catById, benchById, LAB_COLORS, colorOf, keyOf, logoOf, markColor, fmtMonth, UNITS, escapeHtml, placeTip, reducedMotion,
});
race.show(state.cat, { animate: false }); // drawn below the fold, so no wipe on first load

// ── Pinned title: measured height, and the scroll-linked swap ──
// The title row's height feeds --title-h, so both sections are exactly one screen under it (it can
// wrap to two lines on a phone). On scroll: --solid fades its background in over the first 24px;
// --swap runs 0 → 1 over the last SWAP_PX before the race section reaches the title, so the
// wording changes exactly as the second chart takes over the screen. Position-linked, not timed.
const SWAP_PX = 160;
const EMBLEM_PX = 100; // the emblem has faded away by this much scroll
const titleBar = document.querySelector(".title-bar");
const raceEl = document.querySelector(".race");
new ResizeObserver(() => root.style.setProperty("--title-h", `${titleBar.offsetHeight}px`)).observe(titleBar);
let scrollQueued = false;
function onScroll() {
  scrollQueued = false;
  const gap = raceEl.getBoundingClientRect().top - titleBar.getBoundingClientRect().bottom;
  titleBar.style.setProperty("--solid", Math.min(1, scrollY / 24).toFixed(3));
  const lift = Math.min(1, Math.max(0, scrollY / EMBLEM_PX));
  titleBar.style.setProperty("--lift", lift.toFixed(3));
  titleBar.classList.toggle("emblem-gone", lift >= 1); // display:none, so emblem.js sees it off screen and stops drawing
  titleBar.style.setProperty("--swap", Math.max(0, Math.min(1, 1 - gap / SWAP_PX)).toFixed(3));
}
addEventListener("scroll", () => { if (!scrollQueued) { scrollQueued = true; requestAnimationFrame(onScroll); } }, { passive: true });
addEventListener("resize", onScroll);
onScroll();

// ── 3D category emblem (progressive enhancement) ──────────────
// Loaded only after the chart has drawn, and only where CSS shows the canvas (wide
// screens), so phones never download Three.js. If it fails, the canvas goes away.
const emblemCanvas = document.querySelector(".emblem");
if (emblemCanvas && matchMedia("(min-width: 1001px)").matches) { // same breakpoint as the CSS; not "is it visible now", which is false if the page loads scrolled down
  import("./emblem.js")
    .then(({ createEmblem }) => { emblem = createEmblem(emblemCanvas); emblem.show(state.cat); })
    .catch((err) => { emblemCanvas.remove(); console.info("3D emblem skipped:", err.message); });
}
