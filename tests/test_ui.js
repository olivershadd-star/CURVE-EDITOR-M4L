// Tests de l'editeur de courbe (src/ui.js) avec un faux mgraphics et un faux moteur.
// Usage : node tests/test_ui.js
"use strict";
const assert = require("assert");
const { load } = require("./loader");

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }
const plain = (x) => JSON.parse(JSON.stringify(x));

function setup() {
    const sent = [], calls = { n: 0, text: [] };
    const engine = { message: (...a) => sent.push(a) };
    const mg = { size: [520, 112], relative_coords: 1, autofill: 1, redrawn: 0,
        init() {}, redraw() { this.redrawn++; } };
    ["set_source_rgba", "rectangle", "fill", "move_to", "line_to", "stroke", "set_line_width", "ellipse", "close_path",
        "select_font_face", "set_font_size"].forEach((f) => { mg[f] = () => { calls.n++; }; });
    mg.show_text = (t) => { calls.n++; calls.text.push(t); };
    const U = load(["core.js", "ui.js"], { mgraphics: mg, patcher: { getnamed: (n) => (n === "engine" ? engine : null) } });
    return { U, sent, calls, mg };
}
// pixels <-> coordonnees de la courbe (zone de trace : x 26.., y 10.., largeur 486, hauteur 86)
const px = (x) => 26 + x * 486, py = (y) => 10 + 86 - y * 86;
function pointsView(U, pts, mode) {
    U.view(2, U.encodeCurve(U.fromPoints(pts, 4)), U.encodePoints(pts) || "-", mode ? 1 : 0, 0, 4, 0, "Cutoff", 0);
}

test("initialisation de mgraphics en pixels, sans remplissage automatique", () => {
    const { mg } = setup();
    assert.strictEqual(mg.relative_coords, 0); assert.strictEqual(mg.autofill, 0);
});

test("view puis paint : dessine sans erreur, affiche le nom et la duree", () => {
    const { U, calls } = setup();
    U.view(2, U.encodeCurve(U.preset(0, 4)), "-", 0, 0, 8, 25, encodeURIComponent("Cut off"), 1);
    U.paint();
    assert.ok(calls.n > 50);
    assert.ok(calls.text.some((t) => t.indexOf("3  Cut off") === 0 && t.indexOf("MANUEL") > 0), calls.text.join("|"));
    assert.ok(calls.text.indexOf("8 mesures") >= 0);
    U.playhead(0.5); U.paint();
});

test("view invalide ignore ; view pendant un glisser ignore", () => {
    const { U, calls } = setup();
    U.view(1, "zz", "-", 0, 0, 4, 0, "x", 0);
    assert.strictEqual(U.laneIndex, 0);
    U.view(1, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "x", 0);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0);
    U.view(3, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "y", 0);
    assert.strictEqual(U.laneIndex, 1);
});

test("dessin libre : glisser trace la courbe, le relachement l'envoie au moteur", () => {
    const { U, sent } = setup();
    U.view(4, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "L", 0);
    U.setsnap(0);
    U.onclick(px(0.25), py(0.9), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.5), py(0.9), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.5), py(0.9), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 1);
    assert.strictEqual(sent[0][0], "ui_curve"); assert.strictEqual(sent[0][1], 4);
    const d = U.decodeCurve(sent[0][2], 4);
    assert.ok(Math.abs(d.y[1024] - 0.9) < 0.01, "valeur dessinee " + d.y[1024]);
    assert.ok(Math.abs(d.y[0] - 0) < 0.01, "le reste est inchange");
});

test("trait libre : continu, sans aimantation (seuls les pinceaux et les points s'aimantent)", () => {
    const { U, sent } = setup();
    U.view(0, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "L", 0);
    U.onclick(px(0.26), py(0.51), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.26), py(0.51), 0, 0, 0, 0, 0, 0);
    let d = U.decodeCurve(sent[0][2], 4);
    assert.ok(Math.abs(d.y[Math.round(0.26 * 2048)] - 0.51) < 0.01, "pas d'escalier en trait libre");
    U.onclick(px(0.26), py(0.51), 1, 0, 1, 0, 0, 0);
    U.ondrag(px(0.26), py(0.51), 0, 0, 1, 0, 0, 0);
    d = U.decodeCurve(sent[1][2], 4);
    assert.ok(Math.abs(d.y[Math.round(0.26 * 2048)] - 0.51) < 0.01);
});

