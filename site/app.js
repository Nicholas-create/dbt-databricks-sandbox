// The price of a model: a scroll-driven chart of notable AI models.
// Data: data/models.json, written by scripts/export_site_data.py from the
// production mart rpt_models_latest_price. Everything here is presentation.

import * as d3 from "https://cdn.jsdelivr.net/npm/d3@7.9.0/+esm";

const reduceMotion = matchMedia("(prefers-reduced-motion: reduce)").matches;
const isNarrow = () => matchMedia("(max-width: 860px)").matches;

// ── Presentation helpers ──────────────────────────────────────
// Epoch lists organisations in full and sometimes several per model
// ("Z.ai (Zhipu AI),Tsinghua University"). The page groups by the first one,
// with shorter display names.
const LAB_NAMES = {
  "Google DeepMind": "Google",
  "Meta AI": "Meta",
  "Z.ai (Zhipu AI)": "Z.ai",
  "Xiaomi Corp": "Xiaomi",
  "Meituan Inc": "Meituan",
  "Mistral AI": "Mistral",
  "Motif Technologies": "Motif",
};
const labOf = (org) => {
  const first = org.split(",")[0].trim();
  return LAB_NAMES[first] ?? first;
};

const fmtPrice = (v) => "$" + (v >= 10 && Number.isInteger(v) ? v : v.toFixed(2));
const fmtTick = (v) => "$" + (v < 1 ? v.toFixed(2) : d3.format(",")(v));
const fmtDate = d3.utcFormat("%-d %b %Y");
const fmtContext = (v) => (v >= 1e6 ? `${+(v / 1e6).toFixed(1)}M` : `${Math.round(v / 1e3)}K`) + " tokens";
const escapeHtml = (s) => String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

// ── Load ──────────────────────────────────────────────────────
const chartEl = document.querySelector(".chart");
let payload;
try {
  const res = await fetch("data/models.json", { cache: "no-cache" });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  payload = await res.json();
} catch (err) {
  chartEl.innerHTML = `<p class="chart-error">Couldn't load the model data (${escapeHtml(err.message)}).</p>`;
  throw err;
}

const models = payload.models.map((m) => ({
  ...m,
  lab: labOf(m.organization),
  date: new Date(m.released + "T00:00:00Z"),
}));

// ── Numbers quoted in the story (computed, so they stay true as data changes) ──
const byPrice = d3.sort(models, (d) => d.output);
const cheapest = byPrice[0];
const priciest = byPrice.at(-1);
const closed = models.filter((d) => d.open_weights === false);
const open = models.filter((d) => d.open_weights === true);
const median = { closed: d3.median(closed, (d) => d.output), open: d3.median(open, (d) => d.output) };

// Labs with at least 3 priced models get a button; the rest stay in "All".
const labs = d3
  .rollups(models, (v) => v.length, (d) => d.lab)
  .filter(([, n]) => n >= 3)
  .sort((a, b) => d3.descending(a[1], b[1]))
  .map(([lab]) => lab);

const labModels = (lab) => d3.sort(models.filter((d) => d.lab === lab), (d) => d.output);
const spotlight = labs.includes("OpenAI") ? "OpenAI" : labs[0];
const spot = labModels(spotlight);

const stats = {
  count: models.length,
  labCount: new Set(models.map((d) => d.lab)).size,
  cheapestName: cheapest.name,
  cheapestPrice: fmtPrice(cheapest.output),
  priciestName: priciest.name,
  priciestPrice: fmtPrice(priciest.output),
  ratio: d3.format(",.2r")(priciest.output / cheapest.output),
  closedCount: closed.length,
  closedMedian: fmtPrice(median.closed),
  openCount: open.length,
  openMedian: fmtPrice(median.open),
  medianRatio: Math.round(median.closed / median.open),
  spotlight,
  spotCount: spot.length,
  spotMinName: spot[0].name,
  spotMinPrice: fmtPrice(spot[0].output),
  spotMaxName: spot.at(-1).name,
  spotMaxPrice: fmtPrice(spot.at(-1).output),
  pricesAsOf: fmtDate(new Date(payload.prices_as_of + "T00:00:00Z")),
};
document.querySelectorAll("[data-stat]").forEach((el) => {
  el.textContent = stats[el.dataset.stat] ?? "—";
});

// Which models get a name label when a lab is in focus: all of them if few,
// otherwise the cheapest, the most expensive and the newest.
function labelsFor(lab) {
  const list = labModels(lab);
  if (list.length <= 5) return list.map((d) => d.name);
  const newest = d3.greatest(list, (d) => d.date);
  return [...new Set([list[0].name, list.at(-1).name, newest.name])];
}

