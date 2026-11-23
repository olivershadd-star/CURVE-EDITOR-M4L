// Tests de la colle Max (src/glue.js) avec de faux objets Max : sorties, messages vers la fenetre, LiveAPI, fichiers.
// Usage : node tests/test_glue.js
"use strict";
const assert = require("assert");
const { load } = require("./loader");

let ok = 0;
function test(name, fn) { fn(); ok++; console.log("ok  -", name); }
const plain = (x) => JSON.parse(JSON.stringify(x));
const enc = encodeURIComponent;

function setup(opts) {
    opts = opts || {};
    const out = [], objects = {}, files = {}, T = { now: 1000000 };
    const live = { is_playing: [1], current_song_time: [0], signature_numerator: [4], signature_denominator: [4], tempo: [120] };
    function fake(name) { return { name, log: [], message(...a) { this.log.push(plain(a)); } }; }
    ["state", "savedlg", "opendlg", "status"].forEach((n) => { objects[n] = fake(n); });
    ["on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"].forEach((key) => { for (let k = 0; k < 8; k++) objects["p" + k + "_" + key] = fake("p" + k + "_" + key); });
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
        outlet: (n, ...v) => out.push([n, ...v]), post: () => {}, Dict, File, LiveAPI,
        patcher: { getnamed: (n) => objects[n] || null }, Date: function () { this.getTime = () => T.now; }
    });
    const ui = () => out.filter((o) => o[0] === 3).map((o) => o.slice(1));
    const lastUi = (name) => ui().filter((m) => m[0] === name).pop();
    return { G, out, objects, files, live, T, dicts, ui, lastUi };
}

test("reglages : la ligne 3 allumee envoie son CC sur le bon canal, valeur en dernier", () => {
    const { G, out } = setup();
    G.p(2, "on", 1); G.p(2, "smooth", 0);
    G.bang();
    const cc = out.filter((o) => o[0] < 3);
    assert.deepStrictEqual(plain(cc.map((o) => o[0])), [2, 1, 0], "droite a gauche : canal, CC, valeur");
    assert.strictEqual(cc[0][1], 16); assert.strictEqual(cc[1][1], 22);
});

test("bang : suit le transport et le temps de Live, et seulement a la lecture", () => {
    const { G, out, live } = setup();
    G.p(0, "on", 1); G.p(0, "smooth", 0); G.p(0, "bars", 1);
    G.model.lanes[0].curve = G.preset(1, 4);
    live.current_song_time = [2]; G.bang();
    out.length = 0; live.is_playing = [0]; live.current_song_time = [3]; G.bang();
    assert.strictEqual(out.filter((o) => o[0] < 3).length, 0, "arret : rien");
    live.is_playing = [1]; live.signature_numerator = [3]; live.signature_denominator = [4];
    for (let k = 0; k < 60; k++) G.bang();
    assert.strictEqual(G.beatsPerBar, 3);
});

test("la tete de lecture part vers la fenetre toutes les 4 images, -1 a l'arret", () => {
    const { G, ui, live } = setup();
    G.p(0, "on", 1);
    for (let k = 0; k < 4; k++) G.bang();
    assert.ok(ui().some((m) => m[0] === "playhead" && m[1] >= 0));
    live.is_playing = [0];
    for (let k = 0; k < 4; k++) G.bang();
    assert.strictEqual(ui().filter((m) => m[0] === "playhead").pop()[1], -1);
});

test("Live absent ou valeurs invalides : pas de plantage", () => {
    const { G, live } = setup();
    G.p(0, "on", 1);
    live.current_song_time = [NaN]; G.bang();
    live.is_playing = undefined; G.bang();
});

test("ready : demande l'etat, arme le manuel apres un delai ; l'etat est restaure par dictionary", () => {
    const { G, objects, dicts, lastUi } = setup();
    const src = setup().G;
    src.model.rename(4, "Resonance"); src.model.applyPreset(4, 2);
    dicts.saved = { json: src.model.serialize() };
    G.ready();
    assert.deepStrictEqual(objects.state.log[0], ["bang"]);
    G.dictionary("saved");
    assert.strictEqual(G.model.lanes[4].name, "Resonance");
    G.p(1, "value", 10);
    assert.strictEqual(G.model.lanes[1].manual, false, "pas manuel pendant le delai");
    for (let k = 0; k < 40; k++) G.bang();
    G.p(1, "value", 11);
    assert.strictEqual(G.model.lanes[1].manual, true);
    assert.deepStrictEqual(lastUi("lane_manual"), ["lane_manual", 1, 1]);
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
    assert.strictEqual(objects.state.log.length, n);
});

