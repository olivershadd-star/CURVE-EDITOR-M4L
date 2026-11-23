// Curve Editor M4L - fenetre d'edition complete (objet [jsui], port de l'editeur de Curve Mini 0.6)
// ANKS Labs
//
// Concatene apres core.js par tools/build_device.py. ES5 uniquement, source en ASCII (accents en \u....).
//
// Toute la fenetre est dessinee ici (onglets, 3 pages, boutons, menus, curseurs, graphique) : un seul objet,
// donc une seule facon de recevoir la souris, testable hors de Max.
// Messages recus du moteur : tab, lane_view, params, lane_selected, lane_manual, setstatus, say,
//                            preview_curve, fill, playhead
// Messages recus des champs texte : edit_name, edit_body
// Messages envoyes au moteur (sortie 0) : p, select, btn, preset, resume, vary_amount, smooth_amount,
//                            ui_curve, ui_points, text, tools, set_preset, sync_all

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;
inlets = 1;
outlets = 1;

var W = 720, H = 780;
// position des deux champs texte [x, y, largeur, hauteur] (relue par tools/build_device.py)
var LAYOUT_TEXT = {"name": [16, 176, 556, 30], "body": [16, 194, 688, 125]};
var GRAPH0 = { x: 16, y: 326, w: 688, h: 224 };
var GRAPH2 = { x: 16, y: 419, w: 688, h: 240 };

var C_BG = 0x0d1118, C_SURF = 0x1a2230, C_SURF2 = 0x263248, C_EDGE = 0x33425a, C_INK = 0xedf2f0, C_MUTED = 0x8fa0b5, C_ON = 0x186856;
var COLOURS = [0x42dfbd, 0x69b4ff, 0xcc91ff, 0xffae70, 0xff7799, 0xe6d575, 0x7ce2ed, 0xa4db83];
var GRID_CHOICES = [4, 8, 16, 32, 64];
var SHAPE_NAMES = ["Vague", "Rampe +", "Rampe -", "Triangle", "Douce", "Paliers"];
var BRUSH_NAMES = ["Trait libre", "Motif rampe", "Motif triangle", "Motif sinus"];
var SEG_NAMES = ["Courbe", "Courbe en S", "Palier", "Escalier", "Onde", "Triangle", "Impulsion"];
var PAGE_NAMES = ["Courbe", "Destination", "Décrire / Code"];
var MODE_NAMES = ["Décrire le mouvement (local)", "Code avancé"];
var SLIDERS = [
    { key: "min", label: "Minimum %", lo: 0, hi: 100, step: 1 },
    { key: "max", label: "Maximum %", lo: 0, hi: 100, step: 1 },
    { key: "bars", label: "Mesures", lo: 1, hi: 16, step: 1 },
    { key: "offset", label: "Phase %", lo: 0, hi: 100, step: 1 },
    { key: "smooth", label: "Lissage ms", lo: 0, hi: 500, step: 1 },
    { key: "depth", label: "Profondeur %", lo: 0, hi: 100, step: 1 },
    { key: "vary", label: "Variation %", lo: 0, hi: 100, step: 1, local: true },
    { key: "smoothdraw", label: "Lisser dessin %", lo: 0, hi: 100, step: 1, local: true }
];

// ---------- etat ----------
var lanes = [], sel = 0, page = 0, k0;
for (k0 = 0; k0 < 8; k0++) {
    lanes.push({ name: "Courbe " + (k0 + 1), mini: [], manual: false,
        params: { on: 0, min: 0, max: 100, bars: 4, offset: 0, smooth: 20, depth: 100, value: 64, cc: 20 + k0, channel: 16 } });
}
var data = newData(4), points = [], pointMode = false, locked = false, manual = false;
var bars = 4, offset = 0, laneName = "", phase = -1, preview = false;
var grid = 16, snap = true, brush = 0, varyAmt = 5, smoothAmt = 30, mode = 0;
var dragging = false, selecting = false, dragIndex = -1, handle = -1, lastX = -1, lastY = 0.5, initialTension = 0;
var startX = 0, startY = 0, selX = 0, selY = 0, pick = {}, original = [], lastClick = { t: 0, x: -99, y: -99 };
var sliding = null, menu = null, controls = [];
var texts = { name: "", desc: "", code: "" }, interp = "", msgLine = "", statusText = "", previewData = null, previewBars = 4;
var pending = { name: null, body: null };

function dec(s) {
    var t;
    try { t = decodeURIComponent(String(s)); } catch (e) { t = String(s); }
    return t === "\u0000" ? "" : t;
}
function enc(s) { s = String(s); return s.length > 0 ? encodeURIComponent(s) : "%00"; }
function send() {
    var args = [0], k;
    for (k = 0; k < arguments.length; k++) { args.push(arguments[k]); }
    outlet.apply(this, args);
}
function getObj(name) { var o = null; try { o = patcher.getnamed(name); } catch (e) { o = null; } return o; }