// ── Chart ─────────────────────────────────────────────────────
const M = { top: 12, right: 16, bottom: 34, left: 52 };
const svg = d3.select(chartEl).append("svg")
  .attr("role", "img")
  .attr("aria-label", `Scatter chart: ${models.length} AI models by release date and output price per million tokens. A full table is further down the page.`);
const gGrid = svg.append("g").attr("class", "grid");
const gAxis = svg.append("g").attr("class", "axis");
const gMedians = svg.append("g").attr("class", "medians");
const gDots = svg.append("g").attr("class", "dots");
const gLabels = svg.append("g").attr("class", "labels");
const hoverRing = svg.append("circle").attr("class", "hover-ring").attr("r", 11).style("opacity", 0);
const tooltip = document.querySelector(".tooltip");

let W = 0, H = 0, x, y, delaunay;
let state = { emphasis: "all", focus: null, labels: [], medians: [] };
let hasEntered = false;

const measure = document.createElement("canvas").getContext("2d");
const textWidth = (text, font) => { measure.font = font; return measure.measureText(text).width; };

function layout() {
  const rect = chartEl.getBoundingClientRect();
  W = rect.width; H = rect.height;
  if (W < 10 || H < 10) return;
  svg.attr("width", W).attr("height", H).attr("viewBox", `0 0 ${W} ${H}`);

  const [d0, d1] = d3.extent(models, (d) => d.date);
  x = d3.scaleUtc([d3.utcMonth.offset(d3.utcMonth.floor(d0), -2), d3.utcMonth.offset(d3.utcMonth.ceil(d1), 1)], [M.left, W - M.right]);
  const [p0, p1] = d3.extent(models, (d) => d.output);
  y = d3.scaleLog([p0 / 1.6, p1 * 1.6], [H - M.bottom, M.top]);

  // Gridlines at each power of ten only: the "ten times the last" in the story.
  const [e0, e1] = y.domain().map(Math.log10);
  const decades = d3.range(Math.ceil(e0), Math.floor(e1) + 1).map((e) => 10 ** e);
  gGrid.selectAll("g").data(decades, (d) => d)
    .join((enter) => { const g = enter.append("g"); g.append("line"); g.append("text"); return g; })
    .attr("transform", (d) => `translate(0,${y(d)})`)
    .call((g) => g.select("line").attr("x1", M.left).attr("x2", W - M.right))
    .call((g) => g.select("text").attr("x", M.left - 10).attr("dy", "0.32em").attr("text-anchor", "end").text(fmtTick));

  gAxis.attr("transform", `translate(0,${H - M.bottom})`)
    .call(d3.axisBottom(x)
      .ticks(d3.utcMonth.every(W < 560 ? 6 : 3))
      .tickSize(0).tickPadding(14)
      .tickFormat((d) => (d.getUTCMonth() === 0 ? d.getUTCFullYear() : d3.utcFormat("%b")(d))));

  gDots.selectAll("circle").data(models, (d) => d.name)
    .join((enter) => enter.append("circle").attr("r", 0))
    .attr("cx", (d) => x(d.date))
    .attr("cy", (d) => y(d.output));

  delaunay = d3.Delaunay.from(models, (d) => x(d.date), (d) => y(d.output));
  render(false);
}

function look(d) {
  const focused = state.focus !== null && d.lab === state.focus;
  const dimmed =
    (state.focus !== null && !focused) ||
    (state.emphasis === "closed" && d.open_weights) ||
    (state.emphasis === "open" && !d.open_weights);
  return { focused, dimmed };
}

function render(animate = true) {
  if (!x) return;
  const ms = animate && !reduceMotion ? 650 : 0;

  // Dots. The first time the story starts, they arrive in release order.
  const dots = gDots.selectAll("circle")
    .classed("open", (d) => d.open_weights)
    .classed("focused", (d) => look(d).focused);
  if (!hasEntered) {
    // Wait until the story's first step has fired.
    dots.attr("r", 0);
  } else {
    dots.transition().duration(ms).ease(d3.easeCubicOut)
      .delay((d) => (dots.enterDelay ? dots.enterDelay(d) : 0))
      .attr("r", (d) => (look(d).focused ? 6.5 : 5))
      .style("opacity", (d) => (look(d).dimmed ? 0.13 : 1));
  }
  // Focused dots on top of the others.
  dots.filter((d) => look(d).focused).raise();

  // Median reference lines.
  const meds = state.medians.map((k) => ({
    k, v: median[k],
    text: `${k === "closed" ? "Closed" : "Open-weights"} median ${fmtPrice(median[k])}`,
  }));
  gMedians.selectAll("g").data(meds, (d) => d.k)
    .join(
      (enter) => { const g = enter.append("g").style("opacity", 0); g.append("line"); g.append("text"); return g; },
      (update) => update,
      (exit) => exit.transition().duration(ms / 2).style("opacity", 0).remove(),
    )
    .attr("transform", (d) => `translate(0,${y(d.v)})`)
    .call((g) => g.select("line").attr("x1", M.left).attr("x2", W - M.right))
    .call((g) => g.select("text").attr("x", W - M.right).attr("y", -7).attr("text-anchor", "end").text((d) => d.text))
    .transition().duration(ms).style("opacity", 1);

  renderLabels(ms);
}

