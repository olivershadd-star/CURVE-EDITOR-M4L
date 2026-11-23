// Genere par tools/build_device.py : ne pas modifier ici, modifier src/.

// ===== core.js =====
// Curve Editor M4L - noyau (portage de Curve.h, LaneMath.h et MotionLanguage.h de Curve Mini 0.6)
// ANKS Labs
//
// JavaScript ES5 pur (ancien moteur [js] de Max compris) : pas de let/const, de fleches, de tableaux
// types, de Math.fround/sign/trunc. Aucune dependance a Max : teste sous Node.
// Les messages d'erreur sont ceux de la version C++ (volontairement sans accents).

var RES = 2048;
var TWO_PI = 2 * Math.PI;

function clamp(x, lo, hi) { return x < lo ? lo : (x > hi ? hi : x); }
function clamp01(x) { return x < 0 ? 0 : (x > 1 ? 1 : x); }
function fail(message) { throw new Error(message); }

// ---------- courbe : RES+1 valeurs entre 0 et 1, sur "bars" mesures ----------
function newData(bars) {
    var y = [];
    var n;
    for (n = 0; n <= RES; n++) { y.push(0); }
    return { y: y, bars: bars === undefined ? 4 : bars };
}

function copyData(d) { return { y: d.y.slice(0), bars: d.bars }; }

function curveAt(d, phase) {
    if (!isFinite(phase)) { return d.y[0]; }
    phase -= Math.floor(phase);
    var p = phase * RES;
    var n = Math.floor(p);
    if (n > RES - 1) { n = RES - 1; }
    return d.y[n] + (p - n) * (d.y[n + 1] - d.y[n]);
}

// ---------- texte ----------
function trimText(s) { return s.replace(/^[ \t\r]+|[ \t\r]+$/g, ""); }

function parseNumber(s) {
    var n = Number(s);
    if (s.length === 0 || /\s/.test(s) || !isFinite(n)) { fail("Nombre invalide : " + s); }
    return n;
}

function parsePercent(s) {
    if (s.length > 0 && s.charAt(s.length - 1) === "%") { s = s.substring(0, s.length - 1); }
    var n = parseNumber(s);
    if (n < 0 || n > 100) { fail("Pourcentage hors de 0..100"); }
    return n / 100;
}

function ease(t, mode) {
    if (mode === "linear") { return t; }
    if (mode === "smooth") { return t * t * (3 - 2 * t); }
    if (mode === "in") { return t * t; }
    if (mode === "out") { return 1 - (1 - t) * (1 - t); }
    fail("Courbure attendue : linear, smooth, in, out");
}

