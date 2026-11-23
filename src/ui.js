// Curve Editor M4L - editeur de courbe (objet [jsui], portage de CurveGraph de Curve Mini 0.6)
// ANKS Labs
//
// Concatene apres core.js par tools/build_device.py. ES5, dessin mgraphics.
// Recoit du moteur : view, playhead. Recoit de la barre d'outils : grid, snap, brush, stretch, tilt, shape_seg.
// Envoie au moteur (objet de script "engine") : ui_curve <ligne> <courbe>, ui_points <ligne> <points>.
//
// Souris, mode points : clic = ajouter un point ; glisser un point = le deplacer ; Alt + clic = le supprimer ;
// glisser la poignee au milieu d'un segment = courbure (double-clic = remettre a zero) ;
// Maj + glisser dans le vide = rectangle de selection ; Maj = pas d'aimantation a la grille.
// Mode libre : glisser pour dessiner (pinceaux : voir le menu).

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var COLOURS = [0x42dfbd, 0x69b4ff, 0xcc91ff, 0xffae70, 0xff7799, 0xe6d575, 0x7ce2ed, 0xa4db83];
var laneIndex = 0, data = newData(4), points = [], pointMode = false, locked = false, manual = false;
var bars = 4, offset = 0, laneName = "", phase = -1, preview = false;
var grid = 16, snap = true, brush = 0;
var dragging = false, selecting = false, dragIndex = -1, handle = -1, lastX = -1, lastY = 0.5, initialTension = 0;
var startX = 0, startY = 0, selX = 0, selY = 0, selected = {}, original = [], lastClick = { t: 0, x: -99, y: -99 };

function rgb(hex, alpha) {
    mgraphics.set_source_rgba(((hex >> 16) & 255) / 255, ((hex >> 8) & 255) / 255, (hex & 255) / 255, alpha === undefined ? 1 : alpha);
}
function laneColour() { return COLOURS[laneIndex % COLOURS.length]; }

function plot() {
    var s = mgraphics.size;
    return { x: 26, y: 10, w: Math.max(40, s[0] - 34), h: Math.max(20, s[1] - 26) };
}
function screenX(x) { var r = plot(); return r.x + x * r.w; }
function screenY(y) { var r = plot(); return r.y + r.h - y * r.h; }

// ---------- messages ----------
function view(lane, hex, pointsStr, mode, lock, barsValue, offsetValue, nameValue, manualFlag) {
    if (dragging) { return; }
    var d = decodeCurve(String(hex), Number(barsValue));
    if (!d) { return; }
    laneIndex = Number(lane); data = d;
    points = String(pointsStr) === "-" ? [] : decodePoints(String(pointsStr));
    pointMode = Number(mode) === 1 && points.length >= 2;
    locked = Number(lock) === 1; bars = Number(barsValue); offset = Number(offsetValue);
    try { laneName = decodeURIComponent(String(nameValue)); } catch (e) { laneName = String(nameValue); }
    manual = Number(manualFlag) === 1;
    selected = {};
    mgraphics.redraw();
}
function playhead(value) { phase = Number(value); mgraphics.redraw(); }
var GRID_CHOICES = [4, 8, 16, 32, 64];
function setgridindex(i) { i = Math.round(Number(i)); if (i >= 0 && i < GRID_CHOICES.length) { grid = GRID_CHOICES[i]; mgraphics.redraw(); } }
function setgrid(n) { n = Math.round(Number(n)); if (n >= 2 && n <= 64) { grid = n; mgraphics.redraw(); } }
function setsnap(v) { snap = Number(v) !== 0; }
function setbrush(n) { brush = clamp(Math.round(Number(n)), 0, 3); }
function setpreview(v) { preview = Number(v) !== 0; }