// ---------- dessin : outils ----------
function rgb(hex, alpha) {
    mgraphics.set_source_rgba(((hex >> 16) & 255) / 255, ((hex >> 8) & 255) / 255, (hex & 255) / 255, alpha === undefined ? 1 : alpha);
}
function laneColour(i) { return COLOURS[(i === undefined ? sel : i) % COLOURS.length]; }
function fillRect(x, y, w, h, col, alpha) { rgb(col, alpha); mgraphics.rectangle(x, y, w, h); mgraphics.fill(); }
function strokeRect(x, y, w, h, col, alpha) { rgb(col, alpha); mgraphics.set_line_width(1); mgraphics.rectangle(x + 0.5, y + 0.5, w - 1, h - 1); mgraphics.stroke(); }
function measure(str) { var m = mgraphics.text_measure(str); return m ? m[0] : String(str).length * 6; }
function drawText(str, x, y, size, col, align, alpha) {
    var w;
    mgraphics.select_font_face("Arial"); mgraphics.set_font_size(size); rgb(col, alpha);
    str = String(str);
    if (align === "c") { w = measure(str); x -= w / 2; } else if (align === "r") { w = measure(str); x -= w; }
    mgraphics.move_to(x, y); mgraphics.show_text(str);
}
function fit(str, maxw, size) {
    str = String(str);
    mgraphics.select_font_face("Arial"); mgraphics.set_font_size(size);
    if (measure(str) <= maxw) { return str; }
    while (str.length > 1 && measure(str + "..") > maxw) { str = str.substring(0, str.length - 1); }
    return str + "..";
}
function wrap(str, maxw, size) {
    var words = String(str).split(/\s+/), lines = [], cur = "", k, t;
    mgraphics.select_font_face("Arial"); mgraphics.set_font_size(size);
    for (k = 0; k < words.length; k++) {
        t = cur.length ? cur + " " + words[k] : words[k];
        if (measure(t) > maxw && cur.length) { lines.push(cur); cur = words[k]; } else { cur = t; }
    }
    if (cur.length) { lines.push(cur); }
    return lines;
}

// ---------- graphique ----------
function plotOf(g) { return { x: g.x + 26, y: g.y + 10, w: Math.max(40, g.w - 34), h: Math.max(20, g.h - 26) }; }
function plot() { return plotOf(GRAPH0); }
function screenX(x) { var r = plot(); return r.x + x * r.w; }
function screenY(y) { var r = plot(); return r.y + r.h - y * r.h; }

function paintGraph(g, dd, o) {
    var r = plotOf(g), i, x, y, step, n, t, colour = laneColour(o.lane), pts = o.points || [], sx, sy;
    sx = function (v) { return r.x + v * r.w; };
    sy = function (v) { return r.y + r.h - v * r.h; };
    fillRect(g.x, g.y, g.w, g.h, 0x121619);
    for (i = 0; i <= grid; i++) {
        rgb(i % 4 === 0 ? 0x354044 : 0x222b2f);
        x = Math.round(r.x + r.w * i / grid) + 0.5;
        mgraphics.move_to(x, r.y); mgraphics.line_to(x, r.y + r.h); mgraphics.set_line_width(1); mgraphics.stroke();
    }
    rgb(0x293237);
    for (i = 0; i <= 8; i++) {
        y = Math.round(r.y + r.h * i / 8) + 0.5;
        mgraphics.move_to(r.x, y); mgraphics.line_to(r.x + r.w, y); mgraphics.stroke();
    }
    drawText("127", g.x + 2, r.y + 8, 9, 0x9baaa7);
    drawText("0", g.x + 10, r.y + r.h, 9, 0x9baaa7);
    if (o.title) { drawText(o.title, r.x + 4, r.y + 10, 10, 0x9baaa7); }
    drawText(o.bars + " mesures", r.x + r.w - 4, r.y + r.h + 11, 9, 0x9baaa7, "r");
    step = Math.max(1, Math.floor(RES / Math.max(1, Math.floor(r.w))));
    mgraphics.move_to(sx(0), sy(dd.y[0]));
    for (n = step; n <= RES; n += step) { mgraphics.line_to(sx(n / RES), sy(dd.y[n])); }
    mgraphics.line_to(sx(1), sy(dd.y[RES]));
    mgraphics.line_to(sx(1), r.y + r.h); mgraphics.line_to(sx(0), r.y + r.h); mgraphics.close_path();
    rgb(colour, 0.08); mgraphics.fill();
    rgb(o.locked ? 0x9baaa7 : 0xedf2f0); mgraphics.set_line_width(1.7);
    mgraphics.move_to(sx(0), sy(dd.y[0]));
    for (n = step; n <= RES; n += step) { mgraphics.line_to(sx(n / RES), sy(dd.y[n])); }
    mgraphics.line_to(sx(1), sy(dd.y[RES]));
    mgraphics.stroke();
    if (o.pointMode) {
        for (i = 0; i < pts.length; i++) {
            x = sx(pts[i].x); y = sy(pts[i].y);
            rgb(o.pick && o.pick[i] ? colour : 0xedf2f0);
            mgraphics.ellipse(x - 3.5, y - 3.5, 7, 7); mgraphics.fill();
            if (i + 1 < pts.length) {
                t = (pts[i].x + pts[i + 1].x) * 0.5;
                rgb(colour); mgraphics.set_line_width(1.3);
                mgraphics.ellipse(sx(t) - 3, sy(dd.y[clamp(Math.round(t * RES), 0, RES)]) - 3, 6, 6);
                mgraphics.stroke();
            }
        }
    }
    if (o.selecting) {
        fillRect(Math.min(startX, selX), Math.min(startY, selY), Math.abs(selX - startX), Math.abs(selY - startY), colour, 0.1);
        strokeRect(Math.min(startX, selX), Math.min(startY, selY), Math.abs(selX - startX), Math.abs(selY - startY), colour);
    }
    if (o.phase >= 0) {
        x = sx(o.phase);
        rgb(colour, 0.7); mgraphics.set_line_width(1);
        mgraphics.move_to(x, r.y); mgraphics.line_to(x, r.y + r.h); mgraphics.stroke();
    }
}

