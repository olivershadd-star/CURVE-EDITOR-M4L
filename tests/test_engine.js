// Tests du modele des 8 lignes (src/core.js + src/engine.js), sans Max.
// Usage : node tests/test_engine.js
"use strict";
const assert = require("assert");
const { load } = require("./loader");
const S = load(["core.js", "engine.js"]);

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }

function makeIo() {
    const rec = { cc: [], params: [], views: [], manual: [], selected: [], status: [] };
    return { rec, io: {
        cc: (ch, cc, v) => rec.cc.push([ch, cc, v]),
        setParam: (i, key, v) => rec.params.push([i, key, v]),
        view: (i) => rec.views.push(i),
        params: () => {},
        selected: (i) => rec.selected.push(i),
        manual: (i, f) => rec.manual.push([i, f]),
        status: (t) => rec.status.push(t) } };
}
function fresh() { const r = makeIo(); const m = S.createModel(r.io); return { m, rec: r.rec }; }
const plain = (x) => JSON.parse(JSON.stringify(x));
const near = (a, b, e, w) => assert.ok(Math.abs(a - b) <= (e === undefined ? 1e-9 : e), (w || "") + " " + a + " != " + b);

test("8 lignes, CC 20 a 27, canal 16, toutes coupees", () => {
    const { m } = fresh();
    assert.strictEqual(m.lanes.length, 8);
    m.lanes.forEach((l, i) => { assert.strictEqual(l.cc, 20 + i); assert.strictEqual(l.channel, 16); assert.strictEqual(l.params.on, 0); });
});

test("reglages : bornes, entiers et pas de 0.25 mesure", () => {
    const { m } = fresh();
    m.setParam(0, "min", -5); assert.strictEqual(m.lanes[0].params.min, 0);
    m.setParam(0, "max", 250); assert.strictEqual(m.lanes[0].params.max, 100);
    m.setParam(0, "bars", 2.6); assert.strictEqual(m.lanes[0].params.bars, 2.5);
    m.setParam(0, "bars", 0); assert.strictEqual(m.lanes[0].params.bars, 0.25);
    m.setParam(0, "bars", 99); assert.strictEqual(m.lanes[0].params.bars, 32);
    m.setParam(0, "value", 64.6); assert.strictEqual(m.lanes[0].params.value, 65);
    m.setParam(0, "cc", 300); assert.strictEqual(m.lanes[0].cc, 127);
    m.setParam(0, "channel", 0); assert.strictEqual(m.lanes[0].channel, 1);
    m.setParam(0, "min", NaN); assert.strictEqual(m.lanes[0].params.min, 0);
    m.setParam(0, "inconnu", 3);
    m.setParam(99, "on", 1);                      // ligne hors limites : ramenee a la derniere, sans plantage
});

test("tick : envoie le CC attendu, une seule fois tant qu'il ne change pas", () => {
    const { m, rec } = fresh();
    m.setParam(0, "on", 1); m.setParam(0, "smooth", 0); m.lanes[0].curve = S.preset(1, 4);   // rampe 0..1
    m.tick(true, 0, 4, 0.015);
    assert.deepStrictEqual(rec.cc[0], [16, 20, 0]);
    m.tick(true, 0, 4, 0.015); assert.strictEqual(rec.cc.length, 1);
    m.tick(true, 8, 4, 0.015);                    // 8 temps = 2 mesures sur 4 : moitie
    assert.strictEqual(rec.cc[1][2], 64);
    m.tick(true, 16, 4, 0.015);                   // boucle : retour au debut
    assert.strictEqual(rec.cc[2][2], 0);
});

test("tick : transport arrete = rien, ligne coupee = rien, reprise = renvoi", () => {
    const { m, rec } = fresh();
    m.setParam(0, "on", 1); m.setParam(0, "smooth", 0);
    m.tick(false, 5, 4, 0.015); assert.strictEqual(rec.cc.length, 0);
    m.tick(true, 5, 4, 0.015); assert.strictEqual(rec.cc.length, 1);
    m.tick(false, 5, 4, 0.015); m.tick(true, 5, 4, 0.015);
    assert.strictEqual(rec.cc.length, 2, "la valeur est renvoyee apres un arret");
    m.setParam(0, "on", 0); m.tick(true, 6, 4, 0.015); assert.strictEqual(rec.cc.length, 2);
});