// ---------- dessin ----------
function paint() {
    var r = plot(), s = mgraphics.size, i, x, y, step, n, colour = laneColour(), txt;
    rgb(0x121619); mgraphics.rectangle(0, 0, s[0], s[1]); mgraphics.fill();
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
    rgb(0x9baaa7); mgraphics.select_font_face("Arial"); mgraphics.set_font_size(9);
    mgraphics.move_to(2, r.y + 8); mgraphics.show_text("127");
    mgraphics.move_to(10, r.y + r.h); mgraphics.show_text("0");
    txt = (laneIndex + 1) + "  " + laneName + (manual ? "  [MANUEL]" : "") + (locked ? "  [VERROUILLEE]" : "");
    mgraphics.move_to(r.x + 4, r.y + 10); mgraphics.show_text(txt);
    txt = bars + " mesures";
    mgraphics.move_to(r.x + r.w - 58, r.y + r.h + 11); mgraphics.show_text(txt);

    // courbe (sous-echantillonnee a la largeur de l'affichage)
    step = Math.max(1, Math.floor(RES / Math.max(1, Math.floor(r.w))));
    mgraphics.move_to(screenX(0), screenY(data.y[0]));
    for (n = step; n <= RES; n += step) { mgraphics.line_to(screenX(n / RES), screenY(data.y[n])); }
    mgraphics.line_to(screenX(1), screenY(data.y[RES]));
    mgraphics.line_to(screenX(1), r.y + r.h); mgraphics.line_to(screenX(0), r.y + r.h); mgraphics.close_path();
    rgb(colour, 0.08); mgraphics.fill();
    rgb(locked ? 0x9baaa7 : 0xedf2f0); mgraphics.set_line_width(1.7);
    mgraphics.move_to(screenX(0), screenY(data.y[0]));
    for (n = step; n <= RES; n += step) { mgraphics.line_to(screenX(n / RES), screenY(data.y[n])); }
    mgraphics.line_to(screenX(1), screenY(data.y[RES]));
    mgraphics.stroke();

    if (pointMode && !preview) {
        for (i = 0; i < points.length; i++) {
            x = screenX(points[i].x); y = screenY(points[i].y);
            if (selected[i]) { rgb(colour); } else { rgb(0xedf2f0); }
            mgraphics.ellipse(x - 3.5, y - 3.5, 7, 7); mgraphics.fill();
            if (i + 1 < points.length) {
                var t = (points[i].x + points[i + 1].x) * 0.5;
                rgb(colour); mgraphics.set_line_width(1.3);
                mgraphics.ellipse(screenX(t) - 3, screenY(data.y[clamp(Math.round(t * RES), 0, RES)]) - 3, 6, 6);
                mgraphics.stroke();
            }
        }
    }
    if (selecting) {
        rgb(colour, 0.1); mgraphics.rectangle(Math.min(startX, selX), Math.min(startY, selY), Math.abs(selX - startX), Math.abs(selY - startY)); mgraphics.fill();
        rgb(colour); mgraphics.set_line_width(1);
        mgraphics.rectangle(Math.min(startX, selX), Math.min(startY, selY), Math.abs(selX - startX), Math.abs(selY - startY)); mgraphics.stroke();
    }
    if (!preview && phase >= 0) {
        x = screenX(phase);
        rgb(colour, 0.7); mgraphics.set_line_width(1);
        mgraphics.move_to(x, r.y); mgraphics.line_to(x, r.y + r.h); mgraphics.stroke();
    }
}