// ---------- grammaire declarative (code avance) ----------
function parseScript(text) {
    if (text.length > 32768) { fail("Texte trop long (32768 caracteres maximum)"); }
    var lines = text.split("\n");
    var segments = [];
    var current = 0.2, bars = 4, total = 0;
    var durationSeen = false, startSeen = false;
    var lineNo, line, w, s, hash, k;

    function positive(str) {
        var n = parseNumber(str);
        if (n <= 0 || n > 128) { fail("Duree attendue : >0 et <=128 mesures"); }
        return n;
    }
    function cycleCheck(c) {
        if (c < 1 || c > 64 || c !== Math.floor(c)) { fail("cycles : entier de 1 a 64"); }
    }

    for (lineNo = 1; lineNo <= lines.length; lineNo++) {
        line = lines[lineNo - 1];
        hash = line.indexOf("#");
        if (hash !== -1) { line = line.substring(0, hash); }
        line = trimText(line);
        if (line.length === 0) { continue; }
        try {
            w = line.split(/\s+/);
            if (w[0] === "duration:") {
                if (durationSeen || segments.length > 0 || w.length !== 3 || w[2] !== "bars") {
                    fail("Syntaxe : duration: 8 bars (une seule fois, avant les segments)");
                }
                bars = positive(w[1]);
                durationSeen = true;
                continue;
            }
            if (w[0] === "start:") {
                if (startSeen || segments.length > 0 || w.length !== 2) {
                    fail("Syntaxe : start: 20% (avant les segments)");
                }
                current = parsePercent(w[1]);
                startSeen = true;
                continue;
            }
            s = { from: current, to: 0, duration: 0, cycles: 1, depth: 0, type: "", mode: "linear" };
            if (w[0] === "ramp") {
                if (w.length !== 7 || w[1] !== "to" || w[3] !== "over" || w[5] !== "bars") {
                    fail("Syntaxe : ramp to 70% over 2 bars smooth");
                }
                s.type = "ramp"; s.to = parsePercent(w[2]); s.duration = positive(w[4]); s.mode = w[6];
                ease(0.5, s.mode);
            } else if (w[0] === "hold") {
                if (w.length !== 4 || w[1] !== "over" || w[3] !== "bars") { fail("Syntaxe : hold over 1 bars"); }
                s.type = "hold"; s.to = current; s.duration = positive(w[2]);
            } else if (w[0] === "wave") {
                if (w.length !== 11 || w[1] !== "around" || w[3] !== "depth" || w[5] !== "cycles" ||
                    w[7] !== "over" || w[9] !== "bars" || w[10] !== "sine") {
                    fail("Syntaxe : wave around 70% depth 10% cycles 2 over 2 bars sine");
                }
                s.type = "wave"; s.to = parsePercent(w[2]); s.depth = parsePercent(w[4]);
                s.cycles = parseNumber(w[6]); s.duration = positive(w[8]);
                if (Math.abs(s.to - current) > 1e-6) { fail("Faire une ramp jusqu'au centre avant wave"); }
                if (s.to - s.depth < 0 || s.to + s.depth > 1) { fail("La vague depasse 0..100%"); }
                cycleCheck(s.cycles);
            } else if (w[0] === "saw") {
                if (w.length !== 11 || w[1] !== "from" || w[3] !== "to" || w[5] !== "cycles" ||
                    w[7] !== "over" || w[9] !== "bars" || w[10] !== "linear") {
                    fail("Syntaxe : saw from 15% to 60% cycles 3 over 2 bars linear");
                }
                s.type = "saw"; s.from = parsePercent(w[2]); s.to = parsePercent(w[4]);
                s.cycles = parseNumber(w[6]); s.duration = positive(w[8]);
                if (Math.abs(s.from - current) > 1e-6) { fail("Faire une ramp jusqu'au depart avant saw"); }
                cycleCheck(s.cycles);
            } else { fail("Instruction inconnue"); }
            if (segments.length >= 128) { fail("128 segments maximum"); }
            total += s.duration;
            current = s.type === "saw" ? s.from : s.to;
            segments.push(s);
        } catch (e) {
            throw new Error("Ligne " + lineNo + " : " + e.message);
        }
    }
    if (segments.length === 0) { fail("Ajouter au moins un segment"); }
    if (Math.abs(total - bars) > 1e-6) {
        fail("Somme des segments = " + total.toFixed(6) + " mesures ; duration = " + bars.toFixed(6));
    }
    var out = newData(bars);
    var index = 0, begin = 0, n, pos, t, v, x;
    for (n = 0; n <= RES; n++) {
        pos = bars * n / RES;
        while (index + 1 < segments.length && pos >= begin + segments[index].duration) {
            begin += segments[index].duration;
            index++;
        }
        s = segments[index];
        t = clamp01((pos - begin) / s.duration);
        v = s.from;
        if (s.type === "ramp") { v = s.from + (s.to - s.from) * ease(t, s.mode); }
        else if (s.type === "wave") { v = s.to + s.depth * Math.sin(TWO_PI * s.cycles * t); }
        else if (s.type === "saw") { x = t * s.cycles; v = s.from + (s.to - s.from) * (x - Math.floor(x)); }
        out.y[n] = clamp01(v);
    }
    return out;
}