// ---------- reception des messages du moteur ----------
function tab(i, miniHex, nameEnc, on) {
    var l, k, hex = String(miniHex);
    i = clamp(Math.floor(Number(i)), 0, 7); l = lanes[i];
    l.mini = [];
    for (k = 0; k < 65; k++) { l.mini.push(parseInt(hex.substr(k * 2, 2), 16) / 255); }
    l.name = dec(nameEnc); l.params.on = Number(on) ? 1 : 0;
    mgraphics.redraw();
}
function lane_view(lane, hex, pointsStr, mode2, lock, barsValue, offsetValue, nameValue, manualFlag) {
    if (dragging) { return; }
    var d = decodeCurve(String(hex), Number(barsValue));
    if (!d) { return; }
    sel = clamp(Math.floor(Number(lane)), 0, 7); data = d;
    points = String(pointsStr) === "-" ? [] : decodePoints(String(pointsStr));
    pointMode = Number(mode2) === 1 && points.length >= 2;
    locked = Number(lock) === 1; bars = Number(barsValue); offset = Number(offsetValue);
    laneName = dec(nameValue); manual = Number(manualFlag) === 1;
    pick = {};
    mgraphics.redraw();
}
function params(i, on, mn, mx, bs, off, sm, dp, val, cc, ch) {
    var p;
    i = clamp(Math.floor(Number(i)), 0, 7); p = lanes[i].params;
    p.on = Number(on); p.min = Number(mn); p.max = Number(mx); p.bars = Number(bs); p.offset = Number(off);
    p.smooth = Number(sm); p.depth = Number(dp); p.value = Number(val); p.cc = Number(cc); p.channel = Number(ch);
    mgraphics.redraw();
}
function lane_selected(i) {
    var n = clamp(Math.floor(Number(i)), 0, 7);
    if (n !== sel) { previewData = null; interp = ""; msgLine = ""; }
    sel = n; pick = {}; mgraphics.redraw();
}
function lane_manual(i, flag) {
    i = clamp(Math.floor(Number(i)), 0, 7); lanes[i].manual = Number(flag) === 1;
    if (i === sel) { manual = lanes[i].manual; }
    mgraphics.redraw();
}
function setstatus(t) { statusText = dec(t); mgraphics.redraw(); }
function say(i, m) { interp = dec(i); msgLine = dec(m); mgraphics.redraw(); }
function preview_curve(hex, barsValue) {
    var d = decodeCurve(String(hex), Number(barsValue));
    if (d) { previewData = d; previewBars = Number(barsValue); mgraphics.redraw(); }
}
function playhead(v) { phase = Number(v); mgraphics.redraw(); }

// champs texte (objets [textedit] voisins, affiches seulement sur leur page)
function setEdit(objName, str) {
    var o = getObj(objName);
    if (!o) { return; }
    try { if (String(str).length > 0) { o.message("set", String(str)); } else { o.message("clear"); } } catch (e) { post("Curve Editor : champ texte : " + e + "\n"); }
}
function showEdits() {
    var a = getObj("name_edit"), b = getObj("body_edit");
    try { if (a) { a.hidden = page !== 1; } if (b) { b.hidden = page !== 2; } } catch (e) { post("Curve Editor : champ texte : " + e + "\n"); }
}
function fill(nameEnc, descEnc, codeEnc) {
    texts.name = dec(nameEnc); texts.desc = dec(descEnc); texts.code = dec(codeEnc);
    setEdit("name_edit", texts.name); setEdit("body_edit", mode === 0 ? texts.desc : texts.code);
    showEdits(); mgraphics.redraw();
}
function receive(which, args) {
    var a = [], k, cb;
    for (k = 0; k < args.length; k++) { a.push(String(args[k])); }
    if (a.length > 1 && a[0] === "text") { a.shift(); }
    cb = pending[which]; pending[which] = null;
    if (cb) { cb(a.join(" ")); }
}
function edit_name() { receive("name", arguments); }
function edit_body() { receive("body", arguments); }
function pull(which, cb) {
    var o = getObj(which === "name" ? "name_edit" : "body_edit");
    if (!o) { msgLine = "Zone de texte introuvable."; mgraphics.redraw(); return; }
    pending[which] = cb;
    try { o.message("bang"); } catch (e) { pending[which] = null; msgLine = "Zone de texte illisible."; }
}