test("tick : min / max / profondeur / phase suivent la formule de LaneMath", () => {
    const { m, rec } = fresh();
    const l = m.lanes[2];
    m.setParam(2, "on", 1); m.setParam(2, "smooth", 0); m.setParam(2, "min", 10); m.setParam(2, "max", 90);
    m.setParam(2, "depth", 60); m.setParam(2, "offset", 25); m.setParam(2, "bars", 2);
    m.tick(true, 3.9, 3, 0.015);
    const expected = S.toCC(S.laneTarget(l.curve, 3.9, 3, l.params));
    assert.deepStrictEqual(rec.cc[0], [16, 22, expected]);
});

test("lissage : la valeur rejoint la cible progressivement", () => {
    const { m, rec } = fresh();
    m.setParam(0, "on", 1); m.setParam(0, "smooth", 200);
    m.lanes[0].curve = S.preset(2, 4);            // 1 -> 0
    m.tick(true, 0, 4, 0.015);
    const first = rec.cc[0][2];
    assert.strictEqual(first, 127);
    m.tick(true, 12, 4, 0.015);                   // cible 0.25 environ, mais le filtre est lent
    assert.ok(rec.cc[rec.cc.length - 1][2] > 90, "pas de saut brutal : " + rec.cc[rec.cc.length - 1][2]);
});

test("commande manuelle : ignoree au chargement, armee ensuite, envoyee a l'arret, reprise", () => {
    const { m, rec } = fresh();
    m.setParam(0, "on", 1);
    m.setParam(0, "value", 40);                   // chargement : pas encore arme
    assert.strictEqual(m.lanes[0].manual, false);
    m.armed = true;
    m.setParam(0, "value", 100);
    assert.strictEqual(m.lanes[0].manual, true);
    m.tick(false, 0, 4, 0.015);                   // manuel : envoye meme a l'arret
    assert.deepStrictEqual(rec.cc[rec.cc.length - 1], [16, 20, 100]);
    m.setParam(0, "value", 100);                  // meme valeur : pas de re-declenchement
    m.resume(0);
    assert.strictEqual(m.lanes[0].manual, false);
    m.tick(false, 0, 4, 0.015);
    assert.strictEqual(rec.cc[rec.cc.length - 1][2], 100, "arret : rien de nouveau envoye");
});

test("verrouillage : aucune modification, annulation impossible", () => {
    const { m } = fresh();
    m.applyPreset(0, 1);
    const before = m.lanes[0].curve.y.slice(0);
    m.toggleLock(0);
    m.applyPreset(0, 2); m.invert(0); m.smoothCurve(0, 1); m.applyVariation(0, 0.3, 5); m.undo(0); m.setPointMode(0, true);
    assert.deepStrictEqual(m.lanes[0].curve.y, before);
    assert.strictEqual(m.lanes[0].pointMode, false);
    assert.strictEqual(m.applyScript(0, "duration: 1 bars\nhold over 1 bars", "").ok, false);
    m.toggleLock(0); m.applyPreset(0, 2);
    assert.notDeepStrictEqual(m.lanes[0].curve.y, before);
});

test("annuler / copier / coller / inverser", () => {
    const { m } = fresh();
    m.applyPreset(0, 1); const ramp = m.lanes[0].curve.y.slice(0);
    m.applyPreset(0, 2); m.undo(0);
    assert.deepStrictEqual(m.lanes[0].curve.y, ramp);
    m.copy(0); m.paste(3);
    assert.deepStrictEqual(m.lanes[3].curve.y, ramp);
    m.invert(3); near(m.lanes[3].curve.y[0], 1); near(m.lanes[3].curve.y[2048], 0);
    m.undo(3); assert.deepStrictEqual(m.lanes[3].curve.y, ramp);
    const fresh2 = fresh(); fresh2.m.paste(0); assert.ok(/Copier/.test(fresh2.m.status));
});

test("variation avec graine = meme resultat que le noyau ; lissage du dessin", () => {
    const { m } = fresh();
    const base = S.copyData(m.lanes[1].curve);
    m.applyVariation(1, 0.2, 12345);
    const ref = S.vary(base, 0.2, 12345);
    near(m.lanes[1].curve.y[777], ref.y[777]);
    const before = m.lanes[1].curve.y.slice(0);
    m.smoothCurve(1, 0.5);
    assert.notDeepStrictEqual(m.lanes[1].curve.y, before);
});