// ---------- envoi au moteur ----------
function engine() { var o = null; try { o = patcher.getnamed("engine"); } catch (e) { o = null; } return o; }
function sendCurve() {
    var o = engine();
    if (o) { o.message("ui_curve", laneIndex, encodeCurve(data)); }
}
function sendPoints() {
    var o = engine();
    if (o) { o.message("ui_points", laneIndex, encodePoints(points) || "-"); }
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
function rebuild() { if (pointMode) { data = fromPoints(points, bars); } mgraphics.redraw(); }
function clonePoints(list) { var out = [], i; for (i = 0; i < list.length; i++) { out.push(makePoint(list[i].x, list[i].y, list[i].tension, list[i].shape)); } return out; }
function selectedList() { var out = [], k; for (k in selected) { if (selected.hasOwnProperty(k)) { out.push(Number(k)); } } out.sort(function (a, b) { return a - b; }); return out; }

// secours : si le relachement de la souris n'a pas ete signale, le premier mouvement suivant le termine
function onidle(x, y, button, mod1, shift, caps, opt, mod2) { if (dragging) { release(); } }

function onclick(x, y, button, mod1, shift, caps, opt, mod2) {
    if (dragging) { release(); }
    var now = new Date().getTime(), dbl = (now - lastClick.t < 350 && Math.abs(x - lastClick.x) < 6 && Math.abs(y - lastClick.y) < 6), pt, i, h;
    lastClick = { t: now, x: x, y: y };
    if (locked || preview) { return; }
    dragIndex = -1; handle = -1; lastX = -1; selecting = false; startX = x; startY = y;
    if (pointMode) {
        dragIndex = hit(x, y);
        if (dbl && dragIndex < 0) {
            h = handleAt(x, y);
            if (h >= 0) { points[h].tension = 0; sendPoints(); return; }
        }
        if (opt && dragIndex > 0 && dragIndex < points.length - 1) { points.splice(dragIndex, 1); selected = {}; sendPoints(); return; }
        if (dragIndex < 0) {
            h = handleAt(x, y);
            if (h >= 0) { handle = h; initialTension = points[h].tension; }
        }
        if (handle < 0 && dragIndex < 0) {
            if (shift) { selecting = true; selX = x; selY = y; selected = {}; }
            else {
                pt = toPoint(x, y, shift);
                points.push(pt);
                points = canonicalPoints(points);
                for (i = 0; i < points.length; i++) { if (Math.abs(points[i].x - pt.x) < 1e-6) { dragIndex = i; break; } }
                selected = {};
            }
        }
        if (dragIndex >= 0) {
            if (!selected[dragIndex]) { if (!shift) { selected = {}; } selected[dragIndex] = true; }
            original = clonePoints(points);
        }
    }
    dragging = true;
    if (!pointMode) { draw(x, y, shift); }
    rebuild();
}

function ondrag(x, y, button, mod1, shift, caps, opt, mod2) {
    if (!button) { release(); return; }
    if (!dragging) { return; }
    var i, k, a, b, dx, dy, lo = -1, hi = 1, lowY = -1, highY = 1, q, idx, list;
    if (selecting) {
        selX = x; selY = y; selected = {};
        for (i = 0; i < points.length; i++) {
            if (screenX(points[i].x) >= Math.min(startX, x) && screenX(points[i].x) <= Math.max(startX, x) &&
                screenY(points[i].y) >= Math.min(startY, y) && screenY(points[i].y) <= Math.max(startY, y)) { selected[i] = true; }
        }
        mgraphics.redraw(); return;
    }
    if (!pointMode) { draw(x, y, shift); mgraphics.redraw(); return; }
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
                lo = Math.max(lo, (selected[idx - 1] ? 0 : original[idx - 1].x + 1e-6) - q.x);
                hi = Math.min(hi, (selected[idx + 1] ? 1 : original[idx + 1].x - 1e-6) - q.x);
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
    if (!dragging) { return; }
    dragging = false;
    if (selecting) { selecting = false; mgraphics.redraw(); return; }
    if (pointMode) { sendPoints(); } else { data.bars = bars; sendCurve(); }
    mgraphics.redraw();
}

// dessin libre et pinceaux
function draw(px, py, shift) {
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

// ---------- outils sur la selection (boutons de la barre d'outils) ----------
function transform(stretch, positive) {
    var list = selectedList(), first, last, centre, left, right, k, q, i;
    if (locked || preview || !pointMode || list.length < 2) { return; }
    first = list[0]; last = list[list.length - 1];
    centre = (points[first].x + points[last].x) * 0.5;
    left = first === 0 ? 0 : points[first - 1].x + 1e-6;
    right = last + 1 === points.length ? 1 : points[last + 1].x - 1e-6;
    for (k = 0; k < list.length; k++) {
        i = list[k]; q = points[i];
        if (stretch) {
            if (i !== 0 && i + 1 !== points.length) { q.x = clamp(centre + (q.x - centre) * (positive ? 1.1 : 0.9), left, right); }
        } else { q.y = clamp01(q.y + (positive ? 0.08 : -0.08) * (q.x - centre)); }
    }
    points = canonicalPoints(points);
    selected = {};
    sendPoints(); rebuild();
}
function stretch(direction) { transform(true, Number(direction) > 0); }
function tilt(direction) { transform(false, Number(direction) > 0); }

// forme du segment qui part du point selectionne (menu "Segment")
function shape_seg(n) {
    var list = selectedList(), i;
    n = Math.round(Number(n));
    if (n < 0 || n > 6) { return; }                       // formes 0 a 6 : voir le menu Segment
    if (locked || preview || !pointMode || list.length === 0) { return; }
    for (i = 0; i < list.length; i++) { if (list[i] + 1 < points.length) { points[list[i]].shape = n; } }
    sendPoints(); rebuild();
}

if (typeof module !== "undefined" && module.exports) {
    module.exports = { };
}
