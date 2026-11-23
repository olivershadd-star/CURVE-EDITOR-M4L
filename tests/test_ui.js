// Tests de la fenetre d'edition (src/ui.js) avec un faux mgraphics, de faux champs texte et un faux moteur.
// Usage : node tests/test_ui.js
"use strict";
const assert = require("assert");
const { load } = require("./loader");

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }

function setup() {
    const sent = [], calls = { n: 0, text: [] }, objs = {};
    ["name_edit", "body_edit"].forEach((n) => { objs[n] = { hidden: true, log: [], message(...a) { this.log.push(a); } }; });
    const mg = { size: [720, 780], relative_coords: 1, autofill: 1, redrawn: 0, init() {}, redraw() { this.redrawn++; },
        text_measure: (s) => [String(s).length * 6.5, 11] };
    ["set_source_rgba", "rectangle", "fill", "move_to", "line_to", "stroke", "set_line_width", "ellipse", "close_path",
        "select_font_face", "set_font_size"].forEach((f) => { mg[f] = () => { calls.n++; }; });
    mg.show_text = (t) => { calls.n++; calls.text.push(t); };
    const U = load(["core.js", "ui.js"], { mgraphics: mg, outlet: (n, ...a) => sent.push(a), patcher: { getnamed: (n) => objs[n] || null } });
    return { U, sent, calls, mg, objs };
}
const hex = (U, d) => U.encodeCurve(d);
// pixels <-> coordonnees de la courbe
function conv(U) { const r = U.plot(); return { px: (x) => r.x + x * r.w, py: (y) => r.y + r.h - y * r.h }; }
function show(U, lane, pts, mode, extra) {
    const d = pts ? U.fromPoints(pts, 4) : U.preset(1, 4);
    U.lane_view(lane, hex(U, d), pts ? U.encodePoints(pts) : "-", mode ? 1 : 0, 0, 4, 0, encodeURIComponent("Cutoff"), 0);
}
// clic sur un controle par son identifiant
function ctlOf(U, id) { U.layout(); const c = U.controls.filter((k) => k.id === id)[0]; assert.ok(c, "controle " + id + " introuvable"); return c; }
function click(U, id, dx, dy) { const c = ctlOf(U, id); U.onclick(c.x + (dx === undefined ? c.w / 2 : dx), c.y + (dy === undefined ? c.h / 2 : dy), 1, 0, 0, 0, 0, 0); return c; }
function release(U) { U.ondrag(0, 0, 0, 0, 0, 0, 0, 0); }

test("initialisation de mgraphics en pixels, sans remplissage automatique", () => {
    const { mg } = setup();
    assert.strictEqual(mg.relative_coords, 0); assert.strictEqual(mg.autofill, 0);
});

test("chaque page se dessine sans erreur ; aucun controle ne sort de la fenetre ni n'en chevauche un autre", () => {
    const { U, calls } = setup();
    for (let page = 0; page < 3; page++) {
        U.setPage(page);
        U.paint();
        const cs = U.controls.filter((c) => c.kind !== "graph" && c.kind !== "previewgraph");
        cs.forEach((c) => { assert.ok(c.x >= 0 && c.y >= 0 && c.x + c.w <= 720 && c.y + c.h <= 780, "page " + page + " : " + c.id + " hors fenetre"); });
        for (let a = 0; a < cs.length; a++) for (let b = a + 1; b < cs.length; b++) {
            const p = cs[a], q = cs[b];
            const overlap = p.x < q.x + q.w && q.x < p.x + p.w && p.y < q.y + q.h && q.y < p.y + p.h;
            assert.ok(!overlap, "page " + page + " : " + p.id + " chevauche " + q.id);
        }
    }
    assert.ok(calls.n > 300);
});

