// Curve Editor M4L - moteur de lignes (prototype 2 lignes)
// ANKS Labs
//
// Objet [js] de Max for Live. Lit la position de Live (en temps), calcule la valeur
// de chaque courbe en boucle et envoie un CC quand la valeur change.
//
// Entree : messages de l'interface (lon, lcc, lch, lbars, lmin, lmax, lcurve) + bang (horloge).
// Sorties : 0 = valeur CC, 1 = numero de CC, 2 = canal (a brancher sur [ctlout], de droite a gauche).
//
// JavaScript ES5 uniquement (compatible [js] et [v8]).

inlets = 1;
outlets = 3;

var LANE_COUNT = 2;
var POINTS = 16;

var lanes = [];
var api = null;
var beatsPerBar = 4;
var refreshCounter = 0;

function defaultCurve(i) {
    var p = [];
    var k;
    for (k = 0; k < POINTS; k++) {
        if (i === 0) {
            p.push(0.5 + 0.5 * Math.sin(2 * Math.PI * k / POINTS));   // sinus
        } else {
            p.push(k / (POINTS - 1));                                   // rampe
        }
    }
    return p;
}

function makeLane(i) {
    return { on: 1, cc: 20 + i, ch: 1, bars: 1, min: 0, max: 127, pts: defaultCurve(i), last: -1 };
}

(function init() {
    var i;
    for (i = 0; i < LANE_COUNT; i++) { lanes.push(makeLane(i)); }
})();

function clamp(v, lo, hi) { return v < lo ? lo : (v > hi ? hi : v); }

function laneAt(i) {
    i = Math.floor(Number(i));
    if (!(i >= 0 && i < lanes.length)) { return null; }
    return lanes[i];
}

// ---- messages de l'interface ----
function lon(i, v)    { var l = laneAt(i); if (l) { l.on = Number(v) ? 1 : 0; l.last = -1; } }
function lcc(i, v)    { var l = laneAt(i); if (l) { l.cc = clamp(Math.round(Number(v)), 0, 127); l.last = -1; } }
function lch(i, v)    { var l = laneAt(i); if (l) { l.ch = clamp(Math.round(Number(v)), 1, 16); l.last = -1; } }
function lbars(i, v)  { var l = laneAt(i); if (l) { l.bars = clamp(Math.round(Number(v)), 1, 16); } }
function lmin(i, v)   { var l = laneAt(i); if (l) { l.min = clamp(Number(v), 0, 127); } }
function lmax(i, v)   { var l = laneAt(i); if (l) { l.max = clamp(Number(v), 0, 127); } }

// lcurve <ligne> <p0> <p1> ... : points entre 0 et 1, remis a POINTS valeurs
function lcurve(i) {
    var l = laneAt(i);
    var args = arrayfromargs(arguments);
    var raw = [];
    var k;
    if (!l) { return; }
    for (k = 1; k < args.length; k++) {
        var n = Number(args[k]);
        if (isFinite(n)) { raw.push(clamp(n, 0, 1)); }
    }
    if (raw.length === 0) { return; }
    // si le nombre de points differe, on reechantillonne en lineaire
    var pts = [];
    for (k = 0; k < POINTS; k++) {
        var pos = (raw.length === 1) ? 0 : k * (raw.length - 1) / (POINTS - 1);
        var a = Math.floor(pos);
        var b = Math.min(a + 1, raw.length - 1);
        pts.push(raw[a] + (pos - a) * (raw[b] - raw[a]));
    }
    l.pts = pts;
}

// ---- calcul ----
// valeur de courbe (0..1) a une phase donnee, avec bouclage entre le dernier et le premier point
function curveAt(pts, phase) {
    var n = pts.length;
    if (!isFinite(phase)) { return pts[0]; }
    phase = phase - Math.floor(phase);
    var p = phase * n;
    var a = Math.floor(p);
    if (a > n - 1) { a = n - 1; }
    var b = (a + 1) % n;
    return pts[a] + (p - a) * (pts[b] - pts[a]);
}

function laneValue(l, beats, bpb) {
    var phase = beats / (bpb * l.bars);
    var c = curveAt(l.pts, phase);
    var v = l.min + c * (l.max - l.min);
    return clamp(Math.round(v), 0, 127);
}

function sendCC(l, value) {
    outlet(2, l.ch);
    outlet(1, l.cc);
    outlet(0, value);
}

// une etape de l'horloge : appelee par [qmetro] (bang)
function tickWith(beats, bpb) {
    var i;
    for (i = 0; i < lanes.length; i++) {
        var l = lanes[i];
        if (!l.on) { continue; }
        var v = laneValue(l, beats, bpb);
        if (v !== l.last) {
            l.last = v;
            sendCC(l, v);
        }
    }
}

function getApi() {
    if (api === null) { api = new LiveAPI("live_set"); }
    return api;
}

function readBeatsPerBar(a) {
    var num = Number(a.get("signature_numerator"));
    var den = Number(a.get("signature_denominator"));
    if (num > 0 && den > 0) { beatsPerBar = num * 4 / den; }
}

function bang() {
    var a = getApi();
    if (Number(a.get("is_playing")) !== 1) { return; }
    if (refreshCounter % 50 === 0) { readBeatsPerBar(a); }
    refreshCounter++;
    var beats = Number(a.get("current_song_time"));
    if (!isFinite(beats)) { return; }
    tickWith(beats, beatsPerBar);
}

// vide la memoire d'envoi : le prochain bang renvoie les valeurs courantes
function reset() {
    var i;
    for (i = 0; i < lanes.length; i++) { lanes[i].last = -1; }
}

if (typeof module !== "undefined" && module.exports) {
    module.exports = {
        lanes: lanes, curveAt: curveAt, laneValue: laneValue, tickWith: tickWith,
        lon: lon, lcc: lcc, lch: lch, lbars: lbars, lmin: lmin, lmax: lmax, lcurve: lcurve, reset: reset
    };
}
