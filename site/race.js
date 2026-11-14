// "Best over time": one stepped line per company = the best score any of its models had reached
// by each date, with every release as a faint dot behind. Follows the category tabs.
// Shared helpers (colours, logos, units) come in from app.js, so both charts stay in step.

import * as d3 from "https://cdn.jsdelivr.net/npm/d3@7.9.0/+esm";

const WIPE_MS = 900;   // lines draw left to right on each category switch
const DOT_PX = 14;     // pointer this close to a release dot: show that model instead of the date scrub
const LABEL_GAP = 20;  // minimum vertical space between end labels (px)
const CORNER = 5;      // radius of the rounded step corners (px)

// Turn one company's releases into the points of its "best so far" line.
// Input: that company's models, each { released: "YYYY-MM-DD", score, ... }.
// Output: only the releases that beat everything the company had before, oldest first.
// A step line through these points never goes down: a weaker later model doesn't lower it.
export function companyFrontier(models) {
  const byDate = [...models].sort((a, b) => a.released.localeCompare(b.released) || b.score - a.score);
  const steps = [];
  for (const m of byDate) {
    if (!steps.length || m.score > steps.at(-1).score) steps.push(m);
  }
  return steps;
}

// The best score a line had reached on a date (null before its first release).
const bestAt = (steps, date) => d3.greatest(steps.filter((s) => s.date <= date), (s) => s.score) ?? null;

// A step-after line (flat, then up) through screen points. Only the turn *into* each climb is
// rounded; the corner at the top of a climb stays sharp, because a release dot sits exactly there.
// The radius shrinks on short segments so two close steps never overlap their curves.
function roundedSteps(pts, r) {
  const v = [{ p: pts[0], sharp: true }];
  for (let i = 1; i < pts.length; i++) v.push({ p: [pts[i][0], pts[i - 1][1]], sharp: false }, { p: pts[i], sharp: true });
  const keep = v.filter((q, i) => i === 0 || q.p[0] !== v[i - 1].p[0] || q.p[1] !== v[i - 1].p[1]); // drop zero-length moves
  let d = `M${keep[0].p}`;
  for (let i = 1; i < keep.length - 1; i++) {
    const [p, c, n] = [keep[i - 1].p, keep[i].p, keep[i + 1].p];
    const a = Math.hypot(c[0] - p[0], c[1] - p[1]), b = Math.hypot(n[0] - c[0], n[1] - c[1]);
    const k = keep[i].sharp ? 0 : Math.min(r, a / 2, b / 2);
    if (!k) { d += `L${c}`; continue; }
    const s = [c[0] + ((p[0] - c[0]) / a) * k, c[1] + ((p[1] - c[1]) / a) * k];
    const e = [c[0] + ((n[0] - c[0]) / b) * k, c[1] + ((n[1] - c[1]) / b) * k];
    d += `L${s}Q${c} ${e}`;
  }
  return d + `L${keep.at(-1).p}`;
}