// ---------- formes de depart, variation ----------
function preset(shape, bars) {
    var d = newData(bars), n, t, v;
    for (n = 0; n <= RES; n++) {
        t = n / RES; v = 0.5;
        switch (shape) {
            case 0: v = 0.5 - 0.5 * Math.cos(TWO_PI * t); break;
            case 1: v = t; break;
            case 2: v = 1 - t; break;
            case 3: v = 1 - Math.abs(2 * t - 1); break;
            case 4: v = t * t * (3 - 2 * t); break;
            case 5: v = Math.floor(t * 8) / 8; break;
            default: break;
        }
        d.y[n] = v;
    }
    return d;
}

// generateur xorshift 32 bits identique a celui du plugin (graine entiere non signee)
function vary(input, depth, seed) {
    var d = copyData(input);
    var x = (seed >>> 0) || 1;
    var anchors = [], k, n, t, a, f;
    for (k = 0; k < 9; k++) {
        x = (x ^ (x << 13)) >>> 0;
        x = (x ^ (x >>> 17)) >>> 0;
        x = (x ^ (x << 5)) >>> 0;
        anchors.push((x / 4294967295 * 2 - 1) * depth);
    }
    anchors[8] = anchors[0];
    for (n = 0; n <= RES; n++) {
        t = n / RES * 8;
        a = Math.min(7, Math.floor(t));
        f = ease(t - a, "smooth");
        d.y[n] = clamp01(d.y[n] + anchors[a] + f * (anchors[a + 1] - anchors[a]));
    }
    return d;
}

// ---------- points : x 0..1, y 0..1, courbure -1..1, forme 0..6 ----------
// formes : 0 courbe, 1 courbe en S, 2 palier, 3 escalier, 4 onde, 5 triangle, 6 impulsion
function makePoint(x, y, tension, shape) {
    return { x: x, y: y, tension: tension || 0, shape: shape || 0 };
}

function segmentValue(t, tension, shape) {
    t = clamp01(t);
    tension = clamp(tension, -1, 1);
    var exponent = Math.pow(8, Math.abs(tension));
    var u = tension >= 0 ? Math.pow(t, exponent) : 1 - Math.pow(1 - t, exponent);
    switch (shape) {
        case 1: return u * u * (3 - 2 * u);
        case 2: return t >= 1 ? 1 : 0;
        case 3: return t >= 1 ? 1 : Math.floor(u * 8) / 8;
        case 4: return u + 0.12 * Math.sin(8 * Math.PI * u) * Math.sin(Math.PI * u);
        case 5: return u + 0.12 * (2 / Math.PI) * Math.asin(Math.sin(8 * Math.PI * u)) * Math.sin(Math.PI * u);
        case 6: return u + 0.12 * (Math.sin(8 * Math.PI * u) >= 0 ? 1 : -1) * Math.sin(Math.PI * u);
        default: return u;
    }
}

function canonicalPoints(points) {
    var list = [], i, p, out;
    for (i = 0; i < points.length; i++) {
        p = points[i];
        if (!isFinite(p.x) || !isFinite(p.y) || !isFinite(p.tension)) { fail("Point non fini"); }
        list.push({
            i: i,
            p: makePoint(clamp01(p.x), clamp01(p.y), clamp(p.tension, -1, 1), clamp(Math.round(p.shape), 0, 6))
        });
    }
    list.sort(function (a, b) { return a.p.x - b.p.x || a.i - b.i; });   // tri stable
    out = [];
    for (i = 0; i < list.length; i++) {
        p = list[i].p;
        if (out.length > 0 && Math.abs(out[out.length - 1].x - p.x) < 1e-6) { out[out.length - 1] = p; }
        else { out.push(p); }
    }
    if (out.length === 0) { out = [makePoint(0, 0.5), makePoint(1, 0.5)]; }
    if (out[0].x > 0) { out.unshift(makePoint(0, out[0].y)); }
    if (out[out.length - 1].x < 1) { out.push(makePoint(1, out[out.length - 1].y)); }
    return out;
}