test("onglets : un clic envoie select ; les messages tab / lane_selected mettent a jour la vue", () => {
    const { U, sent } = setup();
    click(U, "tab5");
    assert.deepStrictEqual(sent.pop(), ["select", 5]);
    const mini = "00".repeat(32) + "ff" + "80".repeat(32);
    U.tab(5, mini, encodeURIComponent("Reso"), 1);
    assert.strictEqual(U.lanes[5].name, "Reso"); assert.strictEqual(U.lanes[5].params.on, 1);
    assert.ok(Math.abs(U.lanes[5].mini[32] - 1) < 1e-9);
    U.lane_selected(5); assert.strictEqual(U.sel, 5);
    U.paint();
});

test("pages : les champs texte ne sont visibles que sur leur page", () => {
    const { U, objs } = setup();
    click(U, "page1"); assert.strictEqual(objs.name_edit.hidden, false); assert.strictEqual(objs.body_edit.hidden, true);
    click(U, "page2"); assert.strictEqual(objs.name_edit.hidden, true); assert.strictEqual(objs.body_edit.hidden, false);
    click(U, "page0"); assert.strictEqual(objs.name_edit.hidden, true); assert.strictEqual(objs.body_edit.hidden, true);
});

test("boutons de la page Courbe : chacun envoie btn <nom> 1", () => {
    const { U, sent } = setup();
    [["free", "free"], ["points", "points"], ["copy", "copy"], ["paste", "paste"], ["undo", "undo"], ["lock", "lock"],
        ["invert", "invert"], ["vary", "vary"], ["smoothb", "smooth"]].forEach(([id, name]) => {
        click(U, id);
        assert.deepStrictEqual(sent.pop(), ["btn", name, 1], id);
    });
});

test("Active : bascule la ligne affichee", () => {
    const { U, sent } = setup();
    U.lane_selected(2);
    click(U, "active"); assert.deepStrictEqual(sent.pop(), ["p", 2, "on", 1]);
    click(U, "active"); assert.deepStrictEqual(sent.pop(), ["p", 2, "on", 0]);
});

test("menu Forme : ouvre la liste, un clic sur une entree envoie set_preset", () => {
    const { U, sent } = setup();
    const c = click(U, "shape");
    assert.ok(U.menu && U.menu.items.length === 6);
    U.onclick(U.menu.x + 20, U.menu.y + 2 + 24 * 3 + 10, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["set_preset", 3]); assert.strictEqual(U.menu, null);
    click(U, "shape"); U.onclick(5, 5, 1, 0, 0, 0, 0, 0);     // clic hors du menu : le ferme sans rien envoyer
    assert.strictEqual(U.menu, null); assert.strictEqual(sent.length, 0);
});

test("menus Grille, Pinceau, Segment et Session", () => {
    const { U, sent } = setup();
    click(U, "grid"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 * 3 + 5, 1, 0, 0, 0, 0, 0); assert.strictEqual(U.grid, 32);
    click(U, "brush"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 * 2 + 5, 1, 0, 0, 0, 0, 0);
    assert.strictEqual(U.brush, 2); assert.deepStrictEqual(sent.pop(), ["btn", "free", 1]);
    click(U, "snap"); assert.strictEqual(U.snap, false);
    click(U, "session"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 + 5, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["tools", "import_session"]);
    click(U, "session"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 5, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["tools", "export_session"]);
});

test("curseurs : glisser envoie p <ligne> <reglage> <valeur> en continu, bornes et pas respectes", () => {
    const { U, sent } = setup();
    U.lane_selected(1);
    const c = ctlOf(U, "sl4");                                   // Lissage ms 0..500
    U.onclick(c.x + 2 + (c.w - 4) * 0.5, c.y + 20, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["p", 1, "smooth", 250]);
    U.ondrag(c.x + c.w + 50, c.y + 20, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["p", 1, "smooth", 500]);
    release(U);
    U.ondrag(c.x, c.y, 1, 0, 0, 0, 0, 0); assert.strictEqual(sent.length, 0, "plus de glisser apres le relachement");
    const b = ctlOf(U, "sl2");                                   // Mesures 1..16 pas 1
    U.onclick(b.x + 2 + (b.w - 4) * 0.25, b.y + 20, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["p", 1, "bars", 5]); release(U);
    const v = ctlOf(U, "sl6");                                   // Variation % : reglage local, envoye au moteur
    U.onclick(v.x + 2 + (v.w - 4) * 0.2, v.y + 20, 1, 0, 0, 0, 0, 0); release(U);
    assert.deepStrictEqual(sent.pop(), ["vary_amount", 20]);
});