test("sync_all : tout l'etat part vers la fenetre (8 onglets, reglages, ligne choisie, textes, etat)", () => {
    const { G, ui } = setup();
    G.model.rename(2, "Cutoff dub");
    G.select(2);
    const before = ui().length; G.sync_all();
    const m = ui().slice(before);
    assert.strictEqual(m.filter((x) => x[0] === "tab").length, 8);
    assert.strictEqual(m.filter((x) => x[0] === "params").length, 8);
    const tab2 = m.filter((x) => x[0] === "tab" && x[1] === 2)[0];
    assert.strictEqual(tab2[2].length, 130, "65 points sur 8 bits"); assert.strictEqual(decodeURIComponent(tab2[3]), "Cutoff dub");
    const view = m.filter((x) => x[0] === "lane_view");
    assert.strictEqual(view.length, 1); assert.strictEqual(view[0][1], 2);
    assert.strictEqual(view[0].length, 10, "ligne, courbe, points, mode, verrou, mesures, phase, nom, manuel");
    assert.strictEqual(decodeURIComponent(m.filter((x) => x[0] === "fill")[0][1]), "Cutoff dub");
    assert.ok(m.some((x) => x[0] === "lane_selected" && x[1] === 2));
    assert.ok(m.some((x) => x[0] === "setstatus"));
});

test("editeur : ui_curve et ui_points modifient la ligne et renvoient la vue", () => {
    const { G, lastUi } = setup();
    G.select(3);
    G.ui_curve(3, G.encodeCurve(G.preset(2, 4)));
    assert.ok(Math.abs(G.model.lanes[3].curve.y[0] - 1) < 0.01);
    G.ui_points(3, "0,0,0,0;0.5,1,0.3,2;1,0,0,0");
    assert.strictEqual(G.model.lanes[3].pointMode, true);
    const v = lastUi("lane_view");
    assert.strictEqual(v[1], 3); assert.strictEqual(v[4], 1);
    G.ui_points(3, "n'importe quoi"); G.ui_curve(3, "zz");
});

test("changer un reglage, le nom ou l'etat 'allume' met l'onglet a jour", () => {
    const { G, ui } = setup();
    G.select(0);
    let n = ui().length; G.p(5, "on", 1);
    assert.ok(ui().slice(n).some((m) => m[0] === "tab" && m[1] === 5 && m[4] === 1));
    assert.ok(ui().slice(n).some((m) => m[0] === "params" && m[1] === 5 && m[2] === 1));
});

test("boutons, formes, quantites de variation / lissage", () => {
    const { G } = setup();
    G.select(1);
    G.btn("lock", 0); assert.strictEqual(G.model.lanes[1].locked, false, "valeur 0 = relachement : ignore");
    G.btn("lock"); assert.strictEqual(G.model.lanes[1].locked, true, "sans valeur (bang) : declenche"); G.btn("lock", 1);
    G.set_preset(2); assert.ok(Math.abs(G.model.lanes[1].curve.y[0] - 1) < 1e-9);
    G.btn("points", 1); assert.strictEqual(G.model.lanes[1].pointMode, true);
    G.btn("free", 1); assert.strictEqual(G.model.lanes[1].pointMode, false);
    G.vary_amount(30); assert.ok(Math.abs(G.model.varyAmount - 0.3) < 1e-9);
    G.smooth_amount(250); assert.strictEqual(G.model.smoothAmount, 1);
    const before = G.model.lanes[1].curve.y.slice(0);
    G.btn("vary", 1); assert.notDeepStrictEqual(G.model.lanes[1].curve.y, before);
    G.btn("undo", 1); assert.deepStrictEqual(G.model.lanes[1].curve.y, before);
    G.btn("copy", 1); G.select(5); G.btn("paste", 1);
    assert.deepStrictEqual(G.model.lanes[5].curve.y, before);
    G.btn("inconnu", 1); G.set_preset(99); G.set_preset(-1);
});