test("points : passage en mode points, edition, retour au dessin libre", () => {
    const { m } = fresh();
    m.setPointMode(0, true);
    assert.strictEqual(m.lanes[0].pointMode, true);
    assert.ok(m.lanes[0].points.length >= 2);
    m.replacePoints(0, [S.makePoint(0, 0), S.makePoint(0.5, 1, 0.5, 1), S.makePoint(1, 0)]);
    assert.strictEqual(m.lanes[0].points.length, 3);
    near(m.lanes[0].curve.y[1024], 1, 1e-6);
    m.setPointMode(0, false);
    assert.strictEqual(m.lanes[0].pointMode, false);
    m.setDrawnCurve(0, S.preset(3, 9));
    assert.strictEqual(m.lanes[0].points.length, 0);
    assert.strictEqual(m.lanes[0].curve.bars, m.lanes[0].params.bars, "la duree vient du reglage");
});

test("code avance et description : appliquer, erreurs lisibles, duree reportee dans le reglage", () => {
    const { m, rec } = fresh();
    const r = S.translateMotion("ouvre sur 2 mesures puis ferme", 4, 0.25);
    assert.deepStrictEqual(plain(m.applyScript(0, r.script, "ouvre sur 2 mesures puis ferme")), { ok: true });
    assert.strictEqual(m.lanes[0].motionText, "ouvre sur 2 mesures puis ferme");
    const bad = m.applyScript(0, "duration: 4 bars\nzigzag", "");
    assert.deepStrictEqual(plain(bad), { ok: false, error: "Ligne 2 : Instruction inconnue" });
    const long = m.applyScript(1, "duration: 40 bars\nhold over 40 bars", "");
    assert.strictEqual(long.ok, false);
    const ok2 = m.applyScript(1, "duration: 8 bars\nstart: 10%\nhold over 8 bars", "");
    assert.strictEqual(ok2.ok, true);
    assert.strictEqual(m.lanes[1].params.bars, 8);
    assert.ok(rec.params.some((p) => p[0] === 1 && p[1] === "bars" && p[2] === 8), "le controle Live recoit la nouvelle duree");
});

test("reflowScript : retrouve les lignes du code apres un passage par un message Max", () => {
    const script = "duration: 4 bars\nstart: 20%\nramp to 70% over 2 bars smooth\nhold over 1 bars\nwave around 70% depth 10% cycles 2 over 1 bars sine";
    const flat = script.replace(/\n/g, " ");
    assert.strictEqual(S.reflowScript(flat), script);
    assert.strictEqual(S.reflowScript("duration: 2 bars # un commentaire ramp to 50% over 2 bars linear"), "duration: 2 bars\nramp to 50% over 2 bars linear");
    near(S.parseScript(S.reflowScript(flat)).y[500], S.parseScript(script).y[500]);
});

test("codage 8 bits : erreur < 1/255, refuse les textes invalides", () => {
    const d = S.preset(0, 4), back = S.decodeCurve(S.encodeCurve(d), 4);
    for (let n = 0; n <= 2048; n += 17) near(back.y[n], d.y[n], 1 / 255 / 2 + 1e-9);
    assert.strictEqual(S.decodeCurve("zz", 4), null);
    assert.strictEqual(S.decodeCurve("g".repeat(4098), 4), null);
    const pts = [S.makePoint(0, 0.2, 0.5, 3), S.makePoint(1, 0.8, -1, 0)];
    assert.deepStrictEqual(plain(S.decodePoints(S.encodePoints(pts)).map((p) => [p.x, p.y, p.tension, p.shape])), [[0, 0.2, 0.5, 3], [1, 0.8, -1, 0]]);
    assert.deepStrictEqual(plain(S.decodePoints("n'importe quoi")), []);
});