test("pinceaux : rampe, triangle, sinus remplissent une case de la grille", () => {
    [1, 2, 3].forEach((b) => {
        const { U, sent } = setup();
        U.view(0, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "L", 0);
        U.setgrid(4); U.setbrush(b); U.setsnap(0);
        U.onclick(px(0.30), py(0.8), 1, 0, 0, 0, 0, 0);
        U.ondrag(px(0.30), py(0.8), 0, 0, 0, 0, 0, 0);
        const d = U.decodeCurve(sent[0][2], 4);
        const cellStart = 512, cellEnd = 1024, mid = 768;
        assert.ok(Math.abs(d.y[cellEnd] - (b === 1 ? 0.8 : b === 2 ? 0 : 0.8 * (0.5 - 0.5 * Math.cos(2 * Math.PI)))) < 0.02, "fin de case, pinceau " + b);
        if (b === 2) assert.ok(Math.abs(d.y[mid] - 0.8) < 0.02);
        if (b === 3) assert.ok(Math.abs(d.y[mid] - 0.8) < 0.02);
        assert.ok(Math.abs(d.y[cellStart] - 0) < 0.02);
    });
});

test("mode points : un clic ajoute un point, glisser le deplace, envoi au relachement", () => {
    const { U, sent } = setup();
    pointsView(U, [U.makePoint(0, 0.2), U.makePoint(1, 0.2)], true);
    U.onclick(px(0.5), py(0.8), 1, 0, 0, 0, 0, 0);          // clic dans le vide : ajoute (aimante a 0.5 / 0.8)
    U.ondrag(px(0.5), py(0.8), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 1);
    assert.strictEqual(sent[0][0], "ui_points");
    let pts = U.decodePoints(sent[0][2]);
    assert.strictEqual(pts.length, 3);
    assert.ok(Math.abs(pts[1].x - 0.5) < 1e-6 && Math.abs(pts[1].y - 0.8125) < 1e-6 || Math.abs(pts[1].y - 0.8) < 0.07);
    U.view(2, U.encodeCurve(U.fromPoints(pts, 4)), sent[0][2], 1, 0, 4, 0, "Cutoff", 0);
    U.onclick(px(0.5), py(pts[1].y), 1, 0, 0, 0, 0, 0);     // saisit le point
    U.ondrag(px(0.25), py(0.5), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.25), py(0.5), 0, 0, 0, 0, 0, 0);
    pts = U.decodePoints(sent[1][2]);
    assert.ok(Math.abs(pts[1].x - 0.25) < 0.001, "x " + pts[1].x);
    assert.ok(Math.abs(pts[1].y - 0.5) < 0.07, "y " + pts[1].y);
});

test("les points d'extremite ne bougent que verticalement ; pas de point hors des voisins", () => {
    const { U, sent } = setup();
    const pts = [U.makePoint(0, 0.2), U.makePoint(0.5, 0.6), U.makePoint(1, 0.2)];
    pointsView(U, pts, true);
    U.onclick(px(0), py(0.2), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.4), py(0.7), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.4), py(0.7), 0, 0, 0, 0, 0, 0);
    let out = U.decodePoints(sent[0][2]);
    assert.strictEqual(out[0].x, 0); assert.ok(out[0].y > 0.6);
    pointsView(U, pts, true);
    U.onclick(px(0.5), py(0.6), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(1.0), py(0.6), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(1.0), py(0.6), 0, 0, 0, 0, 0, 0);
    out = U.decodePoints(sent[1][2]);
    assert.ok(out[1].x < 1 && out[1].x > 0.5, "le point reste avant le suivant : " + out[1].x);
});