test("page Decrire / Code : previsualiser, appliquer, code multi-ligne, nom", () => {
    const { G, ui, lastUi } = setup();
    G.select(0);
    G.text("desc", enc("ouvre sur 2 mesures puis ferme"));
    G.tools("apply_desc");
    assert.ok(/Previsualiser/.test(decodeURIComponent(lastUi("say")[2])), "il faut previsualiser d'abord");
    G.tools("preview_desc");
    assert.ok(/Position/.test(decodeURIComponent(lastUi("say")[1])));
    assert.ok(lastUi("preview_curve")[1].length === 4098);
    G.tools("apply_desc");
    assert.strictEqual(G.model.lanes[0].motionText, "ouvre sur 2 mesures puis ferme");
    assert.ok(/appliquee/.test(decodeURIComponent(lastUi("say")[2])));
    assert.strictEqual(decodeURIComponent(lastUi("fill")[2]), "ouvre sur 2 mesures puis ferme");
    G.text("desc", enc("bonjour")); G.tools("preview_desc");
    assert.ok(/Commencer par ouvre/.test(decodeURIComponent(lastUi("say")[2])));
    G.text("code", enc("duration: 2 bars\nstart: 50%\nhold over 2 bars"));
    G.tools("preview_code"); G.tools("apply_code");
    assert.strictEqual(G.model.lanes[0].script, "duration: 2 bars\nstart: 50%\nhold over 2 bars");
    assert.strictEqual(G.model.lanes[0].params.bars, 2);
    G.text("name", enc("Cutoff dub")); G.tools("rename");
    assert.strictEqual(G.model.lanes[0].name, "Cutoff dub");
    assert.strictEqual(decodeURIComponent(lastUi("fill")[1]), "Cutoff dub");
    G.text("code", enc("")); G.tools("preview_code");
    assert.ok(lastUi("say"));
});

test("l'etat texte est envoye avec un encodage sur : accents, virgules, vide", () => {
    const { G, lastUi } = setup();
    G.model.rename(0, "Fréquence, test; ok");
    G.sync_all();
    assert.strictEqual(decodeURIComponent(lastUi("fill")[1]), "Fréquence, test; ok");
    G.model.rename(0, ""); G.sync_all();
    assert.strictEqual(decodeURIComponent(lastUi("fill")[1]), "Courbe 1", "un nom vide redevient le nom par defaut");
    assert.strictEqual(lastUi("fill")[2], "%00", "texte vide");
});

test("le bandeau Live recoit l'etat en clair", () => {
    const { G, objects } = setup();
    G.model.say("Courbe 1 copiee.");
    assert.deepStrictEqual(objects.status.log.pop(), ["set", "Courbe 1 copiee."]);
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
    G.dialog_path("/tmp/oublie.mid");
    assert.ok(!files["/tmp/oublie.mid"]);
});

test("export / import de session par fichier JSON", () => {
    const { G, files } = setup();
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
    assert.ok(b.ui().some((m) => m[0] === "tab" && m[1] === 6 && decodeURIComponent(m[3]) === "Drive"), "la fenetre est remise a jour");
    b.files["/tmp/mauvais.json"] = { text: "pas du json" };
    b.G.tools("import_session"); b.G.dialog_path("/tmp/mauvais.json");
    assert.ok(/Echec/.test(decodeURIComponent(b.lastUi("say")[2])));
    b.G.tools("import_session"); b.G.dialog_path("cancel");
});

test("fichier impossible a ouvrir : message d'echec", () => {
    const { G, lastUi } = setup({ noFile: true });
    G.tools("export_mid"); G.dialog_path("/ro/x");
    assert.ok(/Echec/.test(decodeURIComponent(lastUi("say")[2])));
});

test("noms de reglages inconnus et lignes hors limites ne plantent pas", () => {
    const { G } = setup();
    G.p(0, "n_importe_quoi", 3); G.p(77, "on", 1); G.select(99); G.resume(50);
    assert.strictEqual(G.model.selected, 7);
});

console.log("\n" + ok + " tests passes");