function fromPoints(input, bars) {
    var pts = canonicalPoints(input);
    var d = newData(bars), k = 0, n, x, a, b, f;
    for (n = 0; n <= RES; n++) {
        x = n / RES;
        while (k + 2 < pts.length && x > pts[k + 1].x) { k++; }
        a = pts[k]; b = pts[k + 1];
        f = segmentValue((x - a.x) / (b.x - a.x), a.tension, a.shape);
        d.y[n] = clamp01(a.y + f * (b.y - a.y));
    }
    return d;
}

// Douglas-Peucker : garde les points qui s'ecartent de plus de "tolerance"
function simplify(d, tolerance) {
    tolerance = clamp(tolerance, 0.00001, 1);
    var keep = [], n, pending, pair, left, right, index, error, estimate, e, points;
    for (n = 0; n <= RES; n++) { keep.push(false); }
    keep[0] = keep[RES] = true;
    pending = [[0, RES]];
    while (pending.length > 0) {
        pair = pending.pop();
        left = pair[0]; right = pair[1]; index = -1; error = tolerance;
        for (n = left + 1; n < right; n++) {
            estimate = d.y[left] + (d.y[right] - d.y[left]) * (n - left) / (right - left);
            e = Math.abs(estimate - d.y[n]);
            if (e > error) { error = e; index = n; }
        }
        if (index >= 0) { keep[index] = true; pending.push([left, index]); pending.push([index, right]); }
    }
    points = [];
    for (n = 0; n <= RES; n++) { if (keep[n]) { points.push(makePoint(n / RES, d.y[n])); } }
    return points;
}

function smoothDrawing(input, strength) {
    strength = clamp01(strength);
    if (strength === 0) { return copyData(input); }
    var radius = 1 + Math.round(strength * 40);
    var out = copyData(input), n, j, sum, weight, index, w;
    for (n = 1; n < RES; n++) {
        sum = 0; weight = 0;
        for (j = -radius; j <= radius; j++) {
            index = clamp(n + j, 0, RES);
            w = radius + 1 - Math.abs(j);
            sum += w * input.y[index];
            weight += w;
        }
        out.y[n] = clamp01(input.y[n] * (1 - strength) + sum / weight * strength);
    }
    return out;
}

// ---------- codage compact des courbes (8 bits par valeur) ----------
var HEX = "0123456789abcdef";
function encodeCurve(d) {
    var s = [], n, v;
    for (n = 0; n <= RES; n++) {
        v = Math.round(clamp01(d.y[n]) * 255);
        s.push(HEX.charAt(v >> 4) + HEX.charAt(v & 15));
    }
    return s.join("");
}
function decodeCurve(hex, bars) {
    var d = newData(bars), n, v;
    if (typeof hex !== "string" || hex.length !== (RES + 1) * 2 || /[^0-9a-f]/.test(hex)) { return null; }
    for (n = 0; n <= RES; n++) {
        v = parseInt(hex.substr(n * 2, 2), 16);
        d.y[n] = v / 255;
    }
    return d;
}
function encodePoints(pts) {
    var s = [], i, p;
    for (i = 0; i < pts.length; i++) {
        p = pts[i];
        s.push(Math.round(p.x * 1e7) / 1e7 + "," + Math.round(p.y * 1e6) / 1e6 + "," + Math.round(p.tension * 1e5) / 1e5 + "," + p.shape);
    }
    return s.join(";");
}
function decodePoints(str) {
    var out = [], parts, i, f;
    if (typeof str !== "string" || str.length === 0) { return out; }
    parts = str.split(";");
    for (i = 0; i < parts.length; i++) {
        f = parts[i].split(",");
        if (f.length === 4) { out.push(makePoint(Number(f[0]), Number(f[1]), Number(f[2]), Number(f[3]))); }
    }
    return out;
}

