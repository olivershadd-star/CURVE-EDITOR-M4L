#!/usr/bin/env python3
"""Construit l'appareil Max for Live "Curve Editor M4L" (ANKS Labs).

Produit dans device/ :
  curve_engine.js        core.js + engine.js + glue.js
  curve_ui.js            core.js + ui.js
  CurveEditor.maxpat     le patch (JSON) : a coller dans un "Max MIDI Effect" vide
  CurveEditor.amxd       meme patch emballe au format .amxd (essai : Live peut le refuser)

Usage : python3 tools/build_device.py
"""
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
OUT = ROOT / "device"

LANES = 8
DEVICE_W = 1000
DEVICE_H = 169
FONT = "Arial"

COLOURS = [(0.26, 0.87, 0.74), (0.41, 0.71, 1.0), (0.8, 0.57, 1.0), (1.0, 0.68, 0.44),
           (1.0, 0.47, 0.6), (0.9, 0.84, 0.46), (0.49, 0.89, 0.93), (0.64, 0.86, 0.51)]


class Patch:
    """Un patcher Max : boites + liaisons, avec controle des identifiants."""

    def __init__(self):
        self.boxes = []
        self.lines = []
        self.counter = 0
        self.by_id = {}

    def add(self, maxclass, text=None, rect=None, present=None, inl=1, outl=0, outtypes=None, **attrs):
        self.counter += 1
        ident = "obj-%d" % self.counter
        box = {"id": ident, "maxclass": maxclass, "numinlets": inl, "numoutlets": outl,
               "outlettype": outtypes if outtypes is not None else [""] * outl,
               "patching_rect": list(rect) if rect else [20.0, 20.0, 80.0, 22.0]}
        if text is not None:
            box["text"] = text
        if present is not None:
            box["presentation"] = 1
            box["presentation_rect"] = list(present)
        box.update(attrs)
        self.boxes.append({"box": box})
        self.by_id[ident] = box
        return ident

    def obj(self, text, rect, inl=1, outl=1, outtypes=None, **attrs):
        return self.add("newobj", text=text, rect=rect, inl=inl, outl=outl, outtypes=outtypes, **attrs)

    def msg(self, text, rect, **attrs):
        return self.add("message", text=text, rect=rect, inl=2, outl=1, outtypes=[""], **attrs)

    def comment(self, text, rect, present=None, size=9.0, **attrs):
        return self.add("comment", text=text, rect=rect, present=present, inl=1, outl=0,
                        fontsize=size, fontname=FONT, **attrs)

    def link(self, src, outlet, dst, inlet=0):
        self.lines.append({"patchline": {"destination": [dst, inlet], "source": [src, outlet]}})

    def patcher_dict(self, extra):
        d = {"fileversion": 1,
             "appversion": {"major": 8, "minor": 6, "revision": 0, "architecture": "x64", "modernui": 1},
             "classnamespace": "box", "rect": [60.0, 80.0, 1100.0, 720.0],
             "bglocked": 0, "openinpresentation": 1, "default_fontsize": 10.0, "default_fontface": 0,
             "default_fontname": FONT, "gridonopen": 1, "gridsize": [5.0, 5.0], "gridsnaponopen": 1,
             "objectsnaponopen": 1, "statusbarvisible": 2, "toolbarvisible": 1, "lefttoolbarpinned": 0,
             "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
             "toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
             "enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0, "description": "", "digest": "",
             "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
             "boxes": self.boxes, "lines": self.lines, "dependency_cache": [], "autosave": 0}
        d.update(extra)
        return d


def live_attrs(longname, short, kind, lo, hi, initial, unit=0, enable=1):
    """Attributs enregistres d'un objet live.* branche sur les parametres de Live."""
    valueof = {"parameter_longname": longname, "parameter_mmax": float(hi), "parameter_mmin": float(lo),
               "parameter_shortname": short, "parameter_type": kind, "parameter_unitstyle": unit,
               "parameter_initial_enable": 1, "parameter_initial": [float(initial)]}
    return {"parameter_enable": enable, "saved_attribute_attributes": {"valueof": valueof}}


