#!/usr/bin/env python3
"""Construit l'appareil Max for Live "Curve Editor M4L" (ANKS Labs) : le VST Curve Mini, en Max.

Produit dans device/ :
  curve_engine.js        core.js + engine.js + glue.js     (objet [js])
  curve_ui.js            core.js + ui.js                   (objet [jsui] de la fenetre d'edition)
  CurveEditor.maxpat     le patch (JSON) : a coller dans un "Max MIDI Effect" vide si le .amxd est refuse
  CurveEditor.amxd       le meme patch emballe au format .amxd

Architecture (voir README) :
  - bandeau Live (169 px) : les 8 interrupteurs On, le bouton "Ouvrir l'editeur", l'etat
  - fenetre d'edition [p editor] : un seul [jsui] dessine toute l'interface du VST (8 onglets, 3 pages),
    plus deux [textedit] poses par-dessus pour la saisie de texte
  - 80 reglages Live (8 lignes x 10) : [live.toggle] / [live.numbox] avec parametres automatisables
  - le moteur [js] parle a la fenetre par [s ---toui] / [r ---ui] (noms locaux a l'appareil)

Usage : python3 tools/build_device.py
"""
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
OUT = ROOT / "device"

LANES = 8
FONT = "Arial"
STRIP_W = 430
COLOURS = [(0.26, 0.87, 0.74), (0.41, 0.71, 1.0), (0.8, 0.57, 1.0), (1.0, 0.68, 0.44),
           (1.0, 0.47, 0.6), (0.9, 0.84, 0.46), (0.49, 0.89, 0.93), (0.64, 0.86, 0.51)]
PARAMS = ["on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"]


def ui_constants():
    """Lit dans ui.js la taille de la fenetre et la position des champs texte (une seule source)."""
    text = (SRC / "ui.js").read_text(encoding="utf-8")
    size = re.search(r"var W = (\d+), H = (\d+);", text)
    layout = re.search(r"var LAYOUT_TEXT = (\{.*?\});", text)
    return int(size.group(1)), int(size.group(2)), json.loads(layout.group(1))


class Patch:
    """Un patcher Max : boites + liaisons."""

    def __init__(self):
        self.boxes = []
        self.lines = []
        self.counter = 0

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
        return ident

    def obj(self, text, rect, inl=1, outl=1, outtypes=None, **attrs):
        return self.add("newobj", text=text, rect=rect, inl=inl, outl=outl, outtypes=outtypes, **attrs)

    def msg(self, text, rect, **attrs):
        return self.add("message", text=text, rect=rect, inl=2, outl=1, outtypes=[""], **attrs)

    def comment(self, text, rect, present=None, size=10.0, **attrs):
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


def live_attrs(longname, short, kind, lo, hi, initial, unit=0):
    """Attributs d'un objet live.* branche sur les parametres de Live (automatisable, mappable)."""
    valueof = {"parameter_longname": longname, "parameter_mmax": float(hi), "parameter_mmin": float(lo),
               "parameter_shortname": short, "parameter_type": kind, "parameter_unitstyle": unit,
               "parameter_initial_enable": 1, "parameter_initial": [float(initial)]}
    return {"parameter_enable": 1, "saved_attribute_attributes": {"valueof": valueof}}


def build_editor_patch(win_w, win_h, text_rects):
    """Sous-patch [p editor] : la fenetre d'edition."""
    e = Patch()
    e.add("inlet", rect=[10, 10, 30, 30], inl=0, outl=1, outtypes=[""], comment="")
    ui = e.add("jsui", rect=[0, 0, win_w, win_h], present=[0, 0, win_w, win_h], inl=1, outl=1, outtypes=[""],
               filename="curve_ui.js", varname="ui")
    for name, key in (("name_edit", "name"), ("body_edit", "body")):
        x, y, w, h = text_rects[key]
        te = e.add("textedit", rect=[x, y + win_h + 20, w, h], present=[x, y, w, h], inl=1, outl=4,
                   outtypes=["", "int", "", ""], varname=name, hidden=1, lines=1 if key == "name" else 8,
                   bgcolor=[0.1, 0.12, 0.17, 1.0], textcolor=[0.93, 0.95, 0.94, 1.0], fontsize=12.0,
                   fontname=FONT, border=1, bordercolor=[0.2, 0.26, 0.35, 1.0])
        pp = e.obj("prepend edit_%s" % key, [x + w + 20, y + win_h + 20, 120, 22])
        e.link(te, 0, pp, 0)
        e.link(pp, 0, ui, 0)
    recv = e.obj("r ---toui", [win_w + 40, 20, 80, 22], inl=0, outl=1)
    sendui = e.obj("s ---ui", [win_w + 40, 60, 70, 22], outl=0)
    e.link(recv, 0, ui, 0)
    e.link(ui, 0, sendui, 0)
    return e.patcher_dict({"rect": [120.0, 80.0, float(win_w), float(win_h)], "openinpresentation": 1,
                           "devicewidth": 0.0})