// ---------- commandes ----------
function act(name) { send("btn", name, 1); }
function setPage(n) { page = n; menu = null; showEdits(); mgraphics.redraw(); }
function setMode(n) {
    mode = n;
    setEdit("body_edit", mode === 0 ? texts.desc : texts.code);
    previewData = null; interp = ""; msgLine = "";
    mgraphics.redraw();
}
function sliderValue(s) {
    if (s.local) { return s.key === "vary" ? varyAmt : smoothAmt; }
    return lanes[sel].params[s.key];
}
function setSlider(s, v) {
    v = clamp(Math.round(v / s.step) * s.step, s.lo, s.hi);
    if (s.local) {
        if (s.key === "vary") { varyAmt = v; send("vary_amount", v); } else { smoothAmt = v; send("smooth_amount", v); }
    } else { lanes[sel].params[s.key] = v; send("p", sel, s.key, v); }
    mgraphics.redraw();
}

// ---------- disposition : la liste des controles est reconstruite a chaque dessin / clic ----------
function ctl(c) { controls.push(c); return c; }
function button(id, label, x, y, w, h, fn, lit, enabled) {
    return ctl({ kind: "button", id: id, label: label, x: x, y: y, w: w, h: h, fn: fn, lit: !!lit, enabled: enabled !== false });
}
function drop(id, label, x, y, w, h, items, onpick) {
    return ctl({ kind: "drop", id: id, label: label, x: x, y: y, w: w, h: h, items: items, onpick: onpick });
}
function check(id, label, x, y, w, h, value, fn) {
    return ctl({ kind: "check", id: id, label: label, x: x, y: y, w: w, h: h, value: value, fn: fn });
}
function slider(id, s, x, y, w, h, label) {
    return ctl({ kind: "slider", id: id, s: s, x: x, y: y, w: w, h: h, label: label || s.label });
}

function layout() {
    var l = lanes[sel], p = l.params, k, x, y, w, row, col, cw, rowsY, lanesRow;
    controls = [];
    // en-tete
    drop("session", "Session", W - 16 - 100, 7, 100, 26, ["Exporter la session", "Importer une session"],
        function (i) { send("tools", i === 0 ? "export_session" : "import_session"); });
    // onglets
    for (k = 0; k < 8; k++) {
        (function (n) { ctl({ kind: "tab", id: "tab" + n, lane: n, x: 16 + n * 86, y: 44, w: 84, h: 60, fn: function () { send("select", n); } }); })(k);
    }
    // pages
    button("page0", PAGE_NAMES[0], 16, 110, 80, 30, function () { setPage(0); }, page === 0);
    button("page1", PAGE_NAMES[1], 100, 110, 105, 30, function () { setPage(1); }, page === 1);
    button("page2", PAGE_NAMES[2], 209, 110, 125, 30, function () { setPage(2); }, page === 2);

    if (page === 0) {
        check("active", "Active", W - 16 - 90, 154, 90, 28, p.on === 1, function () { lanes[sel].params.on = p.on === 1 ? 0 : 1; send("p", sel, "on", lanes[sel].params.on); });
        button("free", "Main levée", 16, 192, 110, 28, function () { act("free"); }, !pointMode);
        button("points", "Points", 132, 192, 80, 28, function () { act("points"); }, pointMode);
        drop("shape", "Forme...", 224, 192, 480, 28, SHAPE_NAMES, function (i) { send("set_preset", i); });
        button("copy", "Copier", 16, 226, 168, 28, function () { act("copy"); });
        button("paste", "Coller", 188, 226, 168, 28, function () { act("paste"); });
        button("undo", "Annuler", 360, 226, 168, 28, function () { act("undo"); });
        button("lock", locked ? "Déverrouiller" : "Verrouiller", 532, 226, 172, 28, function () { act("lock"); }, locked);
        drop("grid", grid + " divisions", 16, 260, 125, 28, ["4 divisions", "8 divisions", "16 divisions", "32 divisions", "64 divisions"],
            function (i) { grid = GRID_CHOICES[i]; });
        check("snap", "Aimanter", 146, 260, 90, 28, snap, function () { snap = !snap; });
        drop("brush", BRUSH_NAMES[brush], 242, 260, 200, 28, BRUSH_NAMES, function (i) { brush = i; if (i > 0) { act("free"); } });
        drop("segment", "Segment...", 448, 260, 256, 28, SEG_NAMES, function (i) { shape_seg(i); });
        button("stretchp", "Étirer +", 16, 294, 168, 26, function () { transform(true, true); });
        button("stretchm", "Étirer -", 188, 294, 168, 26, function () { transform(true, false); });
        button("tiltp", "Incliner +", 360, 294, 168, 26, function () { transform(false, true); });
        button("tiltm", "Incliner -", 532, 294, 172, 26, function () { transform(false, false); });
        ctl({ kind: "graph", id: "graph", x: GRAPH0.x, y: GRAPH0.y, w: GRAPH0.w, h: GRAPH0.h });
        for (k = 0; k < SLIDERS.length; k++) {
            slider("sl" + k, SLIDERS[k], 16 + (k % 2) * 348, 578 + Math.floor(k / 2) * 34, 340, 34);
        }
        button("invert", "Inverser", 16, 718, 224, 28, function () { act("invert"); });
        button("vary", "Varier", 248, 718, 224, 28, function () { act("vary"); });
        button("smoothb", "Lisser", 480, 718, 224, 28, function () { act("smooth"); });
    } else if (page === 1) {
        button("rename", "Renommer", 580, 176, 124, 30, function () {
            pull("name", function (s) { texts.name = s; send("text", "name", enc(s)); send("tools", "rename"); });
        });
        drop("channel", String(p.channel), 16, 246, 330, 30, ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"],
            function (i) { lanes[sel].params.channel = i + 1; send("p", sel, "channel", i + 1); });
        slider("cc", { key: "cc", label: "CC de sortie", lo: 0, hi: 127, step: 1 }, 372, 228, 332, 40);
        slider("value", { key: "value", label: manual ? "MANUEL / COURBE SUSPENDUE" : "COMMANDE MANUELLE / 0-127", lo: 0, hi: 127, step: 1 }, 16, 372, 688, 44);
        button("resume", "Reprendre la courbe", 16, 426, 220, 32, function () { send("resume", sel, 1); }, false, manual);
        button("exportmid", "Exporter la courbe MIDI", 16, 540, 280, 34, function () { send("tools", "export_mid"); });
    } else {
        drop("mode", MODE_NAMES[mode], 16, 150, 688, 34, MODE_NAMES, function (i) { setMode(i); });
        button("preview", "Prévisualiser", 16, 704, 150, 30, function () {
            pull("body", function (s) {
                var which = mode === 0 ? "desc" : "code";
                texts[which] = s; send("text", which, enc(s)); send("tools", "preview_" + which);
            });
        });
        button("apply", "Appliquer", 176, 704, 130, 30, function () { send("tools", mode === 0 ? "apply_desc" : "apply_code"); });
        ctl({ kind: "previewgraph", id: "previewgraph", x: GRAPH2.x, y: GRAPH2.y, w: GRAPH2.w, h: GRAPH2.h });
    }
    return controls;
}