def colour(rgb, alpha=1.0):
    return [rgb[0], rgb[1], rgb[2], alpha]


def build_tools_patch():
    """Sous-patch [p tools] : fenetre "Outils" (nom, description, code, exports)."""
    t = Patch()
    t.comment("Courbe", [10, 10, 300, 20], present=[10, 8, 200, 20], size=14.0, varname="lane_title")
    t.comment("Nom", [10, 40, 60, 20], present=[10, 36, 60, 18])
    name_edit = t.add("textedit", rect=[70, 40, 300, 22], present=[70, 34, 270, 22], inl=1, outl=4,
                      outtypes=["", "int", "", ""], varname="name_edit", lines=1, bangmode=0,
                      bgcolor=[0.13, 0.13, 0.15, 1.0], textcolor=[1, 1, 1, 1], fontsize=11.0)
    t.comment("Décrire le mouvement (français)", [10, 70, 300, 20], present=[10, 64, 300, 18])
    desc_edit = t.add("textedit", rect=[10, 90, 560, 60], present=[10, 82, 520, 52], inl=1, outl=4,
                      outtypes=["", "int", "", ""], varname="desc_edit", lines=3, bangmode=0,
                      bgcolor=[0.13, 0.13, 0.15, 1.0], textcolor=[1, 1, 1, 1], fontsize=11.0)
    t.comment("Code avancé (anglais : duration:, start:, ramp, hold, wave, saw)", [10, 160, 400, 20],
              present=[10, 138, 400, 18])
    code_edit = t.add("textedit", rect=[10, 180, 560, 60], present=[10, 156, 520, 52], inl=1, outl=4,
                      outtypes=["", "int", "", ""], varname="code_edit", lines=3, bangmode=0,
                      bgcolor=[0.13, 0.13, 0.15, 1.0], textcolor=[1, 1, 1, 1], fontsize=11.0)
    t.comment("Interprétation", [10, 250, 100, 20], present=[10, 214, 100, 18])
    t.comment(" ", [110, 250, 450, 20], present=[100, 214, 430, 34], varname="interp", textcolor=[0.8, 0.9, 1, 1])
    t.comment(" ", [10, 280, 450, 20], present=[10, 252, 520, 20], varname="msg", textcolor=[1, 0.85, 0.5, 1])
    t.add("jsui", rect=[10, 310, 520, 110], present=[10, 276, 520, 110], inl=1, outl=2, outtypes=["", ""],
          filename="curve_ui.js", varname="preview")
    # l'apercu ne doit jamais modifier la courbe
    lb = t.obj("loadmess setpreview 1", [320, 310, 140, 22])
    t.link(lb, 0, [x["box"]["id"] for x in t.boxes if x["box"].get("varname") == "preview"][0], 0)

    send = t.obj("s ---cmd", [600, 400, 70, 22], outl=0)

    def text_out(edit, which, y):
        pp = t.obj("prepend text %s" % which, [680, y, 130, 22])
        t.link(edit, 0, pp, 0)
        t.link(pp, 0, send, 0)

    text_out(name_edit, "name", 100)
    text_out(desc_edit, "desc", 130)
    text_out(code_edit, "code", 160)

    def button(label, cmd, edit, rect, present):
        b = t.add("live.text", rect=rect, present=present, inl=1, outl=2, outtypes=["", "float"],
                  text=label, mode=0, parameter_enable=0, fontsize=10.0, bgcolor=[0.22, 0.22, 0.26, 1.0],
                  bgoncolor=[0.4, 0.5, 0.7, 1.0], textcolor=[1, 1, 1, 1], textoncolor=[1, 1, 1, 1])
        sel = t.obj("route 1 bang", [rect[0], rect[1] + 24, 70, 22], outl=3, outtypes=["", "", ""])
        fan = t.obj("t b b", [rect[0], rect[1] + 48, 40, 22], outl=2, outtypes=["bang", "bang"])
        m = t.msg("tools %s" % cmd, [rect[0], rect[1] + 72, 120, 22])
        t.link(b, 0, sel, 0)
        t.link(sel, 0, fan, 0)
        t.link(sel, 1, fan, 0)
        if edit:
            bg = t.msg("bang", [rect[0] + 60, rect[1] + 72, 40, 22])
            t.link(fan, 1, bg, 0)
            t.link(bg, 0, edit, 0)
        t.link(fan, 0, m, 0)
        t.link(m, 0, send, 0)
        return b

    button("Prévisualiser", "preview_desc", desc_edit, [10, 440, 90, 20], [330, 62, 90, 20])
    button("Appliquer", "apply_desc", None, [110, 440, 80, 20], [424, 62, 70, 20])
    return t, dict(desc_edit=desc_edit, code_edit=code_edit, name_edit=name_edit, send=send, button=button)