// ---------- formule d'une ligne (LaneMath.h) ----------
// p : { min, max, bars, offset, smooth, depth, value } en %, mesures, ms, 0..127
function laneShape(curveValue, p) {
    var v = 0.5 + p.depth * 0.01 * (curveValue - 0.5);
    return clamp((p.min + (p.max - p.min) * v) * 0.01, 0, 1);
}

function laneTarget(d, quarter, beatsPerBar, p) {
    return laneShape(curveAt(d, quarter / (beatsPerBar * p.bars) + p.offset * 0.01), p);
}

// filtre a un pole ; st = { filtered, valid } ; initial amorce le filtre
function laneSmooth(st, wanted, dtSeconds, ms, initial) {
    if (!st.valid) { st.filtered = initial; st.valid = true; }
    var alpha = ms <= 0 ? 1 : 1 - Math.exp(-dtSeconds / (ms * 0.001));
    st.filtered += alpha * (wanted - st.filtered);
    return st.filtered;
}

function toCC(v) { return clamp(Math.round(v * 127), 0, 127); }

// ---------- langage de mouvement (francais, local) ----------
function normaliseText(text) {
    var pairs = [["é", "e"], ["è", "e"], ["ê", "e"], ["ë", "e"], ["É", "e"],
        ["à", "a"], ["â", "a"], ["À", "a"], ["î", "i"], ["ï", "i"],
        ["ô", "o"], ["ö", "o"], ["ù", "u"], ["û", "u"], ["ü", "u"],
        ["ç", "c"], ["œ", "oe"], ["’", " "]];
    var i, k, c;
    for (i = 0; i < pairs.length; i++) { text = text.split(pairs[i][0]).join(pairs[i][1]); }
    var chars = text.split("");
    function digit(ch) { return ch !== undefined && ch >= "0" && ch <= "9"; }
    var size = chars.length;
    for (k = 0; k < size; k++) {
        c = chars[k];
        if (c >= "A" && c <= "Z") { chars[k] = c = String.fromCharCode(c.charCodeAt(0) - 65 + 97); }
        var between = k > 0 && k + 1 < size && digit(chars[k - 1]) && digit(chars[k + 1]);
        if (c === "," && between) { chars[k] = "."; }
        else if (c === "," || c === ";" || c === "\n" || c === "\r" || (c === "." && !between)) { chars[k] = "|"; }
        else if (c === "'" || (c === "-" && !(k + 1 < size && digit(chars[k + 1]))) || c === ":") { chars[k] = " "; }
    }
    return chars.join("");
}

// meme mise en forme que ostringstream avec setprecision(12)
function num(v) { return String(Number(v.toPrecision(12))); }

var VERBS = { ouvre: "up", ouvrir: "up", ouverture: "up", monte: "up", monter: "up", reouvre: "up", reouverture: "up",
    ferme: "down", fermer: "down", fermeture: "down", descends: "down", descend: "down", descendre: "down",
    maintiens: "hold", maintenir: "hold", maintien: "hold", reste: "hold",
    oscille: "wave", osciller: "wave", oscillation: "wave", oscillations: "wave", va: "wave",
    dents: "saw", dent: "saw" };
var NUMBER_WORDS = { zero: 0, un: 1, une: 1, deux: 2, trois: 3, quatre: 4, cinq: 5, six: 6, sept: 7, huit: 8,
    neuf: 9, dix: 10, douze: 12, seize: 16 };
var FILLERS = ("a au aux de du des le la les l d en et vient scie vers jusqu pour cent % fois cycles cycle vitesse une un tres " +
    "autour amplitude profondeur pendant sur temps mesure mesures moitie quart quarts tiers complet complete completement " +
    "maximum max minimum min haut haute bas basse rapide rapidement lent lente lentement sec seche brutal brutale immediat " +
    "immediate instantane instantanee progressif progressive progressivement doux douce doucement courbe courbee lineaire " +
    "droit droite serre serree serrees serres petit petite petites petits leger legere legerement large larges ample fort " +
    "forte triangle sinus sinusoidale carree escalier cisaille cisaillee").split(" ");
