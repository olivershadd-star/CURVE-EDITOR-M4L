// Curve Editor M4L - colle Max pour le moteur (objet [js] "engine")
// ANKS Labs
//
// Concatene apres core.js et engine.js par tools/build_device.py.
// Sorties : 0 = valeur CC, 1 = numero de CC, 2 = canal (vers [ctlout], branchees de droite a gauche).
// Tout le reste passe par patcher.getnamed(<nom de script>) : aucun nom global, donc plusieurs appareils cote a cote.

inlets = 1;
outlets = 3;

var PARAM_NAMES = ["on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"];
var liveApi = null, lastTick = 0, tickCount = 0, beatsPerBar = 4, armCountdown = 0, dirtySince = 0;
var pendingFile = "", pendingMotion = null;
var cache = { desc: "", code: "", name: "" };

function mobj(name) {
    var o = null;
    try { o = patcher.getnamed(name); } catch (e) { o = null; }
    return o;
}
function subobj(sub, name) {
    var host = mobj(sub), p = null, o = null;
    if (!host) { return null; }
    try { p = host.subpatcher(); o = p ? p.getnamed(name) : null; } catch (e) { o = null; }
    return o;
}
function sendTo(o, args) {
    if (!o) { return; }
    try {
        switch (args.length) {
            case 1: o.message(args[0]); break;
            case 2: o.message(args[0], args[1]); break;
            case 3: o.message(args[0], args[1], args[2]); break;
            case 4: o.message(args[0], args[1], args[2], args[3]); break;
            case 5: o.message(args[0], args[1], args[2], args[3], args[4]); break;
            case 6: o.message(args[0], args[1], args[2], args[3], args[4], args[5]); break;
            case 7: o.message(args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;
            case 8: o.message(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;
            case 9: o.message(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;
            default: o.message(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;
        }
    } catch (e) { post("Curve Editor : message refuse : " + e + "\n"); }
}
function textOf(o, str) { sendTo(o, ["set", encodeURIComponent(str)]); }
function decodeText(s) { try { return decodeURIComponent(String(s)); } catch (e) { return String(s); } }

function viewArgs(i, m) {
    var l = m.lanes[i];
    return ["view", i, encodeCurve(l.curve), encodePoints(l.points) || "-", l.pointMode ? 1 : 0, l.locked ? 1 : 0,
        l.params.bars, l.params.offset, encodeURIComponent(l.name), l.manual ? 1 : 0];
}

// onglets : seuls les reglages de la ligne affichee sont visibles (les 8 jeux sont superposes)
function showLane(k, visible) {
    var j, o;
    for (j = 0; j < PARAM_NAMES.length + 1; j++) {
        o = mobj("p" + k + "_" + (j < PARAM_NAMES.length ? PARAM_NAMES[j] : "x"));
        if (j === PARAM_NAMES.length) { o = mobj("man" + k); }
        if (o) { try { o.hidden = !visible; } catch (e) { /* ignore */ } }
    }
}

var io = {
    cc: function (ch, cc, v) { outlet(2, ch); outlet(1, cc); outlet(0, v); },
    setParam: function (i, key, v) { sendTo(mobj("p" + i + "_" + key), ["set", v]); },
    view: function (i, m) {
        sendTo(mobj("editor"), viewArgs(i, m));
        fillTools(m);
    },
    selected: function (i) {
        var k;
        for (k = 0; k < LANE_COUNT; k++) {
            sendTo(mobj("sel" + k), ["set", k === i ? 1 : 0]);
            showLane(k, k === i);
        }
    },
    manual: function (i, flag) { sendTo(mobj("man" + i), ["text", flag ? "MAN" : "AUTO"]); },
    status: function (text) { sendTo(mobj("status"), ["set", text]); }
};

var model = createModel(io);

// ---------- messages venant des controles Live : p <ligne> <reglage> <valeur> ----------
function laneOf(i) { i = Math.floor(Number(i)); return clamp(isFinite(i) ? i : 0, 0, LANE_COUNT - 1); }

function p(lane, key, value) {
    if (PARAM_NAMES.indexOf(String(key)) === -1) { return; }
    model.setParam(Number(lane), String(key), Number(value));
}
function select(i) { model.select(laneOf(i)); }

// ---------- chargement : restauration de l'etat enregistre avec le set ----------
function ready() {
    var d = mobj("state");
    armCountdown = 40;                       // le "manuel" n'est arme qu'apres la restauration des reglages
    if (d) { sendTo(d, ["bang"]); }
    model.select(model.selected);
    var k;
    for (k = 0; k < LANE_COUNT; k++) { io.manual(k, model.lanes[k].manual); }
    model.say("Curve Editor M4L : actif.");
}
function dictionary(name) {
    var d, json;
    try { d = new Dict(String(name)); json = d.get("json"); } catch (e) { return; }
    if (typeof json === "string" && json.length > 0) {
        if (model.restore(json)) { model.say("Etat restaure."); }
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
    var playing = false, beats = 0, n, d, o;
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
    if (tickCount % 4 === 0) {
        o = mobj("editor");
        if (o) { o.message("playhead", playing ? model.playheadPhase(beats, beatsPerBar) : -1); }
    }
    if (model.dirty) {
        if (dirtySince === 0) { dirtySince = now; }
        else if (now - dirtySince > 500) { saveState(); model.dirty = false; dirtySince = 0; }
    }
}

// ---------- edition venant de l'editeur ----------
function ui_curve(lane, hex) {
    var d = decodeCurve(String(hex), 4);
    lane = laneOf(lane);
    if (d) { model.setDrawnCurve(lane, d); }
}
function ui_points(lane, str) {
    lane = laneOf(lane);
    try { model.replacePoints(lane, decodePoints(String(str) === "-" ? "" : String(str))); }
    catch (e) { model.say(e.message); }
}

// ---------- boutons de la barre d'outils ----------
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
        case "tools": openTools(); break;
        default: break;
    }
    if (l) { model.say(l.locked ? "Ligne " + (i + 1) + " verrouillee." : model.status); }
}
function resume(i, v) { if (v === undefined || Number(v) === 1) { model.resume(laneOf(i)); } }
// menu "Forme" : entree 0 = titre du menu, 1 a 6 = formes
function shape_preset(index) {
    var s = Number(index) - 1;
    if (s >= 0 && s <= 5) { model.applyPreset(model.selected, s); }
    sendTo(mobj("shapemenu"), ["set", 0]);
}
function vary_amount(v) { model.varyAmount = clamp(Number(v), 0, 100) * 0.01; }
function smooth_amount(v) { model.smoothAmount = clamp(Number(v), 0, 100) * 0.01; }

// ---------- fenetre "Outils" : nom, description, code, export ----------
function joinArgs(args, from) { var out = [], k; for (k = from; k < args.length; k++) { out.push(String(args[k])); } return out.join(" "); }
// [textedit] envoie "text mot mot ..." : le mot "text" de tete est retire s'il est present
function text(which) {
    var from = (arguments.length > 1 && String(arguments[1]) === "text") ? 2 : 1;
    cache[String(which)] = joinArgs(arguments, from);
}

function fillTools(m) {
    var l = m.lanes[m.selected];
    sendTo(subobj("tools", "lane_title"), ["set", "Courbe " + (m.selected + 1)]);
    sendTo(subobj("tools", "name_edit"), ["set", l.name]);
    sendTo(subobj("tools", "desc_edit"), ["set", l.motionText]);
    sendTo(subobj("tools", "code_edit"), ["set", l.script.replace(/\n/g, " ")]);
}
function openTools() { fillTools(model); sendTo(mobj("tools"), ["open"]); }

function toolsSay(interp, message) {
    sendTo(subobj("tools", "interp"), ["set", interp]);
    sendTo(subobj("tools", "msg"), ["set", message]);
}
function previewScript(compiled, mode, original, explanation) {
    var d = parseScript(compiled);
    if (d.bars < 0.25 || d.bars > 32 || Math.abs(d.bars * 4 - Math.round(d.bars * 4)) > 1e-6) {
        fail("Duree : 0.25 a 32 mesures, pas de 0.25.");
    }
    pendingMotion = { mode: mode, compiled: compiled, original: original };
    sendTo(subobj("tools", "preview"), ["view", 0, encodeCurve(d), "-", 0, 0, d.bars, 0, "", 0]);
    toolsSay(explanation, "Proposition : la courbe actuelle reste inchangee.");
}
function tools_btn(name, value) { if (Number(value) === 1) { tools(name); } }
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
                if (ok.ok) { pendingMotion = null; fillTools(model); }
                toolsSay("", ok.ok ? "Courbe appliquee." : ok.error);
                break;
            case "rename":
                model.rename(i, cache.name); toolsSay("", "Nom enregistre.");
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
    var what = pendingFile, file = String(path), a = getLive(), bpb = beatsPerBar, bpm = 120, bytes, text, data;
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
            text = readFile(file);
            if (text === null) { toolsSay("", "Fichier illisible."); return; }
            data = JSON.parse(text);
            toolsSay("", model.fromSession(data, true) ? "Session importee." : "Ce fichier n'est pas une session Curve Editor M4L.");
        }
    } catch (e) { toolsSay("", "Echec : " + e.message); }
}
