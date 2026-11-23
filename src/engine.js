// Curve Editor M4L - moteur des 8 lignes (portage de Plugin.cpp de Curve Mini 0.6)
// ANKS Labs
//
// Deux couches :
//   1. le modele (etat des lignes, commandes, calcul des CC, export .mid, session) : pur, teste sous Node ;
//   2. la colle Max (messages recus du patch, sorties vers ctlout, objets du patch, LiveAPI) en bas du fichier.
// Concatene apres core.js par tools/build_device.py. ES5 uniquement.

var LANE_COUNT = 8;
var DEFAULTS = { on: 0, min: 0, max: 100, bars: 4, offset: 0, smooth: 20, depth: 100, value: 64 };
var RANGES = { on: [0, 1], min: [0, 100], max: [0, 100], bars: [0.25, 32], offset: [0, 100],
    smooth: [0, 500], depth: [0, 100], value: [0, 127], cc: [0, 127], channel: [1, 16] };
var INT_KEYS = { on: true, value: true, cc: true, channel: true };

// ---------- modele ----------
function makeLane(i) {
    return {
        name: "Courbe " + (i + 1), script: "", motionText: "", channel: 16, cc: 20 + i,
        locked: false, pointMode: false, manual: false, points: [], curve: preset(0, 4),
        last: -1, st: { filtered: 0.5, valid: false },
        params: { on: DEFAULTS.on, min: DEFAULTS.min, max: DEFAULTS.max, bars: DEFAULTS.bars, offset: DEFAULTS.offset,
            smooth: DEFAULTS.smooth, depth: DEFAULTS.depth, value: DEFAULTS.value }
    };
}

function cloneLane(l) {
    return { curve: copyData(l.curve), points: l.points.slice(0), pointMode: l.pointMode, script: l.script,
        motionText: l.motionText, bars: l.params.bars };
}