test("params : le moteur met a jour les reglages affiches", () => {
    const { U } = setup();
    U.params(3, 1, 10, 90, 8, 25, 40, 70, 99, 23, 4);
    assert.deepStrictEqual(JSON.parse(JSON.stringify(U.lanes[3].params)), { on: 1, min: 10, max: 90, bars: 8, offset: 25, smooth: 40, depth: 70, value: 99, cc: 23, channel: 4 });
});

test("page Destination : canal, CC, valeur manuelle, Reprendre, export MIDI, nom", () => {
    const { U, sent, objs } = setup();
    click(U, "page1");
    click(U, "channel"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 * 4 + 5, 1, 0, 0, 0, 0, 0);
    assert.deepStrictEqual(sent.pop(), ["p", 0, "channel", 5]);
    const cc = ctlOf(U, "cc"); U.onclick(cc.x + 2 + (cc.w - 4) * 0.5, cc.y + 30, 1, 0, 0, 0, 0, 0); release(U);
    assert.strictEqual(sent.pop()[3], 64);
    const val = ctlOf(U, "value"); U.onclick(val.x + 2, val.y + 30, 1, 0, 0, 0, 0, 0); release(U);
    assert.deepStrictEqual(sent.pop(), ["p", 0, "value", 0]);
    click(U, "resume"); assert.strictEqual(sent.length, 0, "Reprendre est grise tant que la ligne n'est pas manuelle");
    U.lane_manual(0, 1); click(U, "resume"); assert.deepStrictEqual(sent.pop(), ["resume", 0, 1]);
    click(U, "exportmid"); assert.deepStrictEqual(sent.pop(), ["tools", "export_mid"]);
    click(U, "rename");
    assert.deepStrictEqual(objs.name_edit.log.pop(), ["bang"]);
    U.edit_name("text", "Mon", "nom");
    assert.deepStrictEqual(sent.splice(0), [["text", "name", encodeURIComponent("Mon nom")], ["tools", "rename"]]);
    U.edit_name("text", "pas demande"); assert.strictEqual(sent.length, 0, "texte non demande : ignore");
});

test("page Decrire / Code : mode, previsualiser, appliquer, apercu et textes du moteur", () => {
    const { U, sent, objs } = setup();
    U.fill(encodeURIComponent("Cutoff"), encodeURIComponent("ouvre sur 2 mesures"), encodeURIComponent("duration: 2 bars"));
    assert.deepStrictEqual(objs.body_edit.log.pop(), ["set", "ouvre sur 2 mesures"]);
    click(U, "page2");
    click(U, "preview");
    assert.deepStrictEqual(objs.body_edit.log.pop(), ["bang"]);
    U.edit_body("text", "ouvre", "puis", "ferme");
    assert.deepStrictEqual(sent.splice(0), [["text", "desc", encodeURIComponent("ouvre puis ferme")], ["tools", "preview_desc"]]);
    click(U, "apply"); assert.deepStrictEqual(sent.pop(), ["tools", "apply_desc"]);
    click(U, "mode"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 + 5, 1, 0, 0, 0, 0, 0);
    assert.strictEqual(U.mode, 1); assert.deepStrictEqual(objs.body_edit.log.pop(), ["set", "duration: 2 bars"]);
    click(U, "preview"); U.edit_body("duration:", "2", "bars");
    assert.deepStrictEqual(sent.splice(0), [["text", "code", encodeURIComponent("duration: 2 bars")], ["tools", "preview_code"]]);
    click(U, "apply"); assert.deepStrictEqual(sent.pop(), ["tools", "apply_code"]);
    U.say(encodeURIComponent("Position 1"), encodeURIComponent("Proposition"));
    U.preview_curve(hex(U, U.preset(2, 4)), 4);
    U.paint();
    assert.strictEqual(U.interp, "Position 1"); assert.ok(U.previewData);
    U.fill(encodeURIComponent("Cutoff"), "%00", "%00");
    assert.deepStrictEqual(objs.body_edit.log.pop(), ["clear"]);
});