test("Alt + clic supprime un point intermediaire, jamais une extremite", () => {
    const { U, sent } = setup();
    pointsView(U, [U.makePoint(0, 0.2), U.makePoint(0.5, 0.6), U.makePoint(1, 0.2)], true);
    U.onclick(px(0.5), py(0.6), 1, 0, 0, 0, 1, 0);
    assert.strictEqual(U.decodePoints(sent[0][2]).length, 2);
    pointsView(U, [U.makePoint(0, 0.2), U.makePoint(0.5, 0.6), U.makePoint(1, 0.2)], true);
    U.onclick(px(0), py(0.2), 1, 0, 0, 0, 1, 0);
    U.ondrag(px(0), py(0.2), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(U.decodePoints(sent[1][2]).length, 3);
});

test("poignee de courbure : glisser regle la courbure, double-clic la remet a zero", () => {
    const { U, sent } = setup();
    const pts = [U.makePoint(0, 0.2), U.makePoint(1, 0.8)];
    pointsView(U, pts, true);
    const curveY = U.fromPoints(pts, 4).y[1024];
    const hx = px(0.5), hy = py(curveY);
    U.onclick(hx, hy, 1, 0, 0, 0, 0, 0);
    U.ondrag(hx, hy - 60, 1, 0, 0, 0, 0, 0);
    U.ondrag(hx, hy - 60, 0, 0, 0, 0, 0, 0);
    let out = U.decodePoints(sent[0][2]);
    assert.ok(Math.abs(out[0].tension - 0.4) < 0.01, "tension " + out[0].tension);
    assert.strictEqual(out.length, 2, "aucun point ajoute");
    const d2 = U.fromPoints(out, 4);
    U.view(2, U.encodeCurve(d2), sent[0][2], 1, 0, 4, 0, "x", 0);
    const hy2 = py(d2.y[1024]);
    U.onclick(hx, hy2, 1, 0, 0, 0, 0, 0); U.ondrag(hx, hy2, 0, 0, 0, 0, 0, 0);
    U.onclick(hx, hy2, 1, 0, 0, 0, 0, 0);
    out = U.decodePoints(sent[sent.length - 1][2]);
    assert.strictEqual(out[0].tension, 0);
});

test("selection par rectangle (Maj), etirer et incliner, forme du segment", () => {
    const { U, sent } = setup();
    const pts = [U.makePoint(0, 0.5), U.makePoint(0.3, 0.3), U.makePoint(0.5, 0.7), U.makePoint(0.7, 0.3), U.makePoint(1, 0.5)];
    pointsView(U, pts, true);
    U.onclick(px(0.2), py(0.9), 1, 0, 1, 0, 0, 0);
    U.ondrag(px(0.8), py(0.1), 1, 0, 1, 0, 0, 0);
    U.ondrag(px(0.8), py(0.1), 0, 0, 1, 0, 0, 0);
    assert.strictEqual(sent.length, 0, "la selection n'envoie rien");
    U.stretch(1);
    let out = U.decodePoints(sent[0][2]);
    assert.ok(out[1].x < 0.3 && out[3].x > 0.7, "etire autour du centre : " + out.map((p) => p.x.toFixed(3)));
    assert.strictEqual(out[0].x, 0); assert.strictEqual(out[4].x, 1);
    pointsView(U, pts, true);
    U.onclick(px(0.2), py(0.9), 1, 0, 1, 0, 0, 0); U.ondrag(px(0.8), py(0.1), 1, 0, 1, 0, 0, 0); U.ondrag(px(0.8), py(0.1), 0, 0, 1, 0, 0, 0);
    U.tilt(1);
    out = U.decodePoints(sent[1][2]);
    assert.ok(out[3].y > 0.3 && out[1].y < 0.3, "inclinaison : bord droit monte, bord gauche descend");
    pointsView(U, pts, true);
    U.onclick(px(0.5), py(0.7), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.5), py(0.7), 0, 0, 0, 0, 0, 0);
    const before = sent.length;
    U.shape_seg(3);
    assert.strictEqual(U.decodePoints(sent[before][2])[2].shape, 3);
});

test("ligne verrouillee ou apercu : aucune modification, aucun envoi", () => {
    const { U, sent } = setup();
    U.view(0, U.encodeCurve(U.preset(1, 4)), "-", 0, 1, 4, 0, "L", 0);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 0, 0, 0, 0, 0, 0);
    U.view(0, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "L", 0);
    U.setpreview(1);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 0);
});

test("relachement non signale : le mouvement suivant termine le geste", () => {
    const { U, sent } = setup();
    U.view(0, U.encodeCurve(U.preset(1, 4)), "-", 0, 0, 4, 0, "L", 0);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0);
    U.onidle(px(0.6), py(0.6), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 1);
});

test("mode points demande mais moins de 2 points : retombe en dessin libre", () => {
    const { U } = setup();
    U.view(0, U.encodeCurve(U.preset(1, 4)), "0.5,0.5,0,0", 1, 0, 4, 0, "L", 0);
    assert.strictEqual(U.pointMode, false);
});

console.log("\n" + ok + " tests passes");