function createModel(io) {
    var m = { lanes: [], selected: 0, armed: false, previous: [], clipboard: null, status: "", dirty: false,
        varyAmount: 0.05, smoothAmount: 0.3 };
    var i;
    for (i = 0; i < LANE_COUNT; i++) { m.lanes.push(makeLane(i)); m.previous.push(null); }

    function lane(i) { return m.lanes[clamp(Math.floor(Number(i)), 0, LANE_COUNT - 1)]; }
    function say(text) { m.status = text; io.status(text); }
    function touch() { m.dirty = true; }
    function pushView(i) { if (i === m.selected) { io.view(i, m); } }
    function setBars(i, bars) { m.lanes[i].params.bars = bars; io.setParam(i, "bars", bars); }

    m.say = say;

    // valeur d'un reglage (venant d'un controle Live, d'un chargement ou d'une automation)
    m.setParam = function (i, key, v) {
        var l = lane(i), r = RANGES[key], idx = m.lanes.indexOf(l);
        if (!r || !isFinite(v)) { return; }
        v = clamp(Number(v), r[0], r[1]);
        if (INT_KEYS[key]) { v = Math.round(v); }
        if (key === "bars") { v = Math.round(v * 4) / 4; if (v < 0.25) { v = 0.25; } }
        if (key === "cc" || key === "channel") {
            if (l[key] !== v) { l[key] = v; l.last = -1; l.st.valid = false; touch(); }
            return;
        }
        if (l.params[key] === v) { return; }
        l.params[key] = v;
        if (key === "value" && m.armed) { l.manual = true; io.manual(idx, true); touch(); pushView(idx); }
        if (key === "on") { l.last = -1; l.st.valid = false; }
        if (key === "bars" || key === "offset") { pushView(idx); }
    };

    m.select = function (i) {
        m.selected = clamp(Math.floor(Number(i)), 0, LANE_COUNT - 1);
        io.selected(m.selected);
        io.view(m.selected, m);
        touch();
    };

    function replaceCurve(i, d, script) {
        var l = m.lanes[i];
        if (l.locked) { say("Ligne verrouillee."); pushView(i); return false; }
        m.previous[i] = cloneLane(l);
        l.curve = d; l.script = script || ""; l.motionText = ""; l.points = []; l.pointMode = false;
        setBars(i, d.bars);
        touch(); pushView(i);
        return true;
    }
    m.replaceCurve = replaceCurve;

    m.replacePoints = function (i, pts) {
        var l = m.lanes[i];
        if (l.locked) { say("Ligne verrouillee."); pushView(i); return; }
        pts = canonicalPoints(pts);
        m.previous[i] = cloneLane(l);
        l.curve = fromPoints(pts, l.params.bars); l.points = pts; l.pointMode = true; l.script = ""; l.motionText = "";
        touch(); pushView(i);
    };

    // dessin libre venant de l'editeur
    m.setDrawnCurve = function (i, d) { d.bars = m.lanes[i].params.bars; replaceCurve(i, d, ""); };

    m.setPointMode = function (i, enabled) {
        var l = m.lanes[i];
        if (l.locked) { return; }
        m.previous[i] = cloneLane(l);
        if (enabled && l.points.length === 0) { l.points = simplify(l.curve, 0.006); }
        l.pointMode = enabled;
        if (enabled) { l.curve = fromPoints(l.points, l.params.bars); }
        touch(); pushView(i);
    };

    m.smoothCurve = function (i, strength) {
        var d = copyData(m.lanes[i].curve);
        d.bars = m.lanes[i].params.bars;
        replaceCurve(i, smoothDrawing(d, strength), "");
    };
    m.applyVariation = function (i, amount, seed) {
        replaceCurve(i, vary(m.lanes[i].curve, amount, seed === undefined ? Math.floor(Math.random() * 4294967296) : seed), "");
    };
    m.invert = function (i) {
        var d = copyData(m.lanes[i].curve), n;
        d.bars = m.lanes[i].params.bars;
        for (n = 0; n <= RES; n++) { d.y[n] = 1 - d.y[n]; }
        replaceCurve(i, d, "");
    };
    m.applyPreset = function (i, shape) { replaceCurve(i, preset(shape, m.lanes[i].params.bars), ""); };

    m.undo = function (i) {
        var l = m.lanes[i], old = m.previous[i];
        if (l.locked || !old) { return; }
        m.previous[i] = cloneLane(l);
        l.curve = old.curve; l.points = old.points; l.pointMode = old.pointMode; l.script = old.script; l.motionText = old.motionText;
        setBars(i, l.curve.bars);
        touch(); pushView(i);
    };

    m.toggleLock = function (i) { m.lanes[i].locked = !m.lanes[i].locked; touch(); pushView(i); };

    m.copy = function (i) {
        var c = cloneLane(m.lanes[i]);
        c.curve.bars = m.lanes[i].params.bars;
        m.clipboard = c;
        say("Courbe " + (i + 1) + " copiee (reglages non copies).");
    };
    m.paste = function (i) {
        var l = m.lanes[i], c = m.clipboard;
        if (!c) { say("Copier une courbe d'abord."); return; }
        if (l.locked) { say("Ligne verrouillee."); return; }
        m.previous[i] = cloneLane(l);
        l.curve = copyData(c.curve); l.points = c.points.slice(0); l.pointMode = c.pointMode; l.script = c.script;
        l.motionText = c.motionText;
        setBars(i, l.curve.bars);
        touch(); pushView(i);
    };

    m.resume = function (i) {
        var l = m.lanes[i];
        l.manual = false; l.st.valid = false; l.last = -1;
        io.manual(i, false); touch(); pushView(i);
    };

    m.applyScript = function (i, text, motionText) {
        var d;
        try {
            d = parseScript(text);
            if (d.bars < 0.25 || d.bars > 32 || Math.abs(d.bars * 4 - Math.round(d.bars * 4)) > 1e-6) {
                fail("Duree : 0.25 a 32 mesures, par pas de 0.25.");
            }
            if (m.lanes[i].locked) { fail("Ligne verrouillee."); }
        } catch (e) { return { ok: false, error: e.message }; }
        replaceCurve(i, d, text);
        m.lanes[i].motionText = motionText || "";
        return { ok: true };
    };

    m.rename = function (i, name) {
        name = trimText(String(name)).substring(0, 40);
        if (name.length === 0) { name = "Courbe " + (i + 1); }
        m.lanes[i].name = name; touch(); pushView(i);
    };

    // ---------- calcul des CC : meme logique que le plugin ----------
    // playing : transport en marche ; beats : position en noires ; bpb : noires par mesure ; dt : secondes depuis le dernier appel
    m.tick = function (playing, beats, bpb, dt) {
        var k, l, p, wanted, target, v;
        for (k = 0; k < LANE_COUNT; k++) {
            l = m.lanes[k]; p = l.params;
            if (p.on < 0.5 || (!l.manual && !playing)) { l.last = -1; l.st.valid = false; continue; }
            wanted = p.value / 127;
            if (!l.manual) {
                target = laneTarget(l.curve, beats, bpb, p);
                wanted = laneSmooth(l.st, target, dt, p.smooth, l.last >= 0 ? l.last / 127 : target);
            } else { l.st.valid = false; }
            v = toCC(wanted);
            if (v !== l.last) { l.last = v; io.cc(l.channel, l.cc, v); }
        }
    };

    m.playheadPhase = function (beats, bpb) {
        var l = m.lanes[m.selected], phase = beats / (bpb * l.params.bars) + l.params.offset * 0.01;
        return phase - Math.floor(phase);
    };

    // ---------- export MIDI : fichier standard, format 1, 960 pulsations par noire ----------
    m.exportMidi = function (i, bpb, bpm) {
        var l = m.lanes[i], p = l.params, ppq = 960, end = Math.max(1, Math.round(p.bars * bpb * ppq));
        var events = [], last = -1, st = { filtered: 0, valid: false }, tick, v, wanted, alpha, value;
        if (!(bpm > 0)) { bpm = 120; }
        function add(t) {
            v = curveAt(l.curve, t / end + p.offset * 0.01);
            wanted = laneShape(v, p);
            if (!st.valid) { st.filtered = wanted; st.valid = true; }
            else {
                alpha = p.smooth <= 0 ? 1 : 1 - Math.exp(-(10.0 / ppq * 60 / bpm) / (p.smooth * 0.001));
                st.filtered += alpha * (wanted - st.filtered);
            }
            value = clamp(Math.round(st.filtered * 127), 0, 127);
            if (value !== last) { events.push([t, l.channel, l.cc, value]); last = value; }
        }
        for (tick = 0; tick < end; tick += 10) { add(tick); }
        if ((end - 1) % 10) { add(end - 1); }
        return midiFileBytes(events, end, ppq);
    };

    // ---------- session ----------
    m.toSession = function (withParams) {
        var out = { format: "CURVE_EDITOR_M4L", version: 1, selected: m.selected, lanes: [] }, k, l, pts, j;
        for (k = 0; k < LANE_COUNT; k++) {
            l = m.lanes[k]; pts = [];
            for (j = 0; j < l.points.length; j++) { pts.push([l.points[j].x, l.points[j].y, l.points[j].tension, l.points[j].shape]); }
            out.lanes.push({ name: l.name, channel: l.channel, cc: l.cc, locked: l.locked, pointMode: l.pointMode,
                manual: l.manual, script: l.script, motionText: l.motionText, curve: encodeCurve(l.curve), points: pts,
                params: withParams ? JSON.parse(JSON.stringify(l.params)) : undefined });
        }
        return out;
    };

    // withParams : true pour une importation de session (reglages aussi), false pour la restauration avec le set
    m.fromSession = function (data, withParams) {
        var k, v, l, d, pts, j, key;
        if (!data || data.format !== "CURVE_EDITOR_M4L" || !data.lanes) { return false; }
        var wasArmed = m.armed;
        m.armed = false;    // une importation ne doit pas faire passer les lignes en manuel
        for (k = 0; k < LANE_COUNT && k < data.lanes.length; k++) {
            v = data.lanes[k]; l = m.lanes[k];
            if (!v) { continue; }
            l.name = typeof v.name === "string" ? v.name.substring(0, 40) : "Courbe " + (k + 1);
            l.locked = !!v.locked; l.manual = !!v.manual;
            l.script = typeof v.script === "string" ? v.script.substring(0, 32768) : "";
            l.motionText = typeof v.motionText === "string" ? v.motionText.substring(0, 4096) : "";
            l.channel = clamp(Math.round(Number(v.channel)) || 16, 1, 16);
            l.cc = clamp(Math.round(Number(v.cc)), 0, 127);
            if (!isFinite(l.cc)) { l.cc = 20 + k; }
            d = decodeCurve(v.curve, l.params.bars);
            if (d) { l.curve = d; }
            pts = [];
            if (v.points) {
                for (j = 0; j < v.points.length; j++) { pts.push(makePoint(Number(v.points[j][0]), Number(v.points[j][1]), Number(v.points[j][2]), Number(v.points[j][3]))); }
            }
            try { l.points = pts.length ? canonicalPoints(pts) : []; } catch (e) { l.points = []; }
            l.pointMode = !!v.pointMode && l.points.length > 0;
            l.last = -1; l.st.valid = false; m.previous[k] = null;
            if (withParams && v.params) {
                for (key in DEFAULTS) { if (DEFAULTS.hasOwnProperty(key) && v.params[key] !== undefined) { m.setParam(k, key, v.params[key]); io.setParam(k, key, l.params[key]); } }
                io.setParam(k, "cc", l.cc); io.setParam(k, "channel", l.channel);
            }
            io.manual(k, l.manual);
        }
        m.armed = wasArmed;
        m.selected = clamp(Math.floor(Number(data.selected)) || 0, 0, LANE_COUNT - 1);
        io.selected(m.selected); io.view(m.selected, m);
        return true;
    };

    m.serialize = function () { return JSON.stringify(m.toSession(false)); };
    m.restore = function (json) {
        var data;
        try { data = JSON.parse(json); } catch (e) { return false; }
        return m.fromSession(data, false);
    };
    return m;
}