export function createRace(section, deps) {
  const { catById, benchById, LAB_COLORS, colorOf, keyOf, logoOf, markColor, fmtMonth, UNITS, escapeHtml, placeTip, reducedMotion } = deps;
  const chartEl = section.querySelector(".race-chart");
  const phraseEl = section.querySelector(".phrase");
  const tableEl = section.querySelector(".race-table");
  const tip = section.querySelector(".tooltip");
  let current = null;
  let lastW = 0, lastH = 0;

  function show(cat, { animate = true } = {}) {
    current = cat;
    const category = catById.get(cat);
    const b = benchById.get(category.benchmarks[0]); // the category's headline view (ECI, or its Overall)
    const unit = UNITS[b.unit];
    phraseEl.textContent = category.phrase;
    document.querySelectorAll("[data-race-phrase]").forEach((n) => { n.textContent = category.phrase; });
    const motion = animate && !reducedMotion.matches;

    // ── Data ──
    const models = b.models.filter((m) => m.released && m.score != null)
      .map((m) => ({ ...m, date: new Date(m.released + "T00:00:00Z"), key: keyOf(m.lab) }));
    const end = new Date(d3.max([b.latest_release, ...models.map((m) => m.released)]) + "T00:00:00Z");
    const lines = [...LAB_COLORS.keys()]
      .map((lab) => ({ lab, steps: companyFrontier(models.filter((m) => m.lab === lab)) }))
      .filter((l) => l.steps.length)
      .map((l) => ({ ...l, best: l.steps.at(-1) }));
    const stepSet = new Set(lines.flatMap((l) => l.steps));
    const leader = d3.greatest(lines, (l) => l.best.score)?.lab;
    // The frontier: the best any of these companies had reached, used for the soft fill.
    const frontier = companyFrontier([...stepSet]);

    // ── Layout ──
    const W = chartEl.clientWidth, H = chartEl.clientHeight;
    lastW = W; lastH = H; // so the resize observer doesn't redraw (and cut the wipe) for this size
    const narrow = W < 600;
    const M = { top: 14, right: narrow ? 70 : 164, bottom: 30, left: 44 };
    const iw = Math.max(10, W - M.left - M.right), ih = Math.max(10, H - M.top - M.bottom);
    const x = d3.scaleUtc().domain([d3.min(models, (m) => m.date), end]).range([0, iw]);
    // The y-axis starts where the race is, not at the weakest model ever released: its floor is the
    // 10th percentile of the company steps (rounded down to a tick), so a few early outliers enter
    // from below instead of squashing the contest into the top corner. The top sits just above the
    // best score, so the leader isn't left floating under an empty band.
    const top = d3.max(models, (m) => m.score);
    const floor = d3.quantile([...stepSet].map((m) => m.score).sort(d3.ascending), 0.1);
    const lo = d3.scaleLinear().domain([floor, top]).nice(5).domain()[0];
    const y = d3.scaleLinear().domain([lo, top + (top - lo) * 0.04]).range([ih, 0]);
    const pt = (d, s) => [x(d), y(s)];

    chartEl.querySelectorAll("svg, .race-labels, .race-when").forEach((n) => n.remove());
    const svg = d3.select(chartEl).append("svg").attr("width", W).attr("height", H).attr("aria-hidden", "true");
    const defs = svg.append("defs");
    const g = svg.append("g").attr("transform", `translate(${M.left},${M.top})`);

    // ── Grid: score lines, faint year lines, ticks ──
    const yTicks = y.ticks(5).filter((t) => t >= lo);
    g.append("g").attr("class", "race-grid").selectAll("line").data(yTicks).join("line")
      .attr("x1", 0).attr("x2", iw).attr("y1", y).attr("y2", y);
    g.append("g").attr("class", "race-ytick").selectAll("text").data(yTicks).join("text")
      .attr("x", -10).attr("y", y).attr("dy", "0.32em").attr("text-anchor", "end").text(unit.tick);
    // Year ticks; a short range (Writing, Agents) gets half-years instead, so it never shows a lone label.
    let xTicks = d3.utcYear.range(d3.utcYear.ceil(x.domain()[0]), end), xFmt = d3.utcFormat("%Y");
    if (xTicks.length < 3) { xTicks = d3.utcMonth.every(6).range(x.domain()[0], end); xFmt = d3.utcFormat("%b %Y"); }
    xTicks = xTicks.filter((d) => x(d) > 24 && x(d) < iw - 24);
    g.append("g").attr("class", "race-vgrid").selectAll("line").data(xTicks).join("line")
      .attr("x1", x).attr("x2", x).attr("y1", 0).attr("y2", ih);
    const xLabels = g.append("g").attr("class", "race-xtick");
    xLabels.selectAll("text").data(xTicks).join("text")
      .attr("x", x).attr("y", ih + 20).attr("text-anchor", "middle").text(xFmt);
    g.append("line").attr("class", "race-baseline").attr("x1", 0).attr("x2", iw).attr("y1", ih).attr("y2", ih);
    g.append("text").attr("class", "race-caption").attr("x", 0).attr("y", -4).text(unit.caption);

    // Everything data-driven is clipped to the plot, so outliers below the floor don't spill out.
    defs.append("clipPath").attr("id", `race-plot-${cat}`).append("rect").attr("x", -6).attr("y", -8).attr("width", iw + 14).attr("height", ih + 8);
    const plot = g.append("g").attr("clip-path", `url(#race-plot-${cat})`);

    // ── Soft fill under the frontier: gives the climb a shape without adding a series ──
    const grad = defs.append("linearGradient").attr("id", `race-fill-${cat}`).attr("x1", 0).attr("x2", 0).attr("y1", 0).attr("y2", 1);
    grad.append("stop").attr("offset", "0%").attr("class", "race-fill-top");
    grad.append("stop").attr("offset", "100%").attr("class", "race-fill-foot");
    const fillPts = [...frontier.map((s) => pt(s.date, s.score)), pt(end, frontier.at(-1).score)];
    const reveal = plot.append("g"); // the wipe reveals fill, lines and caps together
    reveal.append("path").attr("class", "race-fill").attr("fill", `url(#race-fill-${cat})`)
      .attr("d", `${roundedSteps(fillPts, CORNER)}L${iw},${ih}L${fillPts[0][0]},${ih}Z`);

    // ── Every release, faint; "Other" companies first so the brand colours sit on top ──
    const dots = plot.insert("g", () => reveal.node()).attr("class", "race-dots");
    dots.selectAll("circle").data(d3.sort(models, (m) => (LAB_COLORS.has(m.lab) ? 1 : 0))).join("circle")
      .attr("class", (m) => `dot${m.open_weights === true ? " open" : ""}`)
      .attr("data-key", (m) => m.key)
      .attr("cx", (m) => x(m.date)).attr("cy", (m) => y(m.score)).attr("r", 2.5)
      .style("--c", (m) => colorOf(m.lab));

    // ── Company lines: rounded steps; the leader's is heavier. Followed lines draw on top. ──
    const order = d3.sort(lines, (l) => (l.lab === leader ? 1 : 0)); // leader last = on top
    reveal.append("g").attr("class", "race-lines").selectAll("path").data(order).join("path")
      .attr("class", (l) => (l.lab === leader ? "leader" : null))
      .attr("data-key", (l) => l.lab)
      .attr("d", (l) => roundedSteps([...l.steps.map((s) => pt(s.date, s.score)), pt(end, l.best.score)], CORNER))
      .style("--c", (l) => colorOf(l.lab));
    // Step dots: every release that set a new company best, so each climb starts from a visible model.
    reveal.append("g").selectAll("circle").data([...stepSet]).join("circle")
      .attr("class", (m) => `step-dot${m.open_weights === true ? " open" : ""}`)
      .attr("data-key", (m) => m.key)
      .attr("cx", (m) => x(m.date)).attr("cy", (m) => y(m.score)).attr("r", (m) => (m.lab === leader ? 3.5 : 3))
      .style("--c", (m) => colorOf(m.lab));
    // End caps at "now", where each line meets its label.
    reveal.append("g").selectAll("circle").data(order).join("circle")
      .attr("class", "race-cap").attr("data-key", (l) => l.lab)
      .attr("cx", iw).attr("cy", (l) => y(l.best.score)).attr("r", 4)
      .style("--c", (l) => colorOf(l.lab));

    // ── End labels: logo, company, best score. Nudged apart so they never overlap. ──
    // Spread label positions so none are closer than LABEL_GAP, keeping them inside the plot.
    const dodge = (items) => {
      const ys = d3.sort(items, (d) => d.want);
      ys.forEach((d, i) => { d.y = i ? Math.max(d.want, ys[i - 1].y + LABEL_GAP) : d.want; });
      const over = ys.length ? ys.at(-1).y - (ih + 6) : 0;   // pushed past the foot? shift the stack up
      if (over > 0) for (let i = ys.length - 1; i >= 0; i--) {
        ys[i].y -= over;
        if (i > 0) ys[i - 1].y = Math.min(ys[i - 1].y, ys[i].y - LABEL_GAP);
      }
      return items;
    };
    const labels = dodge(lines.map((l) => ({ ...l, at: y(l.best.score), want: y(l.best.score) })));
    // A short connector from each cap to its label, visible only where a label was nudged.
    g.append("g").attr("class", "race-ticks").selectAll("path").data(labels).join("path")
      .attr("data-key", (l) => l.lab)
      .attr("d", (l) => `M${iw + 5},${l.at}C${iw + 9},${l.at} ${iw + 7},${l.y} ${iw + 11},${l.y}`)
      .style("--c", (l) => colorOf(l.lab));
    const labelsEl = d3.select(chartEl).append("div").attr("class", "race-labels")
      .style("left", `${M.left + iw + 14}px`).style("top", `${M.top}px`);
    const labelEls = labelsEl.selectAll("div").data(labels).join("div")
      .attr("class", "race-label")
      .attr("data-key", (l) => l.lab)
      .style("top", (l) => `${l.y}px`)
      .html((l) => `<i class="logo"></i>${narrow ? "" : `<span class="race-name">${escapeHtml(l.lab)}</span>`}<b></b>`)
      .on("pointerenter", (e, l) => focus(l.lab))
      .on("pointerleave", () => focus(null));
    labelEls.select(".logo").style("--logo", (l) => logoOf(l.lab)).style("--mark", (l) => markColor(l.lab));

    // Labels as of a date ("now" by default): each company's best then, in that date's order, with
    // that date's leader in bold. While scrubbing they slide into the standings of the hovered date.
    function labelsAt(date) {
      const vals = new Map(lines.map((l) => [l.lab, bestAt(l.steps, date)]));
      const lead = d3.greatest([...vals], ([, s]) => s?.score ?? -Infinity)?.[0];
      const now = +date === +end;
      const pos = now ? new Map(labels.map((l) => [l.lab, l.y]))
        : new Map(dodge(lines.map((l) => ({ lab: l.lab, want: vals.get(l.lab) ? Math.min(ih, y(vals.get(l.lab).score)) : ih }))).map((d) => [d.lab, d.y]));
      chartEl.classList.toggle("scrubbing", !now);
      labelEls.style("top", (l) => `${pos.get(l.lab)}px`)
        .classed("leader", (l) => l.lab === lead && !!vals.get(l.lab))
        .classed("absent", (l) => !vals.get(l.lab))
        .select("b").text((l) => (vals.get(l.lab) ? unit.fmt(vals.get(l.lab).score) : "–"));
    }
    labelsAt(end);

    if (motion) {
      const wipe = defs.append("clipPath").attr("id", `race-wipe-${cat}`).append("rect")
        .attr("x", -8).attr("y", -8).attr("height", ih + 16).attr("width", 0);
      reveal.attr("clip-path", `url(#race-wipe-${cat})`);
      wipe.transition().duration(WIPE_MS).ease(d3.easeCubicInOut).attr("width", iw + 16)
        .on("end", () => reveal.attr("clip-path", null));
      dots.style("opacity", 0).transition().duration(WIPE_MS * 0.6).style("opacity", 1);
      labelsEl.style("opacity", 0).transition().delay(WIPE_MS * 0.7).duration(300).style("opacity", 1);
    }

    // ── Hover: scrub through time. A vertical guide follows the pointer, each line gets a marker at
    // that date and the labels show the standings then. Right on a release dot, that model's tooltip.
    const scrub = g.append("g").attr("class", "race-scrub").style("display", "none"); // display, not visibility: a child set "visible" would override a hidden parent
    const guide = scrub.append("line").attr("y1", 0).attr("y2", ih);
    const marks = scrub.selectAll("circle").data(lines).join("circle").attr("r", 3.5).attr("data-key", (l) => l.lab).style("--c", (l) => colorOf(l.lab));
    const when = d3.select(chartEl).append("div").attr("class", "race-when").attr("hidden", "");
    const ring = g.append("circle").attr("class", "race-ring").attr("r", 6.5).attr("visibility", "hidden");
    const visible = models.filter((m) => y(m.score) <= ih); // dots below the floor can't be hovered
    const delaunay = d3.Delaunay.from(visible, (m) => x(m.date), (m) => y(m.score));

    svg.append("rect").attr("class", "race-hit").attr("x", M.left).attr("y", M.top).attr("width", iw).attr("height", ih)
      .on("pointermove", (event) => {
        const [px, py] = d3.pointer(event, g.node());
        const m = visible[delaunay.find(px, py)];
        const onDot = m && Math.hypot(x(m.date) - px, y(m.score) - py) <= DOT_PX;
        const date = onDot ? m.date : x.invert(Math.max(0, Math.min(iw, px)));
        const gx = x(date);

        // the guide, the date chip and a marker on every line that existed by then
        scrub.style("display", null);
        guide.attr("x1", gx).attr("x2", gx);
        marks.attr("visibility", (l) => { const s = bestAt(l.steps, date); return s && y(s.score) <= ih ? "visible" : "hidden"; })
          .attr("cx", gx).attr("cy", (l) => y(bestAt(l.steps, date)?.score ?? lo));
        when.attr("hidden", null).style("left", `${M.left + gx}px`).style("top", `${M.top + ih + 8}px`).text(fmtMonth(date.toISOString().slice(0, 10)));
        xLabels.attr("opacity", 0);
        labelsAt(date);

        if (!onDot) { ring.attr("visibility", "hidden"); tip.hidden = true; focus(null); return; }
        ring.attr("cx", x(m.date)).attr("cy", y(m.score)).style("--c", colorOf(m.lab)).attr("visibility", "visible");
        focus(LAB_COLORS.has(m.lab) ? m.lab : null);
        tip.innerHTML = `
          <p class="tt-name">${escapeHtml(m.name)}</p>
          <p class="tt-meta">${[m.lab, fmtMonth(m.released), m.open_weights === true ? "Open weights" : m.open_weights === false ? "Closed" : ""].filter(Boolean).map(escapeHtml).join(" · ")}</p>
          <dl><dt>${b.kind === "composite" ? `${escapeHtml(category.label)} overall` : escapeHtml(b.name)}</dt><dd>${unit.fmt(m.score)}</dd>
          ${stepSet.has(m) ? `<dt>New best for</dt><dd>${escapeHtml(m.lab)}</dd>` : ""}</dl>`;
        placeTip(tip, section, event);
      })
      .on("pointerleave", () => {
        scrub.style("display", "none"); ring.attr("visibility", "hidden");
        when.attr("hidden", ""); xLabels.attr("opacity", 1);
        tip.hidden = true; focus(null); labelsAt(end);
      });

    // Screen readers get the steps as a table: when each company set a new best.
    tableEl.innerHTML = `<caption>Best ${escapeHtml(category.phrase)} over time: each release that set a new best for its company</caption>
      <thead><tr><th>Released</th><th>Company</th><th>Model</th><th>${escapeHtml(unit.caption)}</th></tr></thead>
      <tbody>${d3.sort([...stepSet], (m) => m.released).map((m) =>
        `<tr><td>${fmtMonth(m.released)}</td><td>${escapeHtml(m.lab)}</td><td>${escapeHtml(m.name)}</td><td>${unit.fmt(m.score)}</td></tr>`).join("")}</tbody>`;
  }

  // Highlight one company: everything carrying another company's key dims, and its step dots show (CSS).
  function focus(lab) {
    chartEl.classList.toggle("has-focus", !!lab);
    chartEl.querySelectorAll("[data-key]").forEach((n) => n.classList.toggle("on", n.dataset.key === lab));
  }

  // Redraw at the new size, without replaying the wipe.
  new ResizeObserver(() => {
    const { clientWidth: w, clientHeight: h } = chartEl;
    if (current && (w !== lastW || h !== lastH)) show(current, { animate: false });
  }).observe(chartEl);

  return { show };
}