def build():
    top = Patch()
    # ---------- passage du MIDI et sorties de CC ----------
    midiin = top.obj("midiin", [20, 20, 50, 22], inl=1, outl=1)
    midiout = top.obj("midiout", [20, 60, 55, 22], inl=1, outl=0)
    top.link(midiin, 0, midiout, 0)

    engine = top.obj("js curve_engine.js", [20, 200, 130, 22], inl=1, outl=3, outtypes=["", "", ""],
                    varname="engine")
    ctl = top.obj("ctlout", [20, 260, 140, 22], inl=3, outl=0)
    top.link(engine, 0, ctl, 0)
    top.link(engine, 1, ctl, 1)
    top.link(engine, 2, ctl, 2)

    qm = top.obj("qmetro 15", [200, 140, 70, 22], inl=2, outl=1)
    top.link(qm, 0, engine, 0)
    # qmetro envoie un bang ; le moteur le recoit comme message "bang"
    thisdev = top.obj("live.thisdevice", [330, 20, 100, 22], inl=1, outl=3, outtypes=["", "int", "int"])
    dly = top.obj("delay 300", [330, 50, 70, 22], inl=2, outl=1, outtypes=["bang"])
    fan = top.obj("t b b", [330, 80, 40, 22], outl=2, outtypes=["bang", "bang"])
    start = top.msg("1", [380, 110, 30, 22])
    ready = top.msg("ready", [330, 110, 45, 22])
    top.link(thisdev, 0, dly, 0)
    top.link(dly, 0, fan, 0)
    top.link(fan, 1, start, 0)
    top.link(start, 0, qm, 0)
    top.link(fan, 0, ready, 0)
    top.link(ready, 0, engine, 0)

    # ---------- etat enregistre avec le set Live ----------
    state = top.add("newobj", text="dict ---state", rect=[460, 20, 100, 22], inl=2, outl=4,
                    outtypes=["dictionary", "", "", ""], varname="state", parameter_enable=1,
                    saved_attribute_attributes={"valueof": {"parameter_longname": "Etat des courbes",
                                                            "parameter_shortname": "Etat", "parameter_type": 3}})
    top.link(state, 0, engine, 0)

    # ---------- dialogues de fichier ----------
    savedlg = top.obj("savedialog", [460, 70, 80, 22], inl=1, outl=3, outtypes=["", "", "bang"], varname="savedlg")
    opendlg = top.obj("opendialog", [560, 70, 80, 22], inl=1, outl=2, outtypes=["", "bang"], varname="opendlg")
    pp1 = top.obj("prepend dialog_path", [460, 110, 120, 22])
    pp2 = top.obj("prepend dialog_path", [560, 110, 120, 22])
    cancel = top.msg("dialog_path cancel", [620, 150, 120, 22])
    top.link(savedlg, 0, pp1, 0)
    top.link(opendlg, 0, pp2, 0)
    top.link(pp1, 0, engine, 0)
    top.link(pp2, 0, engine, 0)
    top.link(savedlg, 2, cancel, 0)
    top.link(opendlg, 1, cancel, 0)
    top.link(cancel, 0, engine, 0)

    # ---------- messages venant de la fenetre Outils ----------
    recv = top.obj("r ---cmd", [700, 20, 70, 22], inl=0, outl=1)
    top.link(recv, 0, engine, 0)

    # ---------- editeur de courbe ----------
    ED_X, ED_Y, ED_W, ED_H = 4, 39, 700, 104
    editor = top.add("jsui", rect=[700, 200, ED_W, ED_H], present=[ED_X, ED_Y, ED_W, ED_H], inl=1, outl=2,
                     outtypes=["", ""], filename="curve_ui.js", varname="editor")

    # ---------- onglets (un par ligne) ----------
    def trig(src, dst, dst_inlet=0, outlet=0):
        """Declenche dst quand src envoie 1 ou bang (selon la version, un bouton live.text sort l'un ou l'autre)."""
        r = top.obj("route 1 bang", [20, 600, 70, 22], outl=3, outtypes=["", "", ""])
        top.link(src, outlet, r, 0)
        top.link(r, 0, dst, dst_inlet)
        top.link(r, 1, dst, dst_inlet)
        return r

    TAB_W = 123
    for i in range(LANES):
        sel = top.add("live.text", rect=[20 + i * 40, 320, 30, 18], present=[4 + i * (TAB_W + 1), 2, TAB_W, 16],
                      inl=1, outl=2, outtypes=["", "float"], varname="sel%d" % i, text="Courbe %d" % (i + 1),
                      texton="Courbe %d" % (i + 1), mode=1, parameter_enable=0, fontsize=10.0,
                      bgcolor=[0.2, 0.2, 0.24, 1.0], bgoncolor=colour(COLOURS[i]), textcolor=[1, 1, 1, 1],
                      textoncolor=[0, 0, 0, 1])
        sm = top.msg("select %d" % i, [20 + i * 40, 370, 60, 22])
        trig(sel, sm)
        top.link(sm, 0, engine, 0)

    # ---------- reglages de la ligne affichee (colonne de droite) ----------
    # Les 8 jeux de reglages sont superposes ; le JS cache ceux des autres lignes (hidden).
    spec = {  # cle : (nom, type 0 = float 1 = int, min, max, unite)
        "channel": ("Canal", 1, 1, 16, 0), "cc": ("CC", 1, 0, 127, 0), "min": ("Min", 0, 0, 100, 5),
        "max": ("Max", 0, 0, 100, 5), "bars": ("Mesures", 1, 1, 16, 0), "offset": ("Phase", 0, 0, 100, 5),
        "smooth": ("Lissage", 0, 0, 500, 2), "depth": ("Profondeur", 0, 0, 100, 5), "value": ("Valeur", 1, 0, 127, 0)}
    labels = {"on": "On", "channel": "Canal", "cc": "CC", "min": "Min", "max": "Max", "bars": "Mesures",
              "offset": "Phase", "smooth": "Lissage", "depth": "Profond.", "value": "Valeur"}
    initial = {"channel": 16, "min": 0, "max": 100, "bars": 4, "offset": 0, "smooth": 20, "depth": 100, "value": 64}
    col = [["on", "channel", "cc", "min", "max"], ["bars", "offset", "smooth", "depth", "value"]]
    LX = [712, 856]          # etiquettes
    CX = [768, 916]          # controles
    CW = 52
    PY0, PITCH, PH = 39, 17, 15
    pos = {}
    for c in range(2):
        for r, key in enumerate(col[c]):
            y = PY0 + r * PITCH
            top.comment(labels[key], [600, 20, 40, 18], present=[LX[c], y, CX[c] - LX[c], PH], size=9.0,
                        textcolor=[0.75, 0.75, 0.8, 1.0])
            pos[key] = [CX[c], y, 16 if key == "on" else CW, PH]
    pos["man"] = [LX[0], PY0 + 5 * PITCH, CX[0] + CW - LX[0], PH]
    for i in range(LANES):
        on = top.add("live.toggle", rect=[20 + i * 40, 400, 20, 20], present=pos["on"], inl=1, outl=1,
                     outtypes=[""], varname="p%d_on" % i, activebgcolor=colour(COLOURS[i]),
                     **live_attrs("L%d On" % (i + 1), "On", 2, 0, 1, 0, 0))
        pr = top.obj("prepend p %d on" % i, [20 + i * 40, 430, 90, 22])
        top.link(on, 0, pr, 0)
        top.link(pr, 0, engine, 0)
        for key in ("channel", "cc", "min", "max", "bars", "offset", "smooth", "depth", "value"):
            name, kind, lo, hi, unit = spec[key]
            ini = (20 + i) if key == "cc" else initial[key]
            num = top.add("live.numbox", rect=[20 + i * 40, 460, 40, 15], present=pos[key], inl=1, outl=2,
                          outtypes=["", "float"], varname="p%d_%s" % (i, key), fontsize=9.0,
                          **live_attrs("L%d %s" % (i + 1, name), name, kind, lo, hi, ini, unit))
            pr = top.obj("prepend p %d %s" % (i, key), [20 + i * 40, 490, 110, 22])
            top.link(num, 0, pr, 0)
            top.link(pr, 0, engine, 0)
        man = top.add("live.text", rect=[20 + i * 40, 520, 30, 18], present=pos["man"], inl=1, outl=2,
                      outtypes=["", "float"], varname="man%d" % i, text="AUTO", mode=0, parameter_enable=0,
                      fontsize=9.0, bgcolor=[0.2, 0.2, 0.24, 1.0], textcolor=[0.8, 0.9, 1, 1])
        mm = top.msg("resume %d" % i, [20 + i * 40, 570, 70, 22])
        trig(man, mm)
        top.link(mm, 0, engine, 0)

    # ---------- barre d'outils (une rangee sous les onglets) ----------
    BG = [0.2, 0.2, 0.24, 1.0]
    R1, H = 20, 17

    def tool_button(label, name, present):
        b = top.add("live.text", rect=[20, 600, 50, 18], present=present, inl=1, outl=2, outtypes=["", "float"],
                    text=label, mode=0, parameter_enable=0, fontsize=9.0, bgcolor=BG, bgoncolor=[0.4, 0.5, 0.7, 1.0],
                    textcolor=[1, 1, 1, 1], textoncolor=[1, 1, 1, 1])
        m = top.msg("btn %s 1" % name, [20, 650, 90, 22])
        trig(b, m)
        top.link(m, 0, engine, 0)
        return b

    def menu(items, varname, present, target, prefix):
        flat = []
        for k, it in enumerate(items):
            if k:
                flat.append(",")
            flat.append(it)
        m = top.add("umenu", rect=[300, 600, 90, 22], present=present, inl=1, outl=3, outtypes=["int", "", ""],
                    varname=varname, items=flat, fontsize=9.0, bgcolor=BG, textcolor=[1, 1, 1, 1])
        if prefix:
            pp = top.obj("prepend %s" % prefix, [300, 625, 110, 22])
            top.link(m, 0, pp, 0)
            top.link(pp, 0, target, 0)
        return m

    x = 4
    tool_button("Libre", "free", [x, R1, 40, H]); x += 42
    tool_button("Points", "points", [x, R1, 44, H]); x += 46
    shape = menu(["Forme...", "Vague", "Rampe +", "Rampe -", "Triangle", "Douce", "Paliers"], "shapemenu",
                 [x, R1, 76, H], engine, "shape_preset"); x += 78
    brush = menu(["Trait libre", "Motif rampe", "Motif triangle", "Motif sinus"], "brushmenu",
                 [x, R1, 90, H], editor, "setbrush"); x += 92
    snap = top.add("live.text", rect=[300, 660, 50, 18], present=[x, R1, 56, H], inl=1, outl=2,
                   outtypes=["", "float"], varname="snap", text="Aimant", texton="Aimant", mode=1,
                   parameter_enable=0, fontsize=9.0, bgcolor=BG, bgoncolor=[0.3, 0.6, 0.5, 1.0],
                   textcolor=[1, 1, 1, 1], textoncolor=[1, 1, 1, 1])
    sp = top.obj("prepend setsnap", [300, 685, 100, 22])
    top.link(snap, 0, sp, 0)
    top.link(sp, 0, editor, 0)
    x += 58
    grid = menu(["Grille 4", "Grille 8", "Grille 16", "Grille 32", "Grille 64"], "gridmenu",
                [x, R1, 70, H], editor, "setgridindex"); x += 72
    seg = menu(["Courbe", "Courbe en S", "Palier", "Escalier", "Onde", "Triangle", "Impulsion"], "segmenu",
               [x, R1, 82, H], editor, "shape_seg"); x += 84

    # menu "Actions" : copier, coller, annuler, verrouiller, inverser, lisser, etirer, pente
    actions = menu(["Actions...", "Copier", "Coller", "Annuler", "Verrouiller", "Inverser", "Lisser", "Étirer +",
                    "Étirer -", "Pente -", "Pente +"], "actmenu", [x, R1, 84, H], None, None)
    x += 86
    tb = top.obj("t i b", [300, 700, 40, 22], outl=2, outtypes=["int", "bang"])
    back = top.msg("set 0", [350, 725, 40, 22])
    sw = top.obj("sel 1 2 3 4 5 6 7 8 9 10", [300, 750, 190, 22], outl=11, outtypes=[""] * 11)
    top.link(actions, 0, tb, 0)
    top.link(tb, 1, back, 0)
    top.link(back, 0, actions, 0)
    top.link(tb, 0, sw, 0)
    acts = [("btn copy 1", engine), ("btn paste 1", engine), ("btn undo 1", engine), ("btn lock 1", engine),
            ("btn invert 1", engine), ("btn smooth 1", engine), ("stretch 1", editor), ("stretch -1", editor),
            ("tilt -1", editor), ("tilt 1", editor)]
    for k, (text, dst) in enumerate(acts):
        mm = top.msg(text, [300 + k * 70, 780, 70, 22])
        top.link(sw, k, mm, 0)
        top.link(mm, 0, dst, 0)

    tool_button("Varier", "vary", [x, R1, 46, H]); x += 48
    vary = top.add("live.numbox", rect=[300, 730, 40, 15], present=[x, R1, 34, H], inl=1, outl=2,
                   outtypes=["", "float"], varname="vary_amount", fontsize=8.0,
                   **live_attrs("Variation %", "Var", 0, 0, 100, 5, 5, enable=0))
    vp = top.obj("prepend vary_amount", [300, 755, 110, 22])
    top.link(vary, 0, vp, 0)
    top.link(vp, 0, engine, 0)
    x += 36
    tool_button("Lisser", "smooth", [x, R1, 44, H]); x += 46
    smooth = top.add("live.numbox", rect=[420, 730, 40, 15], present=[x, R1, 34, H], inl=1, outl=2,
                     outtypes=["", "float"], varname="smooth_amount", fontsize=8.0,
                     **live_attrs("Lissage %", "Liss", 0, 0, 100, 30, 5, enable=0))
    sp2 = top.obj("prepend smooth_amount", [420, 755, 120, 22])
    top.link(smooth, 0, sp2, 0)
    top.link(sp2, 0, engine, 0)
    x += 36
    tool_button("Outils...", "tools", [x, R1, 56, H]); x += 58
    assert x <= 996, "barre d'outils trop large : %d" % x

    # valeurs affichees au chargement (sans sortie)
    for text, dst in [("loadmess set 2", grid), ("loadmess set 1", snap), ("loadmess set 5", vary),
                      ("loadmess set 30", smooth)]:
        lm = top.obj(text, [500, 600, 90, 22])
        top.link(lm, 0, dst, 0)
    lmv = top.obj("loadmess vary_amount 5", [500, 720, 130, 22])
    lms = top.obj("loadmess smooth_amount 30", [500, 750, 150, 22])
    top.link(lmv, 0, engine, 0)
    top.link(lms, 0, engine, 0)

    # ---------- etat ----------
    top.comment("Curve Editor M4L - ANKS Labs", [20, 800, 200, 20], present=[4, 155, 700, 12], size=8.0,
                varname="status", textcolor=[0.85, 0.85, 0.9, 1.0])

    # ---------- fenetre Outils ----------
    sub, h = build_tools_patch()
    # boutons de la fenetre Outils (suite)
    h["button"]("Prévisualiser", "preview_code", h["code_edit"], [10, 520, 90, 20], [330, 136, 90, 20])
    h["button"]("Appliquer", "apply_code", None, [110, 520, 80, 20], [424, 136, 70, 20])
    h["button"]("Renommer", "rename", h["name_edit"], [200, 520, 80, 20], [346, 34, 70, 20])
    h["button"]("Exporter .mid", "export_mid", None, [290, 520, 90, 20], [10, 392, 100, 20])
    h["button"]("Exporter session", "export_session", None, [390, 520, 100, 20], [116, 392, 110, 20])
    h["button"]("Importer session", "import_session", None, [500, 520, 100, 20], [232, 392, 110, 20])
    sub_dict = sub.patcher_dict({"rect": [120.0, 120.0, 560.0, 440.0], "openinpresentation": 1,
                                 "devicewidth": 0.0})
    tools = top.add("newobj", text="p tools", rect=[700, 260, 60, 22], inl=1, outl=0, outtypes=[],
                    varname="tools", patcher=sub_dict)
    return top.patcher_dict({"devicewidth": float(DEVICE_W)})