def build():
    win_w, win_h, text_rects = ui_constants()
    t = Patch()

    # ---------- passage du MIDI et sorties de CC ----------
    midiin = t.obj("midiin", [20, 20, 50, 22], inl=1, outl=1)
    midiout = t.obj("midiout", [20, 60, 55, 22], inl=1, outl=0)
    t.link(midiin, 0, midiout, 0)

    engine = t.obj("js curve_engine.js", [20, 200, 130, 22], inl=1, outl=4, outtypes=["", "", "", ""], varname="engine")
    ctl = t.obj("ctlout", [20, 260, 140, 22], inl=3, outl=0)
    t.link(engine, 0, ctl, 0)
    t.link(engine, 1, ctl, 1)
    t.link(engine, 2, ctl, 2)
    to_ui = t.obj("s ---toui", [200, 260, 80, 22], outl=0)
    t.link(engine, 3, to_ui, 0)
    from_ui = t.obj("r ---ui", [200, 160, 70, 22], inl=0, outl=1)
    t.link(from_ui, 0, engine, 0)

    # ---------- horloge et demarrage ----------
    qm = t.obj("qmetro 15", [330, 140, 70, 22], inl=2, outl=1)
    t.link(qm, 0, engine, 0)
    thisdev = t.obj("live.thisdevice", [330, 20, 100, 22], inl=1, outl=3, outtypes=["", "int", "int"])
    dly = t.obj("delay 300", [330, 50, 70, 22], inl=2, outl=1, outtypes=["bang"])
    fan = t.obj("t b b", [330, 80, 40, 22], outl=2, outtypes=["bang", "bang"])
    start = t.msg("1", [380, 110, 30, 22])
    ready = t.msg("ready", [330, 110, 45, 22])
    t.link(thisdev, 0, dly, 0)
    t.link(dly, 0, fan, 0)
    t.link(fan, 1, start, 0)
    t.link(start, 0, qm, 0)
    t.link(fan, 0, ready, 0)
    t.link(ready, 0, engine, 0)

    # ---------- etat enregistre avec le set Live ----------
    state = t.add("newobj", text="dict ---state", rect=[460, 20, 100, 22], inl=2, outl=4,
                  outtypes=["dictionary", "", "", ""], varname="state", parameter_enable=1,
                  saved_attribute_attributes={"valueof": {"parameter_longname": "Etat des courbes",
                                                          "parameter_shortname": "Etat", "parameter_type": 3}})
    t.link(state, 0, engine, 0)

    # ---------- dialogues de fichier (export / import) ----------
    savedlg = t.obj("savedialog", [460, 70, 80, 22], inl=1, outl=3, outtypes=["", "", "bang"], varname="savedlg")
    opendlg = t.obj("opendialog", [560, 70, 80, 22], inl=1, outl=2, outtypes=["", "bang"], varname="opendlg")
    pp1 = t.obj("prepend dialog_path", [460, 110, 120, 22])
    pp2 = t.obj("prepend dialog_path", [600, 110, 120, 22])
    cancel = t.msg("dialog_path cancel", [620, 150, 120, 22])
    t.link(savedlg, 0, pp1, 0)
    t.link(opendlg, 0, pp2, 0)
    t.link(pp1, 0, engine, 0)
    t.link(pp2, 0, engine, 0)
    t.link(savedlg, 2, cancel, 0)
    t.link(opendlg, 1, cancel, 0)
    t.link(cancel, 0, engine, 0)

    # ---------- les 80 reglages Live ----------
    spec = {  # cle : (nom, type 0 = float 1 = int, min, max, unite)
        "min": ("Min", 0, 0, 100, 5), "max": ("Max", 0, 0, 100, 5), "bars": ("Mesures", 0, 0.25, 16, 1),
        "offset": ("Phase", 0, 0, 100, 5), "smooth": ("Lissage", 0, 0, 500, 2), "depth": ("Profondeur", 0, 0, 100, 5),
        "value": ("Valeur", 1, 0, 127, 0), "cc": ("CC", 1, 0, 127, 0), "channel": ("Canal", 1, 1, 16, 0)}
    initial = {"min": 0, "max": 100, "bars": 4, "offset": 0, "smooth": 20, "depth": 100, "value": 64, "channel": 16}
    for i in range(LANES):
        col = COLOURS[i]
        on = t.add("live.toggle", rect=[20 + i * 40, 400, 20, 20], present=[14 + i * 50, 52, 20, 20], inl=1, outl=1,
                   outtypes=[""], varname="p%d_on" % i, activebgcolor=[col[0], col[1], col[2], 1.0],
                   **live_attrs("L%d On" % (i + 1), "On", 2, 0, 1, 0, 0))
        pr = t.obj("prepend p %d on" % i, [20 + i * 40, 430, 90, 22])
        t.link(on, 0, pr, 0)
        t.link(pr, 0, engine, 0)
        for j, key in enumerate(PARAMS[1:]):
            name, kind, lo, hi, unit = spec[key]
            ini = (20 + i) if key == "cc" else initial[key]
            num = t.add("live.numbox", rect=[20 + i * 130, 470 + j * 36, 60, 15], inl=1, outl=2,
                        outtypes=["", "float"], varname="p%d_%s" % (i, key), fontsize=9.0,
                        **live_attrs("L%d %s" % (i + 1, name), name, kind, lo, hi, ini, unit))
            pp = t.obj("prepend p %d %s" % (i, key), [20 + i * 130, 490 + j * 36, 110, 22])
            t.link(num, 0, pp, 0)
            t.link(pp, 0, engine, 0)

    # ---------- bandeau Live (169 px de haut) ----------
    t.comment("Curve Mini  -  Max for Live", [20, 800, 200, 20], present=[10, 4, 300, 22], size=14.0,
              textcolor=[0.93, 0.95, 0.94, 1.0])
    for i in range(LANES):
        t.comment(str(i + 1), [20 + i * 40, 830, 20, 20], present=[14 + i * 50 + 6, 36, 14, 16], size=10.0,
                  textcolor=[COLOURS[i][0], COLOURS[i][1], COLOURS[i][2], 1.0])
    openbtn = t.add("live.text", rect=[20, 860, 160, 24], present=[12, 84, 170, 28], inl=1, outl=2,
                    outtypes=["", "float"], varname="open_button", text="Ouvrir l'éditeur", mode=0,
                    parameter_enable=0, fontsize=12.0, bgcolor=[0.2, 0.28, 0.4, 1.0],
                    bgoncolor=[0.4, 0.5, 0.7, 1.0], textcolor=[1, 1, 1, 1], textoncolor=[1, 1, 1, 1])
    route = t.obj("route 1 bang", [20, 890, 70, 22], outl=3, outtypes=["", "", ""])
    two = t.obj("t b b", [20, 920, 40, 22], outl=2, outtypes=["bang", "bang"])
    sync = t.msg("sync_all", [70, 950, 60, 22])
    opn = t.msg("open", [20, 950, 40, 22])
    pcontrol = t.obj("pcontrol", [20, 980, 60, 22], inl=1, outl=1)
    t.link(openbtn, 0, route, 0)
    t.link(route, 0, two, 0)
    t.link(route, 1, two, 0)
    t.link(two, 1, sync, 0)
    t.link(sync, 0, engine, 0)
    t.link(two, 0, opn, 0)
    t.link(opn, 0, pcontrol, 0)
    t.comment("Curve Editor M4L", [200, 800, 300, 20], present=[12, 122, STRIP_W - 24, 40], size=10.0,
              varname="status", textcolor=[0.7, 0.78, 0.9, 1.0])

    sub = build_editor_patch(win_w, win_h, text_rects)
    editor = t.add("newobj", text="p editor", rect=[20, 1010, 60, 22], inl=1, outl=0, outtypes=[], varname="editor",
                   patcher=sub)
    t.link(pcontrol, 0, editor, 0)
    return t.patcher_dict({"devicewidth": float(STRIP_W)})


def bundle():
    OUT.mkdir(exist_ok=True)
    banner = "// Genere par tools/build_device.py : ne pas modifier ici, modifier src/.\n"
    parts = {"curve_engine.js": ["core.js", "engine.js", "glue.js"], "curve_ui.js": ["core.js", "ui.js"]}
    for target, names in parts.items():
        body = banner
        for n in names:
            body += "\n// ===== %s =====\n" % n + (SRC / n).read_text(encoding="utf-8")
        # Max lit les .js avec un codage incertain : tout caractere non ASCII devient une sequence \uXXXX
        body = re.sub(r"[^\x00-\x7f]", lambda m: "\\u%04x" % ord(m.group()), body)
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