function find(x, y) {
    var k, c;
    for (k = controls.length - 1; k >= 0; k--) {
        c = controls[k];
        if (x >= c.x && x < c.x + c.w && y >= c.y && y < c.y + c.h) { return c; }
    }
    return null;
}

// ---------- dessin ----------
function paintControl(c) {
    var l, col, a, k, v, frac, tx;
    if (c.kind === "button") {
        fillRect(c.x, c.y, c.w, c.h, c.lit ? C_ON : C_SURF2);
        strokeRect(c.x, c.y, c.w, c.h, C_EDGE);
        drawText(fit(c.label, c.w - 10, 12), c.x + c.w / 2, c.y + c.h / 2 + 4, 12, c.enabled ? C_INK : C_MUTED, "c", c.enabled ? 1 : 0.55);
    } else if (c.kind === "drop") {
        fillRect(c.x, c.y, c.w, c.h, C_SURF2); strokeRect(c.x, c.y, c.w, c.h, C_EDGE);
        drawText(fit(c.label, c.w - 30, 12), c.x + 10, c.y + c.h / 2 + 4, 12, C_INK);
        rgb(C_MUTED); mgraphics.move_to(c.x + c.w - 20, c.y + c.h / 2 - 2); mgraphics.line_to(c.x + c.w - 10, c.y + c.h / 2 - 2);
        mgraphics.line_to(c.x + c.w - 15, c.y + c.h / 2 + 4); mgraphics.close_path(); mgraphics.fill();
    } else if (c.kind === "check") {
        fillRect(c.x + 2, c.y + c.h / 2 - 8, 16, 16, C_SURF2); strokeRect(c.x + 2, c.y + c.h / 2 - 8, 16, 16, C_EDGE);
        if (c.value) { fillRect(c.x + 5, c.y + c.h / 2 - 5, 10, 10, laneColour()); }
        drawText(c.label, c.x + 26, c.y + c.h / 2 + 4, 12, C_INK);
    } else if (c.kind === "slider") {
        v = sliderValue(c.s);
        frac = clamp01((v - c.s.lo) / (c.s.hi - c.s.lo));
        drawText(c.label, c.x + 2, c.y + 13, 12, C_MUTED);
        drawText(String(Math.round(v * 100) / 100), c.x + c.w - 2, c.y + 13, 12, C_INK, "r");
        fillRect(c.x + 2, c.y + c.h - 12, c.w - 4, 6, C_SURF2);
        fillRect(c.x + 2, c.y + c.h - 12, (c.w - 4) * frac, 6, laneColour(), 0.55);
        fillRect(c.x + 2 + (c.w - 4) * frac - 4, c.y + c.h - 16, 8, 14, laneColour());
    } else if (c.kind === "tab") {
        l = lanes[c.lane]; col = laneColour(c.lane);
        fillRect(c.x, c.y, c.w, c.h, c.lane === sel ? C_SURF : 0x131b28);
        if (c.lane === sel) { strokeRect(c.x, c.y, c.w, c.h, col, 0.8); }
        drawText((c.lane < 9 ? "0" : "") + (c.lane + 1), c.x + 8, c.y + 17, 12, col);
        drawText(fit(l.name, c.w - 38, 12), c.x + 30, c.y + 17, 12, C_INK);
        if (l.mini.length === 65) {
            rgb(col, l.params.on ? 1 : 0.4); mgraphics.set_line_width(1.3);
            for (k = 0; k < 65; k++) {
                tx = c.x + 8 + (c.w - 16) * k / 64;
                if (k === 0) { mgraphics.move_to(tx, c.y + c.h - 8 - l.mini[k] * 26); } else { mgraphics.line_to(tx, c.y + c.h - 8 - l.mini[k] * 26); }
            }
            mgraphics.stroke();
        }
        if (l.manual) { drawText("M", c.x + c.w - 8, c.y + 17, 10, 0xffae70, "r"); }
    } else if (c.kind === "graph") {
        paintGraph(GRAPH0, data, { lane: sel, points: points, pointMode: pointMode && !preview, pick: pick, selecting: selecting, phase: phase,
            locked: locked, bars: bars, title: (sel + 1) + "  " + laneName + (manual ? "  [MANUEL]" : "") + (locked ? "  [VERROUILLÉE]" : "") });
    } else if (c.kind === "previewgraph") {
        paintGraph(GRAPH2, previewData || newData(previewBars), { lane: sel, points: [], pointMode: false, pick: {}, selecting: false, phase: -1,
            locked: false, bars: previewData ? previewBars : bars, title: previewData ? "Aperçu (la courbe actuelle reste inchangée)" : "Aperçu" });
    }
}