def bundle():
    OUT.mkdir(exist_ok=True)
    banner = "// Genere par tools/build_device.py : ne pas modifier ici, modifier src/.\n"
    parts = {"curve_engine.js": ["core.js", "engine.js", "glue.js"], "curve_ui.js": ["core.js", "ui.js"]}
    for target, names in parts.items():
        body = banner
        for n in names:
            body += "\n// ===== %s =====\n" % n + (SRC / n).read_text(encoding="utf-8")
        # module.exports : garde pour Node, inoffensive dans Max (typeof module === "undefined")
        (OUT / target).write_text(body, encoding="utf-8", newline="\n")


def amxd_bytes(patcher):
    payload = (json.dumps({"patcher": patcher}, indent="\t", ensure_ascii=False) + "\n\x00").encode("utf-8")
    return (b"ampf" + struct.pack("<I", 4) + b"mmmm" + b"meta" + struct.pack("<I", 4) + struct.pack("<I", 0)
            + b"ptch" + struct.pack("<I", len(payload)) + payload)


def main():
    bundle()
    patcher = build()
    text = json.dumps({"patcher": patcher}, indent="\t", ensure_ascii=False) + "\n"
    (OUT / "CurveEditor.maxpat").write_text(text, encoding="utf-8", newline="\n")
    (OUT / "CurveEditor.amxd").write_bytes(amxd_bytes(patcher))
    print("device/ : curve_engine.js, curve_ui.js, CurveEditor.maxpat, CurveEditor.amxd")


if __name__ == "__main__":
    sys.exit(main())
