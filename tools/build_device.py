#!/usr/bin/env python3
"""Genere l'appareil Max for Live "Curve Editor M4L" (prototype 2 lignes).

Sorties (dans device/) :
  CurveEditor-proto.maxpat   patch au format JSON de Max (copier/coller de secours)
  CurveEditor-proto.amxd     appareil MIDI Max for Live

Usage : python3 tools/build_device.py
"""
import json
import math
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "device"

LANES = 2
POINTS = 16
ROW_H = 80
DEVICE_WIDTH = 500.0


class Patch:
    def __init__(self):
        self.boxes = []
        self.lines = []
        self.n = 0

    def add(self, box):
        self.n += 1
        box["id"] = "obj-%d" % self.n
        self.boxes.append({"box": box})
        return box["id"]

    def connect(self, src, src_out, dst, dst_in):
        self.lines.append({"patchline": {"source": [src, src_out], "destination": [dst, dst_in]}})


def live_param(longname, shortname, ptype, mmin, mmax, initial, extra=None):
    v = {
        "parameter_initial": [initial],
        "parameter_initial_enable": 1,
        "parameter_longname": longname,
        "parameter_mmax": float(mmax),
        "parameter_mmin": float(mmin),
        "parameter_shortname": shortname,
        "parameter_type": ptype,
        "parameter_unitstyle": 0,
    }
    if extra:
        v.update(extra)
    return {"valueof": v}


def numbox(p, x, y, longname, shortname, mmin, mmax, initial, px, py):
    return p.add({
        "maxclass": "live.numbox", "numinlets": 1, "numoutlets": 2,
        "outlettype": ["", "float"], "parameter_enable": 1,
        "patching_rect": [x, y, 45.0, 15.0],
        "presentation": 1, "presentation_rect": [px, py, 45.0, 15.0],
        "saved_attribute_attributes": live_param(longname, shortname, 1, mmin, mmax, initial),
        "varname": longname.replace(" ", "_"),
    })


def toggle(p, x, y, longname, shortname, px, py):
    return p.add({
        "maxclass": "live.toggle", "numinlets": 1, "numoutlets": 1,
        "outlettype": [""], "parameter_enable": 1,
        "patching_rect": [x, y, 24.0, 24.0],
        "presentation": 1, "presentation_rect": [px, py, 24.0, 24.0],
        "saved_attribute_attributes": live_param(
            longname, shortname, 2, 0, 1, 1, {"parameter_enum": ["off", "on"]}),
        "varname": longname.replace(" ", "_"),
    })


def comment(p, text, x, y, w, px, py):
    return p.add({
        "maxclass": "comment", "numinlets": 1, "numoutlets": 0,
        "patching_rect": [x, y, w, 20.0], "text": text, "fontsize": 10.0,
        "presentation": 1, "presentation_rect": [px, py, w, 18.0],
    })


def newobj(p, text, x, y, inlets, outlets, outtypes):
    return p.add({
        "maxclass": "newobj", "numinlets": inlets, "numoutlets": outlets,
        "outlettype": outtypes, "patching_rect": [x, y, 200.0, 22.0], "text": text,
    })


def default_curve(i):
    if i == 0:
        return [0.5 + 0.5 * math.sin(2 * math.pi * k / POINTS) for k in range(POINTS)]
    return [k / (POINTS - 1) for k in range(POINTS)]