test("zone de texte absente : message clair, pas de plantage", () => {
    const { U } = setup();
    U.getObj = () => null;
    click(U, "page2"); click(U, "preview");
    assert.ok(/texte/.test(U.msgLine));
});

test("lane_view invalide ignore ; pendant un glisser ignore", () => {
    const { U } = setup();
    U.lane_view(1, "zz", "-", 0, 0, 4, 0, "x", 0);
    assert.strictEqual(U.sel, 0);
    show(U, 1); const { px, py } = conv(U);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0);
    U.lane_view(3, hex(U, U.preset(1, 4)), "-", 0, 0, 4, 0, "y", 0);
    assert.strictEqual(U.sel, 1);
});

test("trait libre : continu, sans aimantation ; le relachement envoie la courbe", () => {
    const { U, sent } = setup();
    show(U, 4); const { px, py } = conv(U);
    U.onclick(px(0.26), py(0.51), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.5), py(0.51), 1, 0, 0, 0, 0, 0);
    U.ondrag(px(0.5), py(0.51), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 1); assert.strictEqual(sent[0][0], "ui_curve"); assert.strictEqual(sent[0][1], 4);
    const d = U.decodeCurve(sent[0][2], 4);
    assert.ok(Math.abs(d.y[Math.round(0.26 * 2048)] - 0.51) < 0.01, "pas d'escalier");
    assert.ok(Math.abs(d.y[1024] - 0.51) < 0.01);
    assert.ok(Math.abs(d.y[0] - 0) < 0.01, "le reste est inchange");
});

test("pinceaux : rampe, triangle, sinus remplissent une case de la grille", () => {
    [1, 2, 3].forEach((b) => {
        const { U, sent } = setup();
        show(U, 0); U.brush = b; U.snap = false; U.grid = 4; const { px, py } = conv(U);
        U.onclick(px(0.30), py(0.8), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.30), py(0.8), 0, 0, 0, 0, 0, 0);
        const d = U.decodeCurve(sent[0][2], 4);
        assert.ok(Math.abs(d.y[0]) < 0.02, "debut de case");
        if (b === 2 || b === 3) { assert.ok(Math.abs(d.y[768] - 0.8) < 0.02); }
    });
});

test("mode points : un clic ajoute, glisser deplace, envoi au relachement", () => {
    const { U, sent } = setup();
    show(U, 2, [U.makePoint(0, 0.2), U.makePoint(1, 0.2)], true); U.snap = false; const { px, py } = conv(U);
    U.onclick(px(0.5), py(0.8), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.5), py(0.8), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent[0][0], "ui_points");
    let pts = U.decodePoints(sent[0][2]); assert.strictEqual(pts.length, 3);
    show(U, 2, pts, true);
    U.onclick(px(0.5), py(pts[1].y), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.25), py(0.5), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.25), py(0.5), 0, 0, 0, 0, 0, 0);
    pts = U.decodePoints(sent[1][2]);
    assert.ok(Math.abs(pts[1].x - 0.25) < 0.001 && Math.abs(pts[1].y - 0.5) < 0.01);
});