var FILLER_SET = {};
(function () { var i; for (i = 0; i < FILLERS.length; i++) { FILLER_SET[FILLERS[i]] = true; } })();

function hasOwn(o, k) { return Object.prototype.hasOwnProperty.call(o, k); }

// retourne { data, script, explanation } ou leve une erreur lisible
function translateMotion(text, bars, initial) {
    if (text.length > 4096) { fail("Description trop longue (4096 caracteres maximum)."); }
    if (!isFinite(bars) || bars < 0.25 || bars > 32 || Math.abs(bars * 4 - Math.round(bars * 4)) > 1e-6) {
        fail("Choisir une duree de 0.25 a 32 mesures, par pas de 0.25.");
    }
    if (!isFinite(initial) || initial < 0 || initial > 1) { fail("Depart attendu entre 0 et 100 %."); }
    var raw = normaliseText(text).split(/\s+/), words = [], i, j, k, piece, at, next;
    for (i = 0; i < raw.length; i++) {
        if (raw[i].length === 0) { continue; }
        at = 0;
        while ((next = raw[i].indexOf("|", at)) !== -1) {
            if (next > at) { words.push(raw[i].substring(at, next)); }
            words.push("|");
            at = next + 1;
        }
        if (at < raw[i].length) { words.push(raw[i].substring(at)); }
    }
    if (words.length === 0) { fail("Decrire un mouvement : ouvre, ferme, maintiens, oscille, dents de scie."); }

    var steps = [], token, step;
    for (i = 0; i < words.length; i++) {
        token = words[i];
        if (token === "|" || token === "puis" || token === "ensuite") { continue; }
        if (hasOwn(VERBS, token)) {
            if (steps.length >= 32) { fail("32 mouvements maximum."); }
            steps.push({ type: VERBS[token], mode: "linear", w: [], duration: -1, weight: 1, target: 0,
                depth: 0.1, cycles: 4, relative: false, center: false });
            continue;
        }
        if (steps.length === 0) { fail("Commencer par ouvre, ferme, maintiens, oscille ou dents de scie."); }
        steps[steps.length - 1].w.push(token);
    }
    if (steps.length === 0) { fail("Aucun mouvement reconnu."); }

    var explicitTotal = 0, weights = 0;
    function makeHas(s) { return function (value) { return s.w.indexOf(value) !== -1; }; }
    for (i = 0; i < steps.length; i++) {
        step = steps[i];
        var has = makeHas(step);
        if (has("carree") || has("escalier") || has("triangle")) {
            fail("Cette forme n'est pas encore traduite. Utiliser oscille ou dents de scie, ou le menu Forme.");
        }
        var fast = has("rapide") || has("rapidement"), slow = has("lent") || has("lente") || has("lentement");
        var instant = has("sec") || has("seche") || has("brutal") || has("brutale") || has("immediat") ||
            has("immediate") || has("instantane") || has("instantanee");
        if ((fast && slow) || (instant && slow)) { fail("Vitesses contradictoires dans un meme mouvement."); }
        step.weight = instant ? 0.03 : (fast ? 0.5 : (slow ? 3 : 1));
        if (step.type === "wave" || step.type === "saw") { step.weight = 1; }
        if (has("courbe") || has("courbee") || has("doux") || has("douce") || has("doucement") ||
            has("progressif") || has("progressive") || has("progressivement")) { step.mode = "smooth"; }
        step.target = step.type === "up" ? 1 : 0;
        if (has("haut") || has("haute")) { step.target = 0.8; }
        if (has("bas") || has("basse")) { step.target = 0.2; }
        if (has("moitie")) { step.target = 0.5; }
        else if (has("tiers")) { step.target = 1.0 / 3; }
        else if (has("quart") || has("quarts")) { step.target = has("trois") ? 0.75 : 0.25; }
        if (has("maximum") || has("max") || has("complet") || has("complete") || has("completement")) {
            step.target = step.type === "down" ? 0 : 1;
        }
        if (has("minimum") || has("min")) { step.target = 0; }
        if (has("cisaille") || has("cisaillee")) { step.type = "saw"; }
        step.relative = !has("jusqu") && !has("vers") && (has("de") || has("du")) &&
            (has("quart") || has("quarts") || has("tiers") || has("moitie"));
        if (has("serre") || has("serree") || has("serrees") || has("serres") || has("petit") || has("petite") ||
            has("petites") || has("petits") || has("leger") || has("legere") || has("legerement")) { step.depth = 0.05; }
        if (has("large") || has("larges") || has("ample")) { step.depth = 0.25; }
        step.cycles = fast ? 8 : (slow ? 2 : 4);
        if (fast && has("tres")) { step.cycles = 16; }
        for (k = 0; k < step.w.length; k++) {
            var t = step.w[k], numeric = false, v = 0;
            if (hasOwn(NUMBER_WORDS, t)) { numeric = true; v = NUMBER_WORDS[t]; }
            else {
                var value = t;
                if (value.length > 0 && value.charAt(value.length - 1) === "%") { value = value.substring(0, value.length - 1); }
                if (value.length > 0 && (/[0-9]/.test(value.charAt(0)) || value.charAt(0) === "-" || value.charAt(0) === "+")) {
                    try { v = parseNumber(value); numeric = true; }
                    catch (e) { fail("Nombre non reconnu : " + t); }
                }
            }
            if (numeric) {
                var nxt = k + 1 < step.w.length ? step.w[k + 1] : "", prev = k > 0 ? step.w[k - 1] : "";
                if (nxt === "temps" || nxt === "mesure" || nxt === "mesures") {
                    if (step.duration >= 0) { fail("Une seule duree par mouvement."); }
                    if (v <= 0 || v > 128) { fail("Duree positive attendue."); }
                    step.duration = nxt === "temps" ? v / 4 : v;
                } else if (nxt === "cycles" || nxt === "cycle" || nxt === "fois") {
                    if (v < 1 || v > 64 || v !== Math.floor(v)) { fail("Choisir 1 a 64 cycles entiers."); }
                    step.cycles = v;
                } else if (t.charAt(t.length - 1) === "%" || nxt === "%" || nxt === "pour") {
                    if (v < 0 || v > 100) { fail("Pourcentage attendu entre 0 et 100."); }
                    if (prev === "amplitude" || prev === "profondeur") { step.depth = v * 0.01; }
                    else {
                        step.target = v * 0.01; step.center = true;
                        if (prev === "de" && !has("autour") && !has("jusqu")) { step.relative = true; }
                    }
                } else if (nxt !== "quart" && nxt !== "quarts" && nxt !== "tiers" && t !== "un" && t !== "une") {
                    fail("Preciser % / temps / mesures / cycles apres " + t);
                }
            } else if (!hasOwn(FILLER_SET, t)) {
                fail("Mot non compris : '" + t + "'. Decrire un mouvement de bouton ; voir les exemples.");
            }
        }
        if (step.type === "wave" && has("autour") && !step.center) { fail("Preciser le centre : oscille autour de 50 %."); }
        if (step.duration >= 0) { explicitTotal += step.duration; } else { weights += step.weight; }
    }
    if (explicitTotal > bars + 1e-8) { fail("Les durees depassent la longueur choisie."); }
    var remaining = bars - explicitTotal;
    if (weights > 0 && remaining <= 1e-8) { fail("Il ne reste pas de temps pour les mouvements sans duree."); }

    var dsl = "duration: " + num(bars) + " bars\nstart: " + num(initial * 100) + "%\n", summary = "";
    var current = initial, duration, target, center, transition, depth;
    for (i = 0; i < steps.length; i++) {
        step = steps[i];
        duration = step.duration >= 0 ? step.duration : remaining * step.weight / weights;
        summary += (i + 1) + ". ";
        if (step.type === "up" || step.type === "down") {
            target = step.relative ? clamp01(step.type === "up" ? current + (1 - current) * step.target : current * (1 - step.target)) : step.target;
            dsl += "ramp to " + num(target * 100) + "% over " + num(duration) + " bars " + step.mode + "\n";
            summary += "Position " + num(current * 100) + " -> " + num(target * 100) + " %";
            current = target;
        } else if (step.type === "hold") {
            dsl += "hold over " + num(duration) + " bars\n";
            summary += "Maintien a " + num(current * 100) + " %";
        } else {
            center = step.center ? step.target : current;
            if (step.type === "wave" && Math.abs(center - current) > 1e-6) {
                transition = duration * 0.1;
                dsl += "ramp to " + num(center * 100) + "% over " + num(transition) + " bars smooth\n";
                duration -= transition; current = center;
                summary += "Transition au centre, puis ";
            }
            if (step.type === "wave") {
                depth = Math.min(step.depth, Math.min(current, 1 - current));
                if (depth < 1e-6) {
                    fail("Une oscillation au minimum ou maximum n'a pas de place : ajouter autour de 50 % ou une ouverture avant.");
                }
                dsl += "wave around " + num(current * 100) + "% depth " + num(depth * 100) + "% cycles " + num(step.cycles) +
                    " over " + num(duration) + " bars sine\n";
                summary += step.cycles + " oscillations autour de " + num(current * 100) + " %, amplitude " + num(depth * 100) + " %";
            } else {
                target = step.center ? step.target : 1;
                if (Math.abs(target - current) < 1e-6) { fail("Les dents de scie ont besoin de deux positions differentes."); }
                dsl += "saw from " + num(current * 100) + "% to " + num(target * 100) + "% cycles " + num(step.cycles) +
                    " over " + num(duration) + " bars linear\n";
                summary += step.cycles + " dents de scie " + num(current * 100) + " -> " + num(target * 100) + " %";
            }
        }
        summary += " / " + num(step.duration >= 0 ? step.duration : remaining * step.weight / weights) + " mesures\n";
    }
    if (weights === 0 && remaining > 1e-8) {
        dsl += "hold over " + num(remaining) + " bars\n";
        summary += "Temps restant : maintien final de " + num(remaining) + " mesures.\n";
    }
    summary += "Sans duree explicite, rapide/lent repartit le temps ; oscillations : rapide/lent choisit le nombre de cycles.\n";
    return { data: parseScript(dsl), script: dsl, explanation: summary };
}

