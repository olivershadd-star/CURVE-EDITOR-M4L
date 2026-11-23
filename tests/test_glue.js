// Tests de la colle Max (src/glue.js) avec de faux objets Max : sorties, messages, LiveAPI, fichiers.
// Usage : node tests/test_glue.js
"use strict";
const assert = require("assert");
const { load } = require("./loader");

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }
const plain = (x) => JSON.parse(JSON.stringify(x));

function setup(opts) {
    opts = opts || {};
    const out = [], objects = {}, sub = {}, files = {}, T = { now: 1000000 };
    const live = { is_playing: [1], current_song_time: [0], signature_numerator: [4], signature_denominator: [4], tempo: [120] };
    function fake(name) { return { name, log: [], message(...a) { this.log.push(plain(a)); } }; }
    ["editor", "state", "savedlg", "opendlg", "status", "tools"].forEach((n) => { objects[n] = fake(n); });
    for (let k = 0; k < 8; k++) { objects["sel" + k] = fake("sel" + k); objects["man" + k] = fake("man" + k); }
    ["on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"].forEach((key) => { for (let k = 0; k < 8; k++) objects["p" + k + "_" + key] = fake("p" + k + "_" + key); });
    ["lane_title", "name_edit", "desc_edit", "code_edit", "interp", "msg", "preview"].forEach((n) => { sub[n] = fake(n); });
    objects.tools.subpatcher = () => ({ getnamed: (n) => sub[n] || null });
    const dicts = {};
    let dictCount = 0;
    function Dict(name) { this.name = name || ("d" + (++dictCount)); dicts[this.name] = dicts[this.name] || {}; }
    Dict.prototype.set = function (k, v) { dicts[this.name][k] = v; };
    Dict.prototype.get = function (k) { return dicts[this.name][k]; };
    function File(path, mode) {
        this.path = path; this.mode = mode; this.isopen = !opts.noFile;
        if (mode === "write") { files[path] = { bytes: null, text: null }; }
        this.position = 0; this.eof = mode === "read" && files[path] ? files[path].text.length : 0;
    }
    File.prototype.writebytes = function (b) { files[this.path].bytes = plain(b); };
    File.prototype.writestring = function (s) { files[this.path].text = s; };
    File.prototype.readstring = function (n) { const s = files[this.path].text.substr(this.position, n); this.position += s.length; return s; };
    File.prototype.close = function () {};
    function LiveAPI() {}
    LiveAPI.prototype.get = (k) => live[k];
    const G = load(["core.js", "engine.js", "glue.js"], {
        outlet: (n, v) => out.push([n, v]), post: () => {}, Dict, File, LiveAPI,
        patcher: { getnamed: (n) => objects[n] || null }, Date: function () { this.getTime = () => T.now; }
    });
    return { G, out, objects, sub, files, live, T, dicts };
}

test("messages de reglage : la ligne 3 envoie un CC sur le bon canal / numero, valeur en dernier", () => {
    const { G, out } = setup();
    G.p(2, "on", 1); G.p(2, "smooth", 0);
    G.bang();
    assert.deepStrictEqual(plain(out.map((o) => o[0])), [2, 1, 0], "droite a gauche : canal, CC, valeur");
    assert.strictEqual(out[0][1], 16); assert.strictEqual(out[1][1], 22);
});

test("onglets : seuls les reglages de la ligne choisie sont visibles", () => {
    const { G, objects } = setup();
    G.select(3);
    assert.strictEqual(objects.p3_min.hidden, false); assert.strictEqual(objects.man3.hidden, false);
    assert.strictEqual(objects.p2_min.hidden, true); assert.strictEqual(objects.man2.hidden, true);
    assert.strictEqual(objects.p7_on.hidden, true);
    G.select(7);
    assert.strictEqual(objects.p3_cc.hidden, true); assert.strictEqual(objects.p7_cc.hidden, false);
});

test("bang : suit le transport et le temps de Live, et seulement a la lecture", () => {
    const { G, out, live } = setup();
    G.p(0, "on", 1); G.p(0, "smooth", 0); G.p(0, "bars", 1);
    G.model.lanes[0].curve = G.preset(1, 4);
    live.current_song_time = [2]; G.bang();            // 2 temps sur une mesure de 4 : moitie
    assert.strictEqual(out[2][1], 64);
    out.length = 0; live.is_playing = [0]; live.current_song_time = [3]; G.bang();
    assert.strictEqual(out.length, 0, "arret : rien");
    live.is_playing = [1]; live.signature_numerator = [3]; live.signature_denominator = [4];
    for (let k = 0; k < 60; k++) G.bang();             // la signature est relue periodiquement
    assert.strictEqual(G.beatsPerBar, 3);
});

