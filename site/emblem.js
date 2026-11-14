// Category emblem: ~3,000 dots that form one 3D shape per category and flow
// from shape to shape when the category changes. Pure decoration: app.js loads
// this module after the chart, and the page works the same if it never loads.

import * as THREE from "https://cdn.jsdelivr.net/npm/three@0.169.0/build/three.module.min.js";

const N = 3000;            // dots
const MORPH_MS = 1400;     // one dot's travel time
const MAX_DELAY_MS = 350;  // dots set off at slightly different times, so the change flows
const SWIRL = 0.18;        // sideways drift at mid-flight, so dots pour rather than slide
const CAMERA_Z = 3.6;

// ── Shapes ────────────────────────────────────────────────────
// Each generator returns N points as a flat [x, y, z, ...] array. A seeded random
// keeps every shape identical on every visit.
function seeded(seed) {
  return () => {
    seed |= 0; seed = (seed + 0x6D2B79F5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
const inBall = (rand, r) => { // random point inside a ball of radius r
  for (;;) {
    const x = rand() * 2 - 1, y = rand() * 2 - 1, z = rand() * 2 - 1;
    if (x * x + y * y + z * z <= 1) return [x * r, y * r, z * r];
  }
};
// Points spread evenly along a polyline (by length), thickened into a tube.
function alongPath(rand, pts, n, thickness) {
  const segs = [];
  let total = 0;
  for (let i = 0; i < pts.length - 1; i++) {
    const len = Math.hypot(...pts[i + 1].map((v, k) => v - pts[i][k]));
    segs.push({ a: pts[i], b: pts[i + 1], len }); total += len;
  }
  const out = [];
  for (let j = 0; j < n; j++) {
    let d = rand() * total, s = segs[0];
    for (s of segs) { if (d <= s.len) break; d -= s.len; }
    const t = Math.min(1, d / s.len), o = inBall(rand, thickness);
    out.push(s.a.map((v, k) => v + (s.b[k] - v) * t + o[k]));
  }
  return out;
}

const SHAPES = {
  overall(rand) { // globe: evenly spaced dots on a sphere (Fibonacci lattice)
    const golden = Math.PI * (3 - Math.sqrt(5));
    return Array.from({ length: N }, (_, i) => {
      const y = 1 - (2 * (i + 0.5)) / N, r = Math.sqrt(1 - y * y), a = i * golden;
      return [Math.cos(a) * r, y, Math.sin(a) * r];
    });
  },
  coding(rand) { // </>
    const n = Math.floor(N / 3), z = (p) => p.map(([x, y]) => [x, y, 0]);
    return [
      ...alongPath(rand, z([[-0.35, 0.5], [-0.95, 0], [-0.35, -0.5]]), n, 0.09),
      ...alongPath(rand, z([[0.2, 0.7], [-0.2, -0.7]]), n, 0.09),
      ...alongPath(rand, z([[0.35, 0.5], [0.95, 0], [0.35, -0.5]]), N - 2 * n, 0.09),
    ];
  },
  writing(rand) { // a gently bent page: its outline, plus lines of "text" in two paragraphs
    const bend = (x, y) => [x, y, 0.22 * Math.cos(x * 1.6) - 0.1];
    const W = 0.72, H = 1;
    const outline = alongPath(rand, [[-W, H], [W, H], [W, -H], [-W, -H], [-W, H]].map(([x, y]) => [x, y, 0]), 700, 0.012)
      .map(([x, y, z]) => { const [bx, by, bz] = bend(x, y); return [bx, by, bz + z]; });
    // Ragged line lengths, and a short last line closing each paragraph, read as prose.
    const lines = [0.92, 0.85, 0.95, 0.88, 0.45, null, 0.9, 0.82, 0.94, 0.6];
    const rows = lines.map((len, i) => len && { y: 0.78 - i * 0.165, len }).filter(Boolean);
    const per = Math.floor((N - outline.length) / rows.length);
    const text = rows.flatMap(({ y, len }) => Array.from({ length: per }, () => {
      const x = -W + 0.14 + rand() * (2 * W - 0.28) * len;
      const [bx, by, bz] = bend(x, y + (rand() - 0.5) * 0.05);
      return [bx, by, bz];
    }));
    while (outline.length + text.length < N) text.push(bend(-W + 0.14, rows[0].y));
    return [...outline, ...text];
  },
  maths(rand) { // torus knot (2, 3)
    const pts = Array.from({ length: 400 }, (_, i) => {
      const t = (i / 399) * Math.PI * 2, r = Math.cos(3 * t) + 2.2;
      return [r * Math.cos(2 * t) / 3.2, r * Math.sin(2 * t) / 3.2, -Math.sin(3 * t) / 3.2];
    });
    return alongPath(rand, pts, N, 0.1);
  },
  science(rand) { // atom: a nucleus and three tilted electron orbits
    const nucleus = Array.from({ length: 600 }, () => inBall(rand, 0.2));
    const rings = [0, Math.PI / 3, (2 * Math.PI) / 3].flatMap((spin) => {
      const ring = Array.from({ length: 160 }, (_, i) => {
        const t = (i / 159) * Math.PI * 2, x = Math.cos(t), y = Math.sin(t) * 0.36;
        return [x * Math.cos(spin) - y * Math.sin(spin), x * Math.sin(spin) + y * Math.cos(spin), Math.sin(t) * 0.25];
      });
      return alongPath(rand, ring, (N - 600) / 3, 0.025);
    });
    return [...nucleus, ...rings];
  },
  reasoning(rand) { // puzzle cube: the outlines of its 54 outer squares, with gaps, like stickers
    const squares = [];
    for (let axis = 0; axis < 3; axis++) for (const sign of [-1, 1]) for (const a of [-1, 0, 1]) for (const b of [-1, 0, 1]) {
      const [u, v] = [0, 1, 2].filter((k) => k !== axis);
      const corner = (du, dv) => { const p = [0, 0, 0]; p[axis] = sign * 0.6; p[u] = a * 0.4 + du * 0.17; p[v] = b * 0.4 + dv * 0.17; return p; };
      squares.push([corner(-1, -1), corner(1, -1), corner(1, 1), corner(-1, 1), corner(-1, -1)]);
    }
    const per = Math.floor(N / squares.length);
    const pts = squares.flatMap((sq) => alongPath(rand, sq, per, 0.012));
    while (pts.length < N) pts.push(alongPath(rand, squares[0], 1, 0.012)[0]);
    // Rest it corner-on (tilted on two axes) so three faces show, the classic puzzle-cube view.
    const [ax, ay] = [0.55, 0.7], [cx, sx, cy, sy] = [Math.cos(ax), Math.sin(ax), Math.cos(ay), Math.sin(ay)];
    return pts.map(([x, y, z]) => { const y1 = y * cx - z * sx, z1 = y * sx + z * cx; return [x * cy + z1 * sy, y1, -x * sy + z1 * cy]; });
  },
  agents(rand) { // network: evenly spread nodes, each joined to its three nearest neighbours
    const golden = Math.PI * (3 - Math.sqrt(5)), outer = 14;
    const nodes = [
      ...Array.from({ length: outer }, (_, i) => { // even spread over a sphere (Fibonacci lattice)
        const y = 1 - (2 * (i + 0.5)) / outer, r = Math.sqrt(1 - y * y), a = i * golden;
        return [Math.cos(a) * r * 0.9, y * 0.9, Math.sin(a) * r * 0.9];
      }),
      [0, 0, 0], [0.32, 0.2, -0.15], [-0.3, -0.22, 0.18], [0.05, -0.35, -0.3], // a few inner nodes
    ];
    const dist = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1], a[2] - b[2]);
    const edges = new Set();
    nodes.forEach((a, i) => nodes.map((b, j) => [dist(a, b), j]).sort((p, q) => p[0] - q[0])
      .slice(1, 4).forEach(([, j]) => edges.add(i < j ? `${i}-${j}` : `${j}-${i}`)));
    const hubs = nodes.flatMap((c) => Array.from({ length: 45 }, () => inBall(rand, 0.07).map((v, k) => v + c[k])));
    const perEdge = Math.floor((N - hubs.length) / edges.size);
    const lines = [...edges].flatMap((e) => { const [i, j] = e.split("-").map(Number); return alongPath(rand, [nodes[i], nodes[j]], perEdge, 0.012); });
    while (hubs.length + lines.length < N) lines.push(inBall(rand, 0.06).map((v, k) => v + nodes[0][k]));
    return [...hubs, ...lines];
  },
  "life-sciences"(rand) { // DNA: two strands winding round each other, joined by base-pair rungs
    const turns = 1.6, H = 2, R = 0.5, rungs = 14;
    const at = (t, phase) => { const a = t * turns * 2 * Math.PI + phase; return [R * Math.cos(a), H * (t - 0.5), R * Math.sin(a)]; };
    const strand = (phase) => alongPath(rand, Array.from({ length: 240 }, (_, i) => at(i / 239, phase)), 1000, 0.035);
    const per = Math.floor((N - 2000) / rungs);
    const bars = Array.from({ length: rungs }, (_, k) => { const t = (k + 0.5) / rungs; return alongPath(rand, [at(t, 0), at(t, Math.PI)], per, 0.014); }).flat();
    const pts = [...strand(0), ...strand(Math.PI), ...bars];
    while (pts.length < N) pts.push(at(rand(), 0));
    // Lean it a little, so it reads as a helix rather than a column.
    const [c, s] = [Math.cos(0.35), Math.sin(0.35)];
    return pts.map(([x, y, z]) => [x * c - y * s, x * s + y * c, z]);
  },
  cyber(rand) { // padlock: a shackle over a deep body, with a keyhole on the front
    const W = 0.62, D = 0.2, top = -0.1, bottom = -0.95;
    const arc = Array.from({ length: 61 }, (_, i) => { const t = (Math.PI * i) / 60; return [0.4 * Math.cos(t), 0.2 + 0.4 * Math.sin(t), 0]; });
    const shackle = alongPath(rand, [[0.4, top, 0], ...arc, [-0.4, top, 0]], 800, 0.05);
    const face = (z) => [[-W, top, z], [W, top, z], [W, bottom, z], [-W, bottom, z], [-W, top, z]];
    const body = [
      ...alongPath(rand, face(D), 650, 0.014),
      ...alongPath(rand, face(-D), 650, 0.014),
      ...[[-W, top], [W, top], [W, bottom], [-W, bottom]].flatMap(([x, y]) => alongPath(rand, [[x, y, D], [x, y, -D]], 60, 0.014)),
    ];
    const ring = Array.from({ length: 41 }, (_, i) => { const t = (2 * Math.PI * i) / 40; return [0.09 * Math.cos(t), -0.45 + 0.09 * Math.sin(t), D]; });
    const keyhole = [...alongPath(rand, ring, 330, 0.012), ...alongPath(rand, [[0, -0.54, D], [0, -0.74, D]], 200, 0.02)];
    const pts = [...shackle, ...body, ...keyhole];
    while (pts.length < N) pts.push(alongPath(rand, ring, 1, 0.012)[0]);
    return pts;
  },
};

// Centre each shape, scale it to fit a unit sphere, and sort its dots from bottom
// to top. Matching dots by height keeps the flow orderly: a dot near the top of
// one shape travels to the top of the next instead of crossing the whole figure.
function build(id) {
  const pts = SHAPES[id](seeded(id.length * 7919 + id.charCodeAt(0))).slice(0, N);
  const c = [0, 1, 2].map((k) => pts.reduce((s, p) => s + p[k], 0) / pts.length);
  const centred = pts.map((p) => p.map((v, k) => v - c[k]));
  const r = Math.max(...centred.map((p) => Math.hypot(...p)));
  centred.sort((a, b) => a[1] - b[1]);
  return Float32Array.from(centred.flatMap((p) => p.map((v) => v / r)));
}

// ── Scene ─────────────────────────────────────────────────────
export function createEmblem(canvas) {
  const reduced = matchMedia("(prefers-reduced-motion: reduce)");
  const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
  renderer.setPixelRatio(Math.min(devicePixelRatio, 2)); // cap the work on high-density screens
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(35, 1, 0.1, 20);
  camera.position.z = CAMERA_Z;

  const shapes = {};
  const shape = (id) => (shapes[id] ??= build(SHAPES[id] ? id : "overall"));

  // Start as a loose cloud, so the first shape assembles itself on arrival.
  const rand = seeded(42);
  const positions = Float32Array.from({ length: N * 3 }, () => (rand() * 2 - 1) * 1.6);
  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute("position", new THREE.BufferAttribute(positions, 3));

  // Per-dot constants: a start delay and a sideways direction for the mid-flight swirl.
  const delay = Float32Array.from({ length: N }, () => rand() * MAX_DELAY_MS);
  const drift = Float32Array.from({ length: N * 3 }, () => rand() * 2 - 1);

  // Round dots; the back of the shape fades, which reads as depth without lighting.
  const material = new THREE.ShaderMaterial({
    transparent: true, depthWrite: false,
    uniforms: { uColor: { value: new THREE.Color() }, uOpacity: { value: 1 }, uSize: { value: 2.4 * renderer.getPixelRatio() } },
    vertexShader: `
      uniform float uSize; varying float vDepth;
      void main() {
        vec4 mv = modelViewMatrix * vec4(position, 1.0);
        gl_Position = projectionMatrix * mv;
        gl_PointSize = uSize * (${CAMERA_Z.toFixed(1)} / -mv.z);
        vDepth = clamp((-mv.z - ${(CAMERA_Z - 1).toFixed(1)}) / 2.0, 0.0, 1.0);
      }`,
    fragmentShader: `
      uniform vec3 uColor; uniform float uOpacity; varying float vDepth;
      void main() {
        vec2 c = gl_PointCoord - 0.5;
        if (dot(c, c) > 0.25) discard;
        gl_FragColor = vec4(uColor, uOpacity * mix(0.95, 0.18, vDepth));
      }`,
  });
  const tilt = new THREE.Group();   // leans toward the cursor
  const spin = new THREE.Points(geometry, material); // sways side to side
  tilt.add(spin); scene.add(tilt);

  // Dot colour follows the theme's ink (light: near-black, dark: near-white).
  const paint = () => material.uniforms.uColor.value.set(getComputedStyle(document.documentElement).getPropertyValue("--ink").trim() || "#161513");
  paint();
  new MutationObserver(paint).observe(document.documentElement, { attributes: true, attributeFilter: ["data-theme"] });
  matchMedia("(prefers-color-scheme: dark)").addEventListener("change", paint);

  // Cursor tilt: the pointer's place on the page sets a small target lean; the shape eases toward it.
  const lean = { x: 0, y: 0, tx: 0, ty: 0 };
  addEventListener("pointermove", (e) => {
    lean.tx = (e.clientY / innerHeight - 0.5) * 0.5;
    lean.ty = (e.clientX / innerWidth - 0.5) * 0.5;
  }, { passive: true });

  // ── Morph ───────────────────────────────────────────────────
  let current = null, morph = null, fade = null;
  function show(id) {
    if (id === current) return;
    current = id;
    const to = shape(id);
    if (reduced.matches) { // no travelling dots: a quick fade between shapes
      fade = { start: performance.now(), to };
      wake(); return;
    }
    // Start from wherever the dots are right now, so a mid-morph switch stays smooth.
    morph = { start: performance.now(), from: positions.slice(), to };
    wake();
  }

  const ease = (t) => (t < 0.5 ? 4 * t * t * t : 1 - (-2 * t + 2) ** 3 / 2);
  function step(now) {
    if (!morph) return;
    let done = true;
    for (let i = 0; i < N; i++) {
      const t = Math.min(1, Math.max(0, (now - morph.start - delay[i]) / MORPH_MS));
      if (t < 1) done = false;
      const e = ease(t), s = Math.sin(Math.PI * e) * SWIRL;
      for (let k = 0; k < 3; k++) {
        const j = i * 3 + k;
        positions[j] = morph.from[j] + (morph.to[j] - morph.from[j]) * e + drift[j] * s;
      }
    }
    geometry.attributes.position.needsUpdate = true;
    if (done) morph = null;
  }
  function stepFade(now) {
    if (!fade) return;
    const t = (now - fade.start) / 300; // 150 ms out, swap, 150 ms in
    if (t >= 0.5 && fade.to) { positions.set(fade.to); geometry.attributes.position.needsUpdate = true; fade.to = null; }
    material.uniforms.uOpacity.value = Math.abs(1 - 2 * Math.min(t, 1));
    if (t >= 1) { material.uniforms.uOpacity.value = 1; fade = null; }
  }

  // ── Loop: draws only while visible and on screen ────────────
  let last = performance.now(), onScreen = true, clock = 0;
  function frame(now) {
    const dt = Math.min(0.05, (now - last) / 1000); last = now;
    if (!reduced.matches) {
      // A sway (±35°), not a full spin: flat emblems like </> and the page would vanish edge-on.
      clock += dt;
      spin.rotation.y = Math.sin(clock * 0.45) * 0.6;
      lean.x += (lean.tx - lean.x) * Math.min(1, dt * 2.5);
      lean.y += (lean.ty - lean.y) * Math.min(1, dt * 2.5);
      tilt.rotation.set(lean.x, lean.y, 0);
    }
    step(now); stepFade(now);
    renderer.render(scene, camera);
    canvas.classList.add("ready");
    // With motion reduced, stop drawing once nothing is changing.
    if (reduced.matches && !morph && !fade) renderer.setAnimationLoop(null);
  }
  function wake() {
    if (!document.hidden && onScreen) { last = performance.now(); renderer.setAnimationLoop(frame); }
  }
  const sleep = () => renderer.setAnimationLoop(null);
  document.addEventListener("visibilitychange", () => (document.hidden ? sleep() : wake()));
  new IntersectionObserver(([e]) => { onScreen = e.isIntersecting; onScreen ? wake() : sleep(); }).observe(canvas);

  new ResizeObserver(() => {
    const { width, height } = canvas.getBoundingClientRect();
    if (!width || !height) return;
    renderer.setSize(width, height, false);
    camera.aspect = width / height; camera.updateProjectionMatrix();
    if (reduced.matches) wake(); // redraw once at the new size
  }).observe(canvas);

  return { show };
}