// ---------- fichier MIDI standard ----------
function vlq(value) {
    var bytes = [value & 127];
    value = value >>> 7;
    while (value > 0) { bytes.unshift((value & 127) | 128); value = value >>> 7; }
    return bytes;
}
function be32(v) { return [(v >>> 24) & 255, (v >>> 16) & 255, (v >>> 8) & 255, v & 255]; }
function midiFileBytes(events, endTick, ppq) {
    var track = [], k, e, delta, lastTick = 0;
    for (k = 0; k < events.length; k++) {
        e = events[k];
        delta = e[0] - lastTick; lastTick = e[0];
        track = track.concat(vlq(delta), [0xB0 | ((e[1] - 1) & 15), e[2] & 127, e[3] & 127]);
    }
    track = track.concat(vlq(Math.max(0, endTick - lastTick)), [0xFF, 0x2F, 0x00]);
    return [0x4D, 0x54, 0x68, 0x64, 0, 0, 0, 6, 0, 1, 0, 1, (ppq >> 8) & 255, ppq & 255,
        0x4D, 0x54, 0x72, 0x6B].concat(be32(track.length), track);
}

// ---------- texte multi-ligne qui a perdu ses retours a la ligne dans un message Max ----------
// Les mots d'un debut d'instruction redeviennent des debuts de ligne ; un commentaire # va jusqu'a la prochaine instruction.
function reflowScript(joined) {
    var words = trimText(String(joined)).split(/\s+/), starts = { "duration:": 1, "start:": 1, ramp: 1, hold: 1, wave: 1, saw: 1 };
    var lines = [], current = [], inComment = false, k, w;
    for (k = 0; k < words.length; k++) {
        w = words[k];
        if (starts[w] === 1) { if (current.length) { lines.push(current.join(" ")); } current = []; inComment = false; }
        if (w.charAt(0) === "#") { inComment = true; }
        if (!inComment) { current.push(w); }
    }
    if (current.length) { lines.push(current.join(" ")); }
    return lines.join("\n");
}

if (typeof module !== "undefined" && module.exports) {
    module.exports = {
        createModel: createModel, midiFileBytes: midiFileBytes, reflowScript: reflowScript, LANE_COUNT: LANE_COUNT
    };
}