test("Live absent ou valeurs invalides : pas de plantage", () => {
    const { G, live } = setup();
    G.p(0, "on", 1);
    live.current_song_time = [NaN]; G.bang();
    live.is_playing = undefined; G.bang();
});

test("ready : demande l'etat, arme le mode manuel apres un delai ; l'etat est restaure par dictionary", () => {
    const { G, objects, dicts } = setup();
    const src = setup().G;
    src.model.rename(4, "Resonance"); src.model.applyPreset(4, 2);
    dicts.saved = { json: src.model.serialize() };
    G.ready();
    assert.deepStrictEqual(objects.state.log[0], ["bang"]);
    G.dictionary("saved");
    assert.strictEqual(G.model.lanes[4].name, "Resonance");
    G.p(1, "value", 10);                                // pendant le delai : pas manuel
    assert.strictEqual(G.model.lanes[1].manual, false);
    for (let k = 0; k < 40; k++) G.bang();
    G.p(1, "value", 11);
    assert.strictEqual(G.model.lanes[1].manual, true);
    assert.ok(objects.man1.log.some((l) => l[0] === "text" && l[1] === "MAN"));
});

test("sauvegarde : une modification est ecrite dans le dict 500 ms plus tard, puis plus rien", () => {
    const { G, objects, dicts, T } = setup();
    G.model.rename(0, "A");
    G.bang(); assert.strictEqual(objects.state.log.length, 0);
    T.now += 600; G.bang();
    const msg = objects.state.log[objects.state.log.length - 1];
    assert.strictEqual(msg[0], "dictionary");
    assert.ok(JSON.parse(dicts[msg[1]].json).lanes[0].name === "A");
    const n = objects.state.log.length; T.now += 2000; G.bang();
    assert.strictEqual(objects.state.log.length, n, "rien de nouveau a sauvegarder");
});

test("editeur : ui_curve et ui_points modifient la ligne et renvoient la vue", () => {
    const { G, objects } = setup();
    G.select(3);
    const d = G.preset(2, 4);
    G.ui_curve(3, G.encodeCurve(d));
    assert.ok(Math.abs(G.model.lanes[3].curve.y[0] - 1) < 0.01);
    G.ui_points(3, "0,0,0,0;0.5,1,0.3,2;1,0,0,0");
    assert.strictEqual(G.model.lanes[3].pointMode, true);
    const lastView = objects.editor.log.filter((l) => l[0] === "view").pop();
    assert.strictEqual(lastView[1], 3); assert.strictEqual(lastView[4], 1);
    G.ui_points(3, "n'importe quoi");
    G.ui_curve(3, "zz");
});

test("barre d'outils : boutons, menu de formes, quantites de variation / lissage", () => {
    const { G } = setup();
    G.select(1);
    G.btn("lock", 0); assert.strictEqual(G.model.lanes[1].locked, false, "valeur 0 = relachement : ignore");
    G.btn("lock"); assert.strictEqual(G.model.lanes[1].locked, true, "sans valeur (bang) : declenche"); G.btn("lock", 1);
    G.btn("lock", 1); assert.strictEqual(G.model.lanes[1].locked, true); G.btn("lock", 1);
    G.shape_preset(3); assert.ok(Math.abs(G.model.lanes[1].curve.y[0] - 1) < 1e-9);
    G.btn("points", 1); assert.strictEqual(G.model.lanes[1].pointMode, true);
    G.btn("free", 1); assert.strictEqual(G.model.lanes[1].pointMode, false);
    G.vary_amount(30); assert.ok(Math.abs(G.model.varyAmount - 0.3) < 1e-9);
    G.smooth_amount(250); assert.strictEqual(G.model.smoothAmount, 1);
    const before = G.model.lanes[1].curve.y.slice(0);
    G.btn("vary", 1); assert.notDeepStrictEqual(G.model.lanes[1].curve.y, before);
    G.btn("undo", 1); assert.deepStrictEqual(G.model.lanes[1].curve.y, before);
    G.btn("copy", 1); G.select(5); G.btn("paste", 1);
    assert.deepStrictEqual(G.model.lanes[5].curve.y, before);
    G.btn("inconnu", 1); G.shape_preset(99);
});

