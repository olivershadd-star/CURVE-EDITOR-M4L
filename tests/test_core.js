// Compare le noyau JavaScript au code C++ de Curve Mini 0.6 (tests/golden.json, genere par tools/golden_gen.cpp).
// Usage : node tests/test_core.js
"use strict";
const path = require("path");
const assert = require("assert");
const core = require(path.join(__dirname, "..", "src", "core.js"));
const golden = require("./golden.json");

const TOL = 5e-5;
let ok = 0;
function near(a, b, what) {
    assert.ok(Math.abs(a - b) <= TOL, what + " : " + a + " different de " + b);
}
function sampled(d) {
    const out = [];
    for (let n = 0; n <= core.RES; n += 64) out.push(d.y[n]);
    return out;
}
function sameSamples(d, ref, what) {
    const s = sampled(d);
    assert.strictEqual(s.length, ref.length, what + " : nombre d'echantillons");
    s.forEach((v, i) => near(v, ref[i], what + " echantillon " + i));
}
function asPoints(list) { return list.map((p) => core.makePoint(p[0], p[1], p[2], p[3])); }
function samePoints(got, ref, what) {
    assert.strictEqual(got.length, ref.length, what + " : nombre de points " + got.length + " / " + ref.length);
    got.forEach((p, i) => {
        near(p.x, ref[i][0], what + " x" + i); near(p.y, ref[i][1], what + " y" + i);
        near(p.tension, ref[i][2], what + " tension" + i); assert.strictEqual(p.shape, ref[i][3], what + " forme" + i);
    });
}
function noisy() {
    const d = core.newData(4);
    for (let n = 0; n <= core.RES; n++) d.y[n] = core.clamp01(0.5 + 0.4 * Math.sin(n * 0.05) + 0.3 * Math.sin(n * 0.77));
    return d;
}
function expectError(fn, message, what) {
    let thrown = null;
    try { fn(); } catch (e) { thrown = e; }
    assert.ok(thrown, what + " : une erreur etait attendue (« " + message + " »)");
    assert.strictEqual(thrown.message, message, what);
}

for (const g of golden) {
    const label = g.kind + (g.input !== undefined ? " « " + JSON.stringify(g.input).slice(0, 50) + " »" : "");
    switch (g.kind) {
        case "script":
            if (g.ok) { const d = core.parseScript(g.input); near(d.bars, g.bars, label + " duree"); sameSamples(d, g.samples, label); }
            else expectError(() => core.parseScript(g.input), g.error, label);
            break;
        case "motion":
            if (g.ok) {
                const r = core.translateMotion(g.input, g.bars, g.initial);
                assert.strictEqual(r.script, g.script, label + " script");
                assert.strictEqual(r.explanation, g.explanation, label + " explication");
                sameSamples(r.data, g.samples, label);
            } else expectError(() => core.translateMotion(g.input, g.bars, g.initial), g.error, label);
            break;
        case "preset": sameSamples(core.preset(g.shape, 4), g.samples, label + " " + g.shape); break;
        case "vary": sameSamples(core.vary(core.preset(0, 4), g.depth, g.seed), g.samples, label + " graine " + g.seed + " profondeur " + g.depth); break;
        case "smooth": sameSamples(core.smoothDrawing(noisy(), g.strength), g.samples, label + " " + g.strength); break;
        case "simplify": {
            // le C++ stocke la courbe en float 32 bits : on arrondit pareillement, sinon les egalites
            // (courbe symetrique) peuvent departager autrement les points a garder
            const src = g.source === "noisy" ? noisy() : core.preset(g.source === "preset5" ? 5 : 0, 4);
            src.y = src.y.map(Math.fround);
            samePoints(core.simplify(src, g.tolerance), g.points, label + " " + g.source);
            break;
        }
        case "points": {
            const pts = asPoints(g.points);
            samePoints(core.canonicalPoints(pts), g.canonical, "canonique");
            sameSamples(core.fromPoints(pts, 4), g.samples, "fromPoints " + JSON.stringify(g.points).slice(0, 40));
            break;
        }
        case "canonical": samePoints(core.canonicalPoints(asPoints(g.points)), g.canonical, "canonique brut"); break;
        case "at": {
            const d = core.preset(0, 4);
            g.values.forEach((v) => near(core.curveAt(d, v[0]), v[1], "at(" + v[0] + ")"));
            break;
        }
        case "target": {
            const d = core.preset(0, 4);
            const p = { min: g.min, max: g.max, bars: g.bars, offset: g.offset, depth: g.depth, smooth: 20, value: 64 };
            g.values.forEach((v) => near(core.laneTarget(d, v[0], v[1], p), v[2], "target(" + v[0] + "," + v[1] + ")"));
            break;
        }
        case "smoothstep": {
            const st = { filtered: 0, valid: false };
            g.values.forEach((v, i) => near(core.laneSmooth(st, 0.8, 0.01, 20, 0.3), v, "lissage pas " + i));
            const st2 = { filtered: 0, valid: false };
            g.instant.forEach((v, i) => near(core.laneSmooth(st2, 0.8, 0.01, 0, 0.3), v, "sans lissage pas " + i));
            break;
        }
        case "cc": g.values.forEach((v) => assert.strictEqual(core.toCC(v[0]), v[1], "toCC(" + v[0] + ")")); break;
        default: assert.fail("cas inconnu " + g.kind);
    }
    ok++;
}
console.log(ok + " cas compares au C++ : tout correspond (tolerance " + TOL + ")");