test("extremites : seulement verticales ; pas de point au-dela des voisins ; Alt + clic supprime", () => {
    const { U, sent } = setup();
    const base = () => [U.makePoint(0, 0.2), U.makePoint(0.5, 0.6), U.makePoint(1, 0.2)];
    show(U, 2, base(), true); U.snap = false; const { px, py } = conv(U);
    U.onclick(px(0), py(0.2), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.4), py(0.7), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.4), py(0.7), 0, 0, 0, 0, 0, 0);
    let out = U.decodePoints(sent[0][2]); assert.strictEqual(out[0].x, 0); assert.ok(out[0].y > 0.6);
    show(U, 2, base(), true);
    U.onclick(px(0.5), py(0.6), 1, 0, 0, 0, 0, 0); U.ondrag(px(1.0), py(0.6), 1, 0, 0, 0, 0, 0); U.ondrag(px(1.0), py(0.6), 0, 0, 0, 0, 0, 0);
    out = U.decodePoints(sent[1][2]); assert.ok(out[1].x < 1 && out[1].x > 0.5);
    show(U, 2, base(), true);
    U.onclick(px(0.5), py(0.6), 1, 0, 0, 0, 1, 0); assert.strictEqual(U.decodePoints(sent[2][2]).length, 2);
    show(U, 2, base(), true);
    U.onclick(px(0), py(0.2), 1, 0, 0, 0, 1, 0); U.ondrag(px(0), py(0.2), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(U.decodePoints(sent[3][2]).length, 3, "une extremite ne se supprime pas");
});

test("poignee de courbure, double-clic de remise a zero, selection Maj, etirer, segment", () => {
    const { U, sent } = setup();
    const base = () => [U.makePoint(0, 0.2), U.makePoint(0.5, 0.6), U.makePoint(1, 0.2)];
    show(U, 2, base(), true); U.snap = false; const { px, py } = conv(U);
    const mid = U.fromPoints(base(), 4).y[Math.round(0.25 * 2048)];
    U.onclick(px(0.25), py(mid), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.25), py(mid) - 60, 1, 0, 0, 0, 0, 0); U.ondrag(px(0.25), py(mid) - 60, 0, 0, 0, 0, 0, 0);
    assert.ok(Math.abs(U.decodePoints(sent[0][2])[0].tension) > 0.2, "courbure");
    // selection par rectangle puis etirer
    show(U, 2, [U.makePoint(0, 0.2), U.makePoint(0.4, 0.6), U.makePoint(0.6, 0.6), U.makePoint(1, 0.2)], true);
    U.onclick(px(0.3), py(0.9), 1, 0, 1, 0, 0, 0); U.ondrag(px(0.7), py(0.4), 1, 0, 1, 0, 0, 0); U.ondrag(px(0.7), py(0.4), 0, 0, 1, 0, 0, 0);
    assert.strictEqual(JSON.stringify(U.selectedList()), "[1,2]");
    click(U, "stretchp"); const stretched = U.decodePoints(sent.pop()[2]);
    assert.ok(stretched[2].x - stretched[1].x > 0.2 - 1e-9, "points ecartes");
    show(U, 2, [U.makePoint(0, 0.2), U.makePoint(0.4, 0.6), U.makePoint(0.6, 0.6), U.makePoint(1, 0.2)], true);
    U.onclick(px(0.4), py(0.6), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.4), py(0.6), 0, 0, 0, 0, 0, 0); sent.length = 0;
    click(U, "segment"); U.onclick(U.menu.x + 10, U.menu.y + 2 + 24 * 2 + 5, 1, 0, 0, 0, 0, 0);
    assert.strictEqual(U.decodePoints(sent.pop()[2])[1].shape, 2);
});

test("ligne verrouillee : le graphique ne reagit pas", () => {
    const { U, sent } = setup();
    U.lane_view(0, hex(U, U.preset(1, 4)), "-", 0, 1, 4, 0, "x", 0); const { px, py } = conv(U);
    U.onclick(px(0.5), py(0.5), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 1, 0, 0, 0, 0, 0); U.ondrag(px(0.6), py(0.9), 0, 0, 0, 0, 0, 0);
    assert.strictEqual(sent.length, 0);
});

console.log("\n" + ok + " tests passes");