// Name labels with simple collision avoidance: place to the right of the dot
// (left if it would run off the chart), then push down past any label it overlaps.
function renderLabels(ms) {
  const NAME_FONT = "500 12px Inter", PRICE_FONT = "400 11px 'JetBrains Mono'";
  const placed = [];
  const items = d3.sort(models.filter((d) => state.labels.includes(d.name)), (d) => y(d.output)).map((d) => {
    const cx = x(d.date), cy = y(d.output);
    const price = fmtPrice(d.output);
    const w = textWidth(d.name, NAME_FONT) + 6 + textWidth(price, PRICE_FONT);
    let side = cx + 12 + w > W - M.right ? "left" : "right";
    const lx = side === "right" ? cx + 12 : cx - 12;
    const [x0, x1] = side === "right" ? [lx, lx + w] : [lx - w, lx];
    let ly = cy;
    for (let guard = 0; guard < 20; guard++) {
      const hit = placed.find((p) => Math.abs(p.ly - ly) < 16 && p.x0 < x1 && x0 < p.x1);
      if (!hit) break;
      ly = hit.ly + 16;
    }
    const item = { d, cx, cy, lx, ly, side, price, x0, x1 };
    placed.push(item);
    return item;
  });

  gLabels.selectAll("g.lbl").data(items, (i) => i.d.name)
    .join(
      (enter) => {
        const g = enter.append("g").attr("class", "lbl").style("opacity", 0);
        g.append("line");
        const t = g.append("text");
        t.append("tspan").attr("class", "lbl-name");
        t.append("tspan").attr("class", "lbl-price").attr("dx", 6);
        return g;
      },
      (update) => update,
      (exit) => exit.transition().duration(ms / 2).style("opacity", 0).remove(),
    )
    .call((g) => g.select("line")
      .attr("x1", (i) => i.cx + (i.side === "right" ? 6 : -6)).attr("y1", (i) => i.cy)
      .attr("x2", (i) => i.lx + (i.side === "right" ? -3 : 3)).attr("y2", (i) => i.ly)
      .style("display", (i) => (Math.abs(i.ly - i.cy) > 4 ? null : "none")))
    .call((g) => g.select("text")
      .attr("x", (i) => i.lx).attr("y", (i) => i.ly).attr("dy", "0.35em")
      .attr("text-anchor", (i) => (i.side === "right" ? "start" : "end")))
    .call((g) => g.select(".lbl-name").text((i) => i.d.name))
    .call((g) => g.select(".lbl-price").text((i) => i.price))
    .transition().duration(ms).style("opacity", 1);
}

function setState(next, animate = true) {
  state = { ...state, ...next };
  syncControls();
  render(animate);
}

// First entrance: dots grow in, left to right by release date.
function enter() {
  if (hasEntered) return;
  hasEntered = true;
  const span = W - M.left - M.right;
  const sel = gDots.selectAll("circle");
  sel.transition().duration(reduceMotion ? 0 : 500).ease(d3.easeBackOut.overshoot(2))
    .delay((d) => (reduceMotion ? 0 : ((x(d.date) - M.left) / span) * 1300))
    .attr("r", (d) => (look(d).focused ? 6.5 : 5))
    .style("opacity", (d) => (look(d).dimmed ? 0.13 : 1));
}

// ── Hover / tap ───────────────────────────────────────────────
function showTip(d) {
  const cx = x(d.date), cy = y(d.output);
  hoverRing.attr("cx", cx).attr("cy", cy).style("opacity", 1);
  tooltip.innerHTML = `
    <p class="tt-name">${escapeHtml(d.name)}</p>
    <p class="tt-meta">${escapeHtml(d.organization.split(",")[0])} · ${fmtDate(d.date)} · ${d.open_weights ? "Open weights" : "Closed"}</p>
    <dl>
      <dt>Output</dt><dd>${fmtPrice(d.output)} / M</dd>
      <dt>Input</dt><dd>${fmtPrice(d.input)} / M</dd>
      ${d.context ? `<dt>Context</dt><dd>${fmtContext(d.context)}</dd>` : ""}
    </dl>`;
  tooltip.hidden = false;
  const stage = tooltip.parentElement.getBoundingClientRect();
  const chart = chartEl.getBoundingClientRect();
  const px = chart.left - stage.left + cx, py = chart.top - stage.top + cy;
  const tw = tooltip.offsetWidth, th = tooltip.offsetHeight;
  const left = px + 18 + tw > stage.width ? px - 18 - tw : px + 18;
  const top = Math.min(Math.max(py - th / 2, 0), stage.height - th);
  tooltip.style.left = `${Math.max(0, left)}px`;
  tooltip.style.top = `${top}px`;
}
function hideTip() {
  hoverRing.style("opacity", 0);
  tooltip.hidden = true;
}
function onPointer(event) {
  if (!delaunay || !hasEntered) return;
  const [mx, my] = d3.pointer(event);
  const d = models[delaunay.find(mx, my)];
  // Hit target bigger than the dot, but not the whole chart.
  if (Math.hypot(x(d.date) - mx, y(d.output) - my) > 26) return hideTip();
  showTip(d);
}
svg.on("pointermove", onPointer).on("pointerdown", onPointer).on("pointerleave", hideTip);