def build():
    p = Patch()

    # --- chemin des notes : tout ce qui entre ressort tel quel ---
    midiin = newobj(p, "midiin", 20, 20, 1, 1, ["int"])
    midiout = newobj(p, "midiout", 20, 70, 1, 0, [])
    p.connect(midiin, 0, midiout, 0)

    # --- moteur ---
    js = newobj(p, "js curve_lanes.js", 700, 300, 1, 3, ["", "", ""])
    qm = newobj(p, "qmetro 15 @active 1", 700, 250, 2, 1, ["bang"])
    ctl = newobj(p, "ctlout", 700, 400, 3, 0, [])
    p.connect(qm, 0, js, 0)
    p.connect(js, 0, ctl, 0)   # valeur
    p.connect(js, 1, ctl, 1)   # numero de CC
    p.connect(js, 2, ctl, 2)   # canal

    loadbang = newobj(p, "loadbang", 400, 20, 1, 1, ["bang"])

    for i in range(LANES):
        y0 = 5 + i * ROW_H
        py = y0
        ln = i + 1
        cx = 40 + i * 0
        base_x = 20.0 + i * 0
        # titre + interrupteur
        t = toggle(p, 100 + i * 0, 120 + i * 90, "L%d On" % ln, "On", 6.0, py + 8.0)
        comment(p, "Ligne %d" % ln, 100, 100, 60.0, 4.0, py + 36.0)

        specs = [
            ("CC", "L%d CC" % ln, 0, 127, 20 + i, 40.0, "lcc"),
            ("Canal", "L%d Canal" % ln, 1, 16, 1, 92.0, "lch"),
            ("Mes.", "L%d Mesures" % ln, 1, 16, 1, 144.0, "lbars"),
            ("Min", "L%d Min" % ln, 0, 127, 0, 196.0, "lmin"),
            ("Max", "L%d Max" % ln, 0, 127, 127, 248.0, "lmax"),
        ]
        # toggle -> lon
        pre = newobj(p, "prepend lon %d" % i, 200, 120 + i * 90, 1, 1, [""])
        p.connect(t, 0, pre, 0)
        p.connect(pre, 0, js, 0)
        for k, (lab, longname, mn, mx, init, px, msg) in enumerate(specs):
            comment(p, lab, 200 + k * 60, 100, 45.0, px, py + 6.0)
            nb = numbox(p, 200 + k * 60, 140 + i * 90, longname, lab, mn, mx, init, px, py + 24.0)
            pp = newobj(p, "prepend %s %d" % (msg, i), 200 + k * 60, 180 + i * 90, 1, 1, [""])
            p.connect(nb, 0, pp, 0)
            p.connect(pp, 0, js, 0)

        # editeur de courbe : on dessine a la souris
        ms = p.add({
            "maxclass": "multislider", "numinlets": 1, "numoutlets": 2,
            "outlettype": ["", ""], "size": POINTS, "setminmax": [0.0, 1.0],
            "setstyle": 1, "contdata": 1,
            "patching_rect": [500, 120 + i * 90, 190.0, 72.0],
            "presentation": 1, "presentation_rect": [300.0, py + 2.0, 190.0, 72.0],
            "varname": "courbe_%d" % ln,
        })
        pc = newobj(p, "prepend lcurve %d" % i, 500, 210 + i * 90, 1, 1, [""])
        p.connect(ms, 0, pc, 0)
        p.connect(pc, 0, js, 0)

        # courbe de depart affichee au chargement
        text = " ".join("%.4f" % v for v in default_curve(i))
        msgbox = p.add({
            "maxclass": "message", "numinlets": 2, "numoutlets": 1,
            "outlettype": [""], "patching_rect": [400, 60 + i * 30, 300.0, 22.0],
            "text": text,
        })
        p.connect(loadbang, 0, msgbox, 0)
        p.connect(msgbox, 0, ms, 0)

    patcher = {
        "fileversion": 1,
        "appversion": {"major": 8, "minor": 6, "revision": 0, "architecture": "x64", "modernui": 1},
        "classnamespace": "box",
        "rect": [100.0, 100.0, 900.0, 600.0],
        "bglocked": 0, "openinpresentation": 1,
        "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
        "gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1,
        "objectsnaponopen": 1, "statusbarvisible": 2, "toolbarvisible": 1,
        "lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0, "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0, "boxanimatetime": 200, "enablehscroll": 1, "enablevscroll": 1,
        "devicewidth": DEVICE_WIDTH,
        "description": "Curve Editor M4L - lignes de courbes en CC (prototype)",
        "digest": "", "tags": "", "style": "", "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": p.boxes,
        "lines": p.lines,
    }
    return {"patcher": patcher}


def amxd_bytes(patch_json_text):
    """Conteneur .amxd : en-tete 'ampf' (type 'mmmm' = effet MIDI), bloc meta, bloc ptch."""
    body = patch_json_text.encode("utf-8") + b"\n\x00"
    return (b"ampf" + struct.pack("<I", 4) + b"mmmm"
            + b"meta" + struct.pack("<I", 4) + b"\x00\x00\x00\x00"
            + b"ptch" + struct.pack("<I", len(body)) + body)


def main():
    OUT.mkdir(exist_ok=True)
    text = json.dumps(build(), indent=1, ensure_ascii=False)
    (OUT / "CurveEditor-proto.maxpat").write_text(text + "\n", encoding="utf-8")
    (OUT / "CurveEditor-proto.amxd").write_bytes(amxd_bytes(text))
    print("ecrit :", OUT / "CurveEditor-proto.maxpat", "et", OUT / "CurveEditor-proto.amxd")


if __name__ == "__main__":
    main()