if (typeof module !== "undefined" && module.exports) {
    module.exports = {
        RES: RES, newData: newData, copyData: copyData, curveAt: curveAt, parseScript: parseScript, preset: preset,
        vary: vary, makePoint: makePoint, segmentValue: segmentValue, canonicalPoints: canonicalPoints,
        fromPoints: fromPoints, simplify: simplify, smoothDrawing: smoothDrawing, laneShape: laneShape,
        laneTarget: laneTarget, laneSmooth: laneSmooth, toCC: toCC, translateMotion: translateMotion,
        normaliseText: normaliseText, clamp: clamp, clamp01: clamp01, encodeCurve: encodeCurve,
        decodeCurve: decodeCurve, encodePoints: encodePoints, decodePoints: decodePoints, trimText: trimText, fail: fail
    };
}

// ===== engine.js =====
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

// ===== glue.js =====
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

var io = {
    cc: function (ch, cc, v) { outlet(2, ch); outlet(1, cc); outlet(0, v); },
    setParam: function (i, key, v) { sendTo(mobj("p" + i + "_" + key), ["set", v]); },
    view: function (i, m) {
        sendTo(mobj("editor"), viewArgs(i, m));
        fillTools(m);
    },
    selected: function (i) {
        var k;
        for (k = 0; k < LANE_COUNT; k++) { sendTo(mobj("sel" + k), ["set", k === i ? 1 : 0]); }
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
    if (Number(value) !== 1) { return; }
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
