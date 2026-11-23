// Tests du moteur curve_lanes.js avec un faux Max / faux Live.
// Usage : node tests/test_curve_lanes.js
"use strict";
const fs = require("fs");
const path = require("path");
const vm = require("vm");
const assert = require("assert");

const sent = [];                       // [valeur, cc, canal]
let pending = {};
const sandbox = {
    console, Math, Number, isFinite, Array, Object,
    outlet(n, v) {
        pending[n] = v;
        if (n === 0) { sent.push([pending[0], pending[1], pending[2]]); pending = {}; }
    },
    arrayfromargs(a) { return Array.prototype.slice.call(a); },
    LiveAPI: function () {},
};
sandbox.module = { exports: {} };
vm.createContext(sandbox);
vm.runInContext(fs.readFileSync(path.join(__dirname, "..", "device", "curve_lanes.js"), "utf8"), sandbox);
const m = sandbox.module.exports;

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }

test("2 lignes par defaut, CC 20 et 21, canal 1", () => {
    assert.strictEqual(m.lanes.length, 2);
    assert.strictEqual(m.lanes[0].cc, 20);
    assert.strictEqual(m.lanes[1].cc, 21);
    assert.strictEqual(m.lanes[0].ch, 1);
});

test("interpolation lineaire entre deux points", () => {
    assert.strictEqual(m.curveAt([0, 1, 0, 1], 0), 0);
    assert.ok(Math.abs(m.curveAt([0, 1, 0, 1], 0.125) - 0.5) < 1e-9);
});

test("la courbe boucle : le dernier point rejoint le premier", () => {
    const pts = [0, 0.5, 1, 0.5];
    assert.ok(Math.abs(m.curveAt(pts, 0.999999) - 0.0) < 1e-3);
    assert.strictEqual(m.curveAt(pts, 1.0), m.curveAt(pts, 0.0));
    assert.strictEqual(m.curveAt(pts, 5.25), m.curveAt(pts, 0.25));
    assert.strictEqual(m.curveAt(pts, -0.75), m.curveAt(pts, 0.25));
});

test("phase non finie : pas de plantage", () => {
    assert.strictEqual(m.curveAt([0.3, 0.4], NaN), 0.3);
    assert.strictEqual(m.curveAt([0.3, 0.4], Infinity), 0.3);
});

test("min / max : valeurs et inversion", () => {
    m.lcurve(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);  // 0 partout
    m.lmin(1, 40); m.lmax(1, 100);
    assert.strictEqual(m.laneValue(m.lanes[1], 0, 4), 40);
    m.lcurve(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);  // 1 partout
    assert.strictEqual(m.laneValue(m.lanes[1], 0, 4), 100);
    m.lmin(1, 100); m.lmax(1, 40);                                 // inversee
    assert.strictEqual(m.laneValue(m.lanes[1], 0, 4), 40);
});

test("valeurs bornees a 0..127 meme avec une entree hors limites", () => {
    m.lmin(1, -50); m.lmax(1, 900);
    const v = m.laneValue(m.lanes[1], 0, 4);
    assert.ok(v >= 0 && v <= 127);
});

test("duree en mesures : 2 mesures = phase moitie moins vite", () => {
    m.lcurve(0, 0, 0.25, 0.5, 0.75, 1, 0.75, 0.5, 0.25, 0, 0.25, 0.5, 0.75, 1, 0.75, 0.5, 0.25);
    m.lmin(0, 0); m.lmax(0, 127); m.lbars(0, 1);
    const a1 = m.laneValue(m.lanes[0], 2, 4);
    m.lbars(0, 2);
    const a2 = m.laneValue(m.lanes[0], 4, 4);
    assert.strictEqual(a1, a2);                    // 2 temps sur 1 mesure = 4 temps sur 2 mesures
});

test("lcurve reechantillonne un nombre de points different", () => {
    m.lcurve(0, 0, 1);                             // 2 points seulement
    assert.strictEqual(m.lanes[0].pts.length, 16);
    assert.strictEqual(m.lanes[0].pts[0], 0);
    assert.strictEqual(m.lanes[0].pts[15], 1);
});

test("lcurve ignore les valeurs invalides et les lignes inexistantes", () => {
    const avant = m.lanes[0].pts.slice();
    m.lcurve(0, "abc", NaN);                       // aucune valeur utilisable
    assert.deepStrictEqual(m.lanes[0].pts, avant);
    m.lcurve(7, 0, 1); m.lcc(-1, 5); m.lon(99, 1); // ne plantent pas
});

test("envoi uniquement quand la valeur change", () => {
    m.lcurve(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);   // plat
    m.lcurve(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    m.lmin(0, 10); m.lmax(0, 10); m.lmin(1, 20); m.lmax(1, 20);
    m.reset(); sent.length = 0;
    m.tickWith(0, 4); m.tickWith(0.1, 4); m.tickWith(0.2, 4);
    assert.strictEqual(sent.length, 2);            // une fois par ligne, puis plus rien
    assert.deepStrictEqual(sent[0], [10, 20, 1]);
    assert.deepStrictEqual(sent[1], [20, 21, 1]);
});

test("ligne coupee : rien n'est envoye, puis renvoi a la reactivation", () => {
    m.reset(); sent.length = 0;
    m.lon(0, 0);
    m.tickWith(0, 4);
    assert.strictEqual(sent.length, 1);            // seule la ligne 2
    m.lon(0, 1);
    m.tickWith(0.1, 4);
    assert.strictEqual(sent.length, 2);            // ligne 1 renvoyee
});

test("changement de CC ou de canal : les nouvelles valeurs sont envoyees", () => {
    m.reset(); sent.length = 0;
    m.lcc(0, 74); m.lch(0, 16);
    m.tickWith(0, 4);
    const l1 = sent.find((s) => s[1] === 74);
    assert.deepStrictEqual(l1, [10, 74, 16]);
});

console.log("\n" + ok + " tests passes");