test("fenetre Outils : decrire, previsualiser, appliquer ; code avance multi-ligne ; nom", () => {
    const { G, sub, objects } = setup();
    G.select(0);
    G.text("desc", "ouvre", "sur", "2", "mesures", "puis", "ferme");
    G.tools("apply_desc");
    assert.ok(/Previsualiser/.test(sub.msg.log.pop()[1]), "il faut previsualiser d'abord");
    G.tools("preview_desc");
    assert.ok(/Position/.test(sub.interp.log.pop()[1]));
    assert.strictEqual(sub.preview.log[0][0], "view");
    G.tools("apply_desc");
    assert.strictEqual(G.model.lanes[0].motionText, "ouvre sur 2 mesures puis ferme");
    assert.ok(/appliquee/.test(sub.msg.log.pop()[1]));
    G.text("desc", "bonjour"); G.tools("preview_desc");
    assert.ok(/Commencer par ouvre/.test(sub.msg.log.pop()[1]));
    G.text("code", "duration:", "2", "bars", "start:", "50%", "hold", "over", "2", "bars");
    G.tools("preview_code"); G.tools("apply_code");
    assert.strictEqual(G.model.lanes[0].script, "duration: 2 bars\nstart: 50%\nhold over 2 bars");
    assert.strictEqual(G.model.lanes[0].params.bars, 2);
    G.text("name", "text", "Cutoff", "dub"); G.tools("rename");
    assert.strictEqual(G.model.lanes[0].name, "Cutoff dub");
    G.btn("tools", 1);
    assert.deepStrictEqual(objects.tools.log.pop(), ["open"]);
});

test("export MIDI : le chemin choisi recoit un fichier .mid valide", () => {
    const { G, objects, files } = setup();
    G.select(0); G.p(0, "bars", 1);
    G.tools("export_mid");
    assert.deepStrictEqual(objects.savedlg.log.pop(), ["bang"]);
    G.dialog_path("/tmp/courbe");
    const f = files["/tmp/courbe.mid"];
    assert.ok(f && f.bytes && f.bytes.length > 50);
    assert.deepStrictEqual(f.bytes.slice(0, 4), [0x4D, 0x54, 0x68, 0x64]);
    G.dialog_path("/tmp/oublie.mid");                  // sans action en attente : ignore
    assert.ok(!files["/tmp/oublie.mid"]);
});

test("export / import de session par fichier JSON", () => {
    const { G, objects, files, sub } = setup();
    G.model.rename(6, "Drive"); G.p(6, "min", 33);
    G.tools("export_session"); G.dialog_path("/tmp/set");
    const text = files["/tmp/set.json"].text;
    assert.strictEqual(JSON.parse(text).lanes[6].name, "Drive");
    const b = setup();
    b.files["/tmp/set.json"] = { text };
    b.G.tools("import_session");
    assert.deepStrictEqual(b.objects.opendlg.log.pop(), ["bang"]);
    b.G.dialog_path("/tmp/set.json");
    assert.strictEqual(b.G.model.lanes[6].name, "Drive");
    assert.strictEqual(b.G.model.lanes[6].params.min, 33);
    assert.ok(b.objects.p6_min.log.some((l) => l[0] === "set" && l[1] === 33), "le controle Live affiche la valeur importee");
    b.files["/tmp/mauvais.json"] = { text: "pas du json" };
    b.G.tools("import_session"); b.G.dialog_path("/tmp/mauvais.json");
    assert.ok(/Echec/.test(b.sub.msg.log.pop()[1]));
    b.G.tools("import_session"); b.G.dialog_path("cancel");
});

test("fichier impossible a ouvrir : message d'echec", () => {
    const { G, sub } = setup({ noFile: true });
    G.tools("export_mid"); G.dialog_path("/ro/x");
    assert.ok(/Echec/.test(sub.msg.log.pop()[1]));
});

test("noms de reglages inconnus et lignes hors limites ne plantent pas", () => {
    const { G } = setup();
    G.p(0, "n_importe_quoi", 3); G.p(77, "on", 1); G.select(99); G.resume(50);
    assert.strictEqual(G.model.selected, 7);
});

console.log("\n" + ok + " tests passes");