function readVlq(b, pos) { let v = 0, c; do { c = b[pos++]; v = (v << 7) | (c & 127); } while (c & 128); return [v, pos]; }
test("export MIDI : fichier valide dont les CC suivent la formule", () => {
    const { m } = fresh();
    m.setParam(4, "smooth", 0); m.setParam(4, "bars", 1); m.setParam(4, "min", 20); m.setParam(4, "max", 80);
    m.applyPreset(4, 1);
    const b = m.exportMidi(4, 4, 120);
    assert.deepStrictEqual(plain(b.slice(0, 4)), [0x4D, 0x54, 0x68, 0x64]);
    assert.strictEqual((b[12] << 8) | b[13], 960);
    assert.deepStrictEqual(plain(b.slice(14, 18)), [0x4D, 0x54, 0x72, 0x6B]);
    const len = (b[18] << 24) | (b[19] << 16) | (b[20] << 8) | b[21];
    assert.strictEqual(b.length, 22 + len);
    let pos = 22, tick = 0, events = [];
    while (pos < b.length) {
        const r = readVlq(b, pos); tick += r[0]; pos = r[1];
        if (b[pos] === 0xFF) { assert.deepStrictEqual(plain(b.slice(pos, pos + 3)), [0xFF, 0x2F, 0x00]); events.push(["end", tick]); pos += 3; }
        else { assert.strictEqual(b[pos] & 0xF0, 0xB0); events.push([tick, b[pos] & 15, b[pos + 1], b[pos + 2]]); pos += 3; }
    }
    assert.strictEqual(events[events.length - 1][0], "end");
    assert.strictEqual(events[events.length - 1][1], 3840);
    const ccs = events.slice(0, -1);
    assert.ok(ccs.length > 20);
    ccs.forEach((e) => { assert.strictEqual(e[1], 15); assert.strictEqual(e[2], 24); });
    assert.strictEqual(ccs[0][3], Math.round(0.2 * 127));
    assert.ok(ccs[ccs.length - 1][3] >= Math.round(0.79 * 127));
    for (let k = 1; k < ccs.length; k++) assert.ok(ccs[k][3] >= ccs[k - 1][3] && ccs[k][0] > ccs[k - 1][0], "croissant, temps croissants");
});

test("session : aller-retour complet, y compris le mode manuel et les reglages", () => {
    const a = fresh(), b = fresh();
    a.m.setParam(2, "min", 12.5); a.m.setParam(2, "on", 1); a.m.setParam(2, "bars", 8);
    a.m.applyScript(2, "duration: 8 bars\nstart: 10%\nramp to 90% over 8 bars smooth", "ouvre doucement");
    a.m.rename(2, "Cutoff"); a.m.setPointMode(5, true); a.m.toggleLock(5);
    a.m.armed = true; a.m.setParam(6, "value", 99);
    a.m.setParam(7, "cc", 74); a.m.setParam(7, "channel", 3);
    const json = JSON.stringify(a.m.toSession(true));
    b.m.armed = true;
    assert.strictEqual(b.m.fromSession(JSON.parse(json), true), true);
    assert.strictEqual(b.m.armed, true, "l'importation ne change pas l'etat d'armement");
    assert.strictEqual(b.m.lanes[2].name, "Cutoff");
    assert.strictEqual(b.m.lanes[2].motionText, "ouvre doucement");
    assert.strictEqual(b.m.lanes[2].params.min, 12.5);
    assert.strictEqual(b.m.lanes[2].params.bars, 8);
    near(b.m.lanes[2].curve.y[1024], a.m.lanes[2].curve.y[1024], 1 / 255);
    assert.strictEqual(b.m.lanes[5].locked, true);
    assert.strictEqual(b.m.lanes[5].pointMode, true);
    assert.ok(b.m.lanes[5].points.length >= 2);
    assert.strictEqual(b.m.lanes[6].manual, true);
    assert.strictEqual(b.m.lanes[6].params.value, 99);
    assert.strictEqual(b.m.lanes[7].cc, 74); assert.strictEqual(b.m.lanes[7].channel, 3);
    assert.ok(b.rec.params.some((p) => p[0] === 7 && p[1] === "cc" && p[2] === 74), "les controles Live sont mis a jour");
    // restauration avec le set : les reglages viennent des controles Live, pas du JSON
    const c = fresh();
    assert.strictEqual(c.m.restore(a.m.serialize()), true);
    assert.strictEqual(c.m.lanes[2].name, "Cutoff");
    assert.strictEqual(c.m.lanes[2].params.min, 0, "reglages non restaures ici : ils reviennent des controles");
});

test("session invalide : refusee sans rien casser", () => {
    const { m } = fresh();
    m.rename(0, "Intact");
    assert.strictEqual(m.restore("pas du json"), false);
    assert.strictEqual(m.restore("{}"), false);
    assert.strictEqual(m.restore(JSON.stringify({ format: "AUTRE", lanes: [] })), false);
    assert.strictEqual(m.fromSession({ format: "CURVE_EDITOR_M4L", lanes: [{ curve: "zz", points: [[NaN, 1, 2, 3]], cc: "x", channel: 99, name: 5 }] }, false), true);
    assert.strictEqual(m.lanes[0].channel, 16);
    assert.strictEqual(m.lanes[0].cc, 20);
    assert.ok(m.lanes[0].pointMode === false);
});

console.log("\n" + ok + " tests passes");
