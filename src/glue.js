// Curve Editor M4L - colle Max pour le moteur (objet [js] "engine")
// ANKS Labs
//
// Concatene apres core.js et engine.js par tools/build_device.py.
// Sorties : 0 = valeur CC, 1 = numero de CC, 2 = canal (vers [ctlout], de droite a gauche),
//           3 = messages vers la fenetre d'edition et le bandeau ([s ---toui]).
// Entree  : les messages de la fenetre arrivent par [r ---ui] ; ceux des controles Live par [prepend p ...].
// Tout le texte envoye a la fenetre est encode (encodeURIComponent) ; "%00" = texte vide.

inlets = 1;
outlets = 4;

var PARAM_NAMES = ["on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"];
var liveApi = null, lastTick = 0, tickCount = 0, beatsPerBar = 4, armCountdown = 0, dirtySince = 0;
var pendingFile = "", pendingMotion = null;
var cache = { desc: "", code: "", name: "" };

function mobj(name) {
    var o = null;
    try { o = patcher.getnamed(name); } catch (e) { o = null; }
    return o;
}
function sendTo(o, args) {
    if (!o) { return; }
    try {
        switch (args.length) {
            case 1: o.message(args[0]); break;
            case 2: o.message(args[0], args[1]); break;
            case 3: o.message(args[0], args[1], args[2]); break;
            default: o.message(args[0], args[1], args[2], args[3]); break;
        }
    } catch (e) { post("Curve Editor : message refuse : " + e + "\n"); }
}
function enc(s) { s = String(s); return s.length > 0 ? encodeURIComponent(s) : "%00"; }
function decodeText(s) {
    var t;
    try { t = decodeURIComponent(String(s)); } catch (e) { t = String(s); }
    return t === "\u0000" ? "" : t;
}

// message vers la fenetre d'edition (et le bandeau)
function toUi() {
    var args = [3], k;
    for (k = 0; k < arguments.length; k++) { args.push(arguments[k]); }
    outlet.apply(this, args);
}

// courbe reduite (65 points, 8 bits) pour les onglets
function miniHex(d) {
    var out = "", k, v;
    for (k = 0; k <= 64; k++) {
        v = Math.round(clamp01(d.y[k * 32]) * 255);
        out += (v < 16 ? "0" : "") + v.toString(16);
    }
    return out;
}
function viewArgs(i, m) {
    var l = m.lanes[i];
    return [i, encodeCurve(l.curve), encodePoints(l.points) || "-", l.pointMode ? 1 : 0, l.locked ? 1 : 0,
        l.params.bars, l.params.offset, enc(l.name), l.manual ? 1 : 0];
}

var io = {
    cc: function (ch, cc, v) { outlet(2, ch); outlet(1, cc); outlet(0, v); },
    setParam: function (i, key, v) { sendTo(mobj("p" + i + "_" + key), ["set", v]); },
    params: function (i, m) {
        var l = m.lanes[i], p = l.params;
        toUi("params", i, p.on, p.min, p.max, p.bars, p.offset, p.smooth, p.depth, p.value, l.cc, l.channel);
    },
    view: function (i, m) {
        var l = m.lanes[i];
        toUi("tab", i, miniHex(l.curve), enc(l.name), l.params.on);
        if (i === m.selected) { toUi.apply(this, ["lane_view"].concat(viewArgs(i, m))); }
    },
    selected: function (i) { toUi("lane_selected", i); fillTexts(model); },
    manual: function (i, flag) { toUi("lane_manual", i, flag ? 1 : 0); },
    status: function (text) { toUi("setstatus", enc(text)); sendTo(mobj("status"), ["set", text]); }
};

var model = createModel(io);

// ---------- messages venant des controles Live : p <ligne> <reglage> <valeur> ----------
function laneOf(i) { i = Math.floor(Number(i)); return clamp(isFinite(i) ? i : 0, 0, LANE_COUNT - 1); }

function p(lane, key, value) {
    if (PARAM_NAMES.indexOf(String(key)) === -1) { return; }
    model.setParam(Number(lane), String(key), Number(value));
}
function select(i) { model.select(laneOf(i)); }

// ---------- etat complet envoye a la fenetre ----------
function sync_all() {
    var k;
    for (k = 0; k < LANE_COUNT; k++) { io.view(k, model); io.params(k, model); io.manual(k, model.lanes[k].manual); }
    toUi("lane_selected", model.selected);
    fillTexts(model);
    toUi("setstatus", enc(model.status || "Curve Editor M4L : actif."));
}