function paintStatic() {
    var k, lines, y;
    fillRect(0, 0, W, H, C_BG);
    drawText("Curve Mini", 16, 28, 18, C_INK);
    drawText("M4L", 122, 28, 11, C_MUTED);
    rgb(C_EDGE); mgraphics.move_to(16, 142.5); mgraphics.line_to(W - 16, 142.5); mgraphics.set_line_width(1); mgraphics.stroke();
    if (page === 0) {
        drawText((sel < 9 ? "0" : "") + (sel + 1) + " / " + lanes[sel].name, 16, 176, 19, C_INK);
        drawText("Points : poignée = courbure / Maj + glisser = sélection / Alt + clic = supprimer / menu Segment = forme", 16, 566, 10, C_MUTED);
    } else if (page === 1) {
        drawText("Nom de la courbe", 16, 168, 12, C_MUTED);
        drawText("Canal", 16, 238, 12, C_MUTED);
        lines = wrap("Les CC sont émis dans la chaîne MIDI de la piste. Pour piloter un synthé : placer cet appareil avant lui, allumer la ligne (On) puis utiliser le MIDI Learn du synthé. Seule la ligne qui bouge est apprise : les autres lignes doivent être éteintes pendant l'apprentissage.", 688, 12);
        for (k = 0; k < lines.length; k++) { drawText(lines[k], 16, 300 + k * 17, 12, C_MUTED); }
        lines = wrap("Le mouvement suspend cette courbe ; Reprendre rend la main au dessin. La valeur est aussi un paramètre automatisable de Live.", 688, 12);
        for (k = 0; k < lines.length; k++) { drawText(lines[k], 16, 484 + k * 17, 12, C_MUTED); }
    } else {
        fillRect(16, 329, 688, 80, C_SURF); strokeRect(16, 329, 688, 80, C_EDGE);
        lines = wrap(interp.length ? interp : "L'interprétation apparaît ici après Prévisualiser.", 668, 12);
        for (k = 0; k < lines.length && k < 4; k++) { drawText(lines[k], 26, 349 + k * 17, 12, interp.length ? C_INK : C_MUTED); }
        lines = wrap(msgLine, 688, 12);
        for (k = 0; k < lines.length && k < 2; k++) { drawText(lines[k], 16, 680 + k * 16, 12, 0xffd58a); }
    }
    drawText(fit(statusText, W - 32, 11), 16, 770, 11, C_MUTED);
}

function paintMenu() {
    var k, y;
    if (!menu) { return; }
    fillRect(menu.x, menu.y, menu.w, menu.items.length * 24 + 4, 0x10151f);
    strokeRect(menu.x, menu.y, menu.w, menu.items.length * 24 + 4, C_MUTED);
    for (k = 0; k < menu.items.length; k++) {
        y = menu.y + 2 + k * 24;
        drawText(menu.items[k], menu.x + 10, y + 16, 12, C_INK);
    }
}

function paint() {
    var k;
    layout();
    paintStatic();
    for (k = 0; k < controls.length; k++) { paintControl(controls[k]); }
    paintMenu();
}