// ── Lab buttons + legend ──────────────────────────────────────
let chosenLab = null; // what the reader picked; the scripted steps can override it
const labBar = d3.select(".labs");
labBar.selectAll("button").data(["All", ...labs]).join("button")
  .attr("type", "button")
  .text((d) => d)
  .on("click", (event, lab) => {
    chosenLab = lab === "All" ? null : lab;
    setState({ focus: chosenLab, labels: chosenLab ? labelsFor(chosenLab) : [], emphasis: "all" });
  });

function syncControls() {
  labBar.selectAll("button").attr("aria-pressed", (d) => String(d === "All" ? state.focus === null : d === state.focus));
  const key = document.querySelector(".key-focus");
  key.hidden = state.focus === null;
  key.querySelector(".focus-name").textContent = state.focus ?? "";
}

// ── Scroll steps ──────────────────────────────────────────────
const STEPS = {
  all: () => ({ emphasis: "all", focus: null, labels: [], medians: [] }),
  range: () => ({ emphasis: "all", focus: null, labels: [cheapest.name, priciest.name], medians: [] }),
  closed: () => ({ emphasis: "closed", focus: null, labels: [], medians: ["closed"] }),
  open: () => ({ emphasis: "open", focus: null, labels: [], medians: ["closed", "open"] }),
  lab: () => ({ emphasis: "all", focus: spotlight, labels: labelsFor(spotlight), medians: [] }),
  explore: () => ({ emphasis: "all", focus: chosenLab, labels: chosenLab ? labelsFor(chosenLab) : [], medians: ["closed", "open"] }),
};

const stepEls = [...document.querySelectorAll(".step")];
const stepObserver = new IntersectionObserver((entries) => {
  for (const entry of entries) {
    if (!entry.isIntersecting) continue;
    stepEls.forEach((el) => el.classList.toggle("is-active", el === entry.target));
    const id = entry.target.dataset.step;
    hideTip();
    if (!hasEntered) { state = { ...state, ...STEPS[id]() }; syncControls(); enter(); render(false); }
    else setState(STEPS[id]());
  }
}, {
  // A step is "current" when it crosses the middle of the screen; on phones the
  // chart covers the top 60%, so the trigger line sits lower.
  rootMargin: isNarrow() ? "-72% 0px -20% 0px" : "-45% 0px -45% 0px",
});
stepEls.forEach((el) => stepObserver.observe(el));

// Header label follows the section in view (hero/story vs. how it's built).
const label = document.querySelector(".section-label");
const sectionObserver = new IntersectionObserver((entries) => {
  for (const e of entries) if (e.isIntersecting) label.textContent = e.target.dataset.label;
}, { rootMargin: "-50% 0px -50% 0px" });
document.querySelectorAll("[data-label]").forEach((el) => sectionObserver.observe(el));

// Progress bar.
const bar = document.querySelector(".progress span");
const onScroll = () => {
  const max = document.documentElement.scrollHeight - innerHeight;
  bar.style.width = `${max > 0 ? (scrollY / max) * 100 : 0}%`;
};
addEventListener("scroll", onScroll, { passive: true });
onScroll();

// Redraw on resize without replaying the entrance.
new ResizeObserver(() => { layout(); }).observe(chartEl);
layout();
syncControls();

// ── Table view (same data, for screen readers and anyone who prefers rows) ──
const tbody = document.querySelector(".table-view tbody");
tbody.innerHTML = d3.sort(models, (d) => -d.date).map((d) => `
  <tr>
    <td>${escapeHtml(d.name)}</td>
    <td>${escapeHtml(d.lab)}</td>
    <td>${fmtDate(d.date)}</td>
    <td>${d.open_weights ? "Open" : "Closed"}</td>
    <td class="r">${fmtPrice(d.input)}</td>
    <td class="r">${fmtPrice(d.output)}</td>
    <td class="r">${d.context ? fmtContext(d.context).replace(" tokens", "") : "—"}</td>
  </tr>`).join("");