// ---------- chargement : restauration de l'etat enregistre avec le set ----------
function ready() {
    var d = mobj("state");
    armCountdown = 40;                       // le "manuel" n'est arme qu'apres la restauration des reglages
    if (d) { sendTo(d, ["bang"]); }
    model.say("Curve Editor M4L : actif.");
    sync_all();
}
function dictionary(name) {
    var d, json;
    try { d = new Dict(String(name)); json = d.get("json"); } catch (e) { return; }
    if (typeof json === "string" && json.length > 0) {
        if (model.restore(json)) { model.say("Etat restaure."); sync_all(); }
    }
}
function saveState() {
    var d, st = mobj("state");
    if (!st) { return; }
    try { d = new Dict(); d.set("json", model.serialize()); sendTo(st, ["dictionary", d.name]); } catch (e) { post("Curve Editor : sauvegarde impossible : " + e + "\n"); }
}

// ---------- Live : position et tempo ----------
function firstNumber(v) { return (v !== null && v !== undefined && v.length !== undefined) ? Number(v[0]) : Number(v); }
function getLive() {
    if (liveApi === null) { try { liveApi = new LiveAPI("live_set"); } catch (e) { liveApi = null; } }
    return liveApi;
}
function bang() {
    var now = new Date().getTime(), dt = lastTick > 0 ? clamp((now - lastTick) / 1000, 0, 0.25) : 0, a = getLive();
    var playing = false, beats = 0, n, d;
    lastTick = now;
    if (armCountdown > 0) { armCountdown--; if (armCountdown === 0) { model.armed = true; } }
    if (a) {
        try {
            playing = firstNumber(a.get("is_playing")) === 1;
            beats = firstNumber(a.get("current_song_time"));
            if (tickCount % 50 === 0) {
                n = firstNumber(a.get("signature_numerator")); d = firstNumber(a.get("signature_denominator"));
                if (n > 0 && d > 0) { beatsPerBar = n * 4 / d; }
            }
        } catch (e) { playing = false; }
    }
    if (!isFinite(beats)) { playing = false; beats = 0; }
    tickCount++;
    model.tick(playing, beats, beatsPerBar, dt);
    if (tickCount % 4 === 0) { toUi("playhead", playing ? model.playheadPhase(beats, beatsPerBar) : -1); }
    if (model.dirty) {
        if (dirtySince === 0) { dirtySince = now; }
        else if (now - dirtySince > 500) { saveState(); model.dirty = false; dirtySince = 0; }
    }
}

// ---------- edition venant de la fenetre ----------
function ui_curve(lane, hex) {
    var d = decodeCurve(String(hex), 4);
    lane = laneOf(lane);
    if (d) { model.setDrawnCurve(lane, d); }
}
function ui_points(lane, str) {
    var pts;
    lane = laneOf(lane);
    try { pts = String(str) === "-" ? [] : decodePoints(String(str)); } catch (e) { model.say(e.message); return; }
    try { if (pts.length >= 2) { model.replacePoints(lane, pts); } } catch (e2) { model.say(e2.message); }
}

// boutons : btn <nom> [1]  (la valeur 0 = relachement : ignoree)
function btn(name, value) {
    if (value !== undefined && Number(value) !== 1) { return; }
    var i = model.selected, l = model.lanes[i];
    switch (String(name)) {
        case "free": model.setPointMode(i, false); break;
        case "points": model.setPointMode(i, true); break;
        case "copy": model.copy(i); break;
        case "paste": model.paste(i); break;
        case "undo": model.undo(i); break;
        case "lock": model.toggleLock(i); break;
        case "invert": model.invert(i); break;
        case "vary": model.applyVariation(i, model.varyAmount); break;
        case "smooth": model.smoothCurve(i, model.smoothAmount); break;
        case "resume": model.resume(i); break;
        default: break;
    }
    if (l && l.locked) { model.say("Ligne " + (i + 1) + " verrouillee."); }
}
function resume(i, v) { if (v === undefined || Number(v) === 1) { model.resume(laneOf(i)); } }
// forme de depart : 0 vague, 1 rampe +, 2 rampe -, 3 triangle, 4 douce, 5 paliers
function set_preset(n) { n = Math.floor(Number(n)); if (n >= 0 && n <= 5) { model.applyPreset(model.selected, n); } }
function vary_amount(v) { model.varyAmount = clamp(Number(v), 0, 100) * 0.01; }
function smooth_amount(v) { model.smoothAmount = clamp(Number(v), 0, 100) * 0.01; }