// ---------- souris ----------
function toPoint(px, py, shift) {
    var r = plot(), x = clamp01((px - r.x) / Math.max(1, r.w)), y = clamp01((r.y + r.h - py) / Math.max(1, r.h));
    if (snap && !shift) { x = Math.round(x * grid) / grid; y = Math.round(y * 16) / 16; }
    return makePoint(x, y, 0, 0);
}
function hit(px, py) {
    var i, dx, dy;
    for (i = 0; i < points.length; i++) {
        dx = screenX(points[i].x) - px; dy = screenY(points[i].y) - py;
        if (Math.sqrt(dx * dx + dy * dy) < 10) { return i; }
    }
    return -1;
}
function handleAt(px, py) {
    var i, t, dx, dy;
    for (i = 0; i + 1 < points.length; i++) {
        t = (points[i].x + points[i + 1].x) * 0.5;
        dx = screenX(t) - px; dy = screenY(data.y[clamp(Math.round(t * RES), 0, RES)]) - py;
        if (Math.sqrt(dx * dx + dy * dy) < 10) { return i; }
    }
    return -1;
}
function sendCurve() { send("ui_curve", sel, encodeCurve(data)); }
function sendPoints() { send("ui_points", sel, encodePoints(points) || "-"); }
function rebuild() { if (pointMode) { data = fromPoints(points, bars); } mgraphics.redraw(); }
function clonePoints(list) { var out = [], i; for (i = 0; i < list.length; i++) { out.push(makePoint(list[i].x, list[i].y, list[i].tension, list[i].shape)); } return out; }
function selectedList() { var out = [], k; for (k in pick) { if (pick.hasOwnProperty(k)) { out.push(Number(k)); } } out.sort(function (a, b) { return a - b; }); return out; }

function sliderAt(c, x) {
    var frac = clamp01((x - (c.x + 2)) / Math.max(1, c.w - 4));
    setSlider(c.s, c.s.lo + frac * (c.s.hi - c.s.lo));
}

// secours : si le relachement de la souris n'a pas ete signale, le premier mouvement suivant le termine
function onidle(x, y, button, mod1, shift, caps, opt, mod2) { if (dragging || sliding) { release(); } }

function onclick(x, y, button, mod1, shift, caps, opt, mod2) {
    if (dragging || sliding) { release(); }
    layout();
    var c, k, now = new Date().getTime(), dbl, pt, i, h;
    if (menu) {
        if (x >= menu.x && x < menu.x + menu.w && y >= menu.y && y < menu.y + menu.items.length * 24 + 4) {
            k = Math.floor((y - menu.y - 2) / 24);
            if (k >= 0 && k < menu.items.length) { var cb = menu.onpick; menu = null; cb(k); }
        } else { menu = null; }
        mgraphics.redraw(); return;
    }
    c = find(x, y);
    if (!c) { return; }
    if (c.kind === "button") { if (c.enabled) { c.fn(); } mgraphics.redraw(); return; }
    if (c.kind === "tab" || c.kind === "check") { c.fn(); mgraphics.redraw(); return; }
    if (c.kind === "drop") {
        menu = { x: c.x, y: c.y + c.h + 2, w: Math.max(c.w, 140), items: c.items, onpick: c.onpick };
        if (menu.y + menu.items.length * 24 + 4 > H) { menu.y = Math.max(2, c.y - menu.items.length * 24 - 6); }
        mgraphics.redraw(); return;
    }
    if (c.kind === "slider") { sliding = c; sliderAt(c, x); return; }
    if (c.kind !== "graph") { return; }

    // ----- graphique -----
    dbl = (now - lastClick.t < 350 && Math.abs(x - lastClick.x) < 6 && Math.abs(y - lastClick.y) < 6);
    lastClick = { t: now, x: x, y: y };
    if (locked || preview) { return; }
    dragIndex = -1; handle = -1; lastX = -1; selecting = false; startX = x; startY = y;
    if (pointMode) {
        dragIndex = hit(x, y);
        if (dbl && dragIndex < 0) {
            h = handleAt(x, y);
            if (h >= 0) { points[h].tension = 0; sendPoints(); return; }
        }
        if (opt && dragIndex > 0 && dragIndex < points.length - 1) { points.splice(dragIndex, 1); pick = {}; sendPoints(); return; }
        if (dragIndex < 0) {
            h = handleAt(x, y);
            if (h >= 0) { handle = h; initialTension = points[h].tension; }
        }
        if (handle < 0 && dragIndex < 0) {
            if (shift) { selecting = true; selX = x; selY = y; pick = {}; }
            else {
                pt = toPoint(x, y, shift);
                points.push(pt);
                points = canonicalPoints(points);
                for (i = 0; i < points.length; i++) { if (Math.abs(points[i].x - pt.x) < 1e-6) { dragIndex = i; break; } }
                pick = {};
            }
        }
        if (dragIndex >= 0) {
            if (!pick[dragIndex]) { if (!shift) { pick = {}; } pick[dragIndex] = true; }
            original = clonePoints(points);
        }
    }
    dragging = true;
    if (!pointMode) { drawStroke(x, y, shift); }
    rebuild();
}

function ondrag(x, y, button, mod1, shift, caps, opt, mod2) {
    if (!button) { release(); return; }
    if (sliding) { sliderAt(sliding, x); return; }
    if (!dragging) { return; }
    var i, k, a, b, dx, dy, lo = -1, hi = 1, lowY = -1, highY = 1, q, idx, list;
    if (selecting) {
        selX = x; selY = y; pick = {};
        for (i = 0; i < points.length; i++) {
            if (screenX(points[i].x) >= Math.min(startX, x) && screenX(points[i].x) <= Math.max(startX, x) &&
                screenY(points[i].y) >= Math.min(startY, y) && screenY(points[i].y) <= Math.max(startY, y)) { pick[i] = true; }
        }
        mgraphics.redraw(); return;
    }
    if (!pointMode) { drawStroke(x, y, shift); mgraphics.redraw(); return; }
    if (handle >= 0) { points[handle].tension = clamp(initialTension + (startY - y) / 150, -1, 1); }
    else if (dragIndex >= 0) {
        a = toPoint(startX, startY, shift); b = toPoint(x, y, shift);
        dx = b.x - a.x; dy = b.y - a.y;
        list = selectedList();
        for (k = 0; k < list.length; k++) {
            idx = list[k]; q = original[idx];
            lowY = Math.max(lowY, -q.y); highY = Math.min(highY, 1 - q.y);
            if (idx === 0 || idx === original.length - 1) { lo = Math.max(lo, 0); hi = Math.min(hi, 0); }
            else {
                lo = Math.max(lo, (pick[idx - 1] ? 0 : original[idx - 1].x + 1e-6) - q.x);
                hi = Math.min(hi, (pick[idx + 1] ? 1 : original[idx + 1].x - 1e-6) - q.x);
            }
        }
        dx = clamp(dx, lo, hi); dy = clamp(dy, lowY, highY);
        for (k = 0; k < list.length; k++) {
            idx = list[k];
            points[idx] = makePoint(original[idx].x + dx, original[idx].y + dy, original[idx].tension, original[idx].shape);
        }
    }
    rebuild();
}

function release() {
    if (sliding) { sliding = null; return; }
    if (!dragging) { return; }
    dragging = false;
    if (selecting) { selecting = false; mgraphics.redraw(); return; }
    if (pointMode) { sendPoints(); } else { data.bars = bars; sendCurve(); }
    mgraphics.redraw();
}

// dessin libre et pinceaux : le trait libre n'est jamais aimante, seuls les pinceaux le sont
function drawStroke(px, py, shift) {
    var pt = toPoint(px, py, shift || !brush), xi = clamp(Math.round(pt.x * RES), 0, RES), n, t, v, cell, begin, end;
    if (brush) {
        cell = Math.min(grid - 1, Math.floor(pt.x * grid));
        begin = Math.floor(cell * RES / grid); end = Math.floor((cell + 1) * RES / grid);
        for (n = begin; n <= end; n++) {
            t = (n - begin) / (end - begin);
            v = brush === 1 ? t : (brush === 2 ? 1 - Math.abs(2 * t - 1) : 0.5 - 0.5 * Math.cos(TWO_PI * t));
            data.y[n] = pt.y * v;
        }
    } else if (lastX < 0) { data.y[xi] = pt.y; }
    else {
        for (n = Math.min(lastX, xi); n <= Math.max(lastX, xi); n++) {
            t = xi === lastX ? 1 : (n - lastX) / (xi - lastX);
            data.y[n] = lastY + t * (pt.y - lastY);
        }
    }
    lastX = xi; lastY = pt.y;
}

// ---------- outils sur la selection ----------
function transform(stretching, positive) {
    var list = selectedList(), first, last, centre, left, right, k, i, q;
    if (locked || preview || !pointMode || list.length < 2) { return; }
    first = list[0]; last = list[list.length - 1];
    centre = (points[first].x + points[last].x) * 0.5;
    left = first === 0 ? 0 : points[first - 1].x + 1e-6;
    right = last + 1 === points.length ? 1 : points[last + 1].x - 1e-6;
    for (k = 0; k < list.length; k++) {
        i = list[k]; q = points[i];
        if (stretching) {
            if (i !== 0 && i + 1 !== points.length) { q.x = clamp(centre + (q.x - centre) * (positive ? 1.1 : 0.9), left, right); }
        } else { q.y = clamp01(q.y + (positive ? 0.08 : -0.08) * (q.x - centre)); }
    }
    points = canonicalPoints(points);
    pick = {};
    sendPoints(); rebuild();
}
// forme du segment qui part du point selectionne (menu "Segment")
function shape_seg(n) {
    var list = selectedList(), i;
    n = Math.round(Number(n));
    if (n < 0 || n > 6) { return; }
    if (locked || preview || !pointMode || list.length === 0) { return; }
    for (i = 0; i < list.length; i++) { if (list[i] + 1 < points.length) { points[list[i]].shape = n; } }
    sendPoints(); rebuild();
}

if (typeof module !== "undefined" && module.exports) {
    module.exports = { };
}