// ---------- page "Decrire / Code" ----------
function joinArgs(args, from) { var out = [], k; for (k = from; k < args.length; k++) { out.push(String(args[k])); } return out.join(" "); }
// text <desc|code|name> <texte encode>
function text(which) { cache[String(which)] = decodeText(joinArgs(arguments, 1)); }

function fillTexts(m) {
    var l = m.lanes[m.selected];
    toUi("fill", enc(l.name), enc(l.motionText), enc(l.script));
}
function toolsSay(interp, message) { toUi("say", enc(interp), enc(message)); }
function previewScript(compiled, mode, original, explanation) {
    var d = parseScript(compiled);
    if (d.bars < 0.25 || d.bars > 32 || Math.abs(d.bars * 4 - Math.round(d.bars * 4)) > 1e-6) {
        fail("Duree : 0.25 a 32 mesures, pas de 0.25.");
    }
    pendingMotion = { mode: mode, compiled: compiled, original: original };
    toUi("preview_curve", encodeCurve(d), d.bars);
    toolsSay(explanation, "Proposition : la courbe actuelle reste inchangee.");
}
function tools(cmd) {
    var i = model.selected, l = model.lanes[i], r, t, ok;
    try {
        switch (String(cmd)) {
            case "preview_desc":
                r = translateMotion(cache.desc, l.params.bars, l.curve.y[0]);
                previewScript(r.script, "desc", cache.desc, r.explanation);
                break;
            case "preview_code":
                t = reflowScript(cache.code);
                previewScript(t, "code", t, "Code valide. Verifier l'apercu avant d'appliquer.");
                break;
            case "apply_desc":
            case "apply_code":
                if (!pendingMotion || pendingMotion.mode !== (String(cmd) === "apply_desc" ? "desc" : "code")) { toolsSay("", "Previsualiser d'abord."); break; }
                ok = model.applyScript(i, pendingMotion.compiled, pendingMotion.mode === "desc" ? pendingMotion.original : "");
                if (ok.ok) { pendingMotion = null; fillTexts(model); }
                toolsSay("", ok.ok ? "Courbe appliquee." : ok.error);
                break;
            case "rename":
                model.rename(i, cache.name); fillTexts(model); toolsSay("", "Nom enregistre.");
                break;
            case "export_mid":
                pendingFile = "mid"; sendTo(mobj("savedlg"), ["bang"]);
                break;
            case "export_session":
                pendingFile = "session_save"; sendTo(mobj("savedlg"), ["bang"]);
                break;
            case "import_session":
                pendingFile = "session_load"; sendTo(mobj("opendlg"), ["bang"]);
                break;
            default: break;
        }
    } catch (e) { toolsSay("", e.message); }
}

// ---------- fichiers ----------
function writeFile(path, bytes, asText) {
    var f = new File(path, "write");
    if (!f.isopen) { return false; }
    try { f.eof = 0; } catch (e) { /* tronquer n'est pas indispensable */ }
    if (asText) { f.writestring(bytes); } else { f.writebytes(bytes); }
    f.close();
    return true;
}
function readFile(path) {
    var f = new File(path, "read"), s = "";
    if (!f.isopen) { return null; }
    while (f.position < f.eof) { s += f.readstring(4096); }
    f.close();
    return s;
}
function withExtension(path, ext) { return /\.[A-Za-z0-9]+$/.test(path) ? path : path + ext; }

function dialog_path(path) {
    var what = pendingFile, file = String(path), a = getLive(), bpb = beatsPerBar, bpm = 120, bytes, text2, data;
    pendingFile = "";
    if (file.length === 0 || file === "cancel") { return; }
    try {
        if (what === "mid") {
            if (a) { bpm = firstNumber(a.get("tempo")); }
            bytes = model.exportMidi(model.selected, bpb, bpm);
            file = withExtension(file, ".mid");
            toolsSay("", writeFile(file, bytes, false) ? "Courbe MIDI exportee : " + file : "Echec de l'export MIDI.");
        } else if (what === "session_save") {
            file = withExtension(file, ".json");
            toolsSay("", writeFile(file, JSON.stringify(model.toSession(true)), true) ? "Session exportee : " + file : "Echec de l'export.");
        } else if (what === "session_load") {
            text2 = readFile(file);
            if (text2 === null) { toolsSay("", "Fichier illisible."); return; }
            data = JSON.parse(text2);
            if (model.fromSession(data, true)) { sync_all(); toolsSay("", "Session importee."); }
            else { toolsSay("", "Ce fichier n'est pas une session Curve Editor M4L."); }
        }
    } catch (e) { toolsSay("", "Echec : " + e.message); }
}
