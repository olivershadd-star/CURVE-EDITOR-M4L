#!/usr/bin/env python3
"""Controle de structure du patch genere : JSON valide, liens coherents, conteneur .amxd.

Usage : python3 -I tests/check_device.py
"""
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
errors = []


def check(cond, msg):
    if not cond:
        errors.append(msg)
        print("ECHEC :", msg)


maxpat = json.loads((ROOT / "device" / "CurveEditor-proto.maxpat").read_text(encoding="utf-8"))
p = maxpat["patcher"]
boxes = {b["box"]["id"]: b["box"] for b in p["boxes"]}
check(len(boxes) == len(p["boxes"]), "identifiants de boites en double")

for ln in p["lines"]:
    s, d = ln["patchline"]["source"], ln["patchline"]["destination"]
    check(s[0] in boxes and d[0] in boxes, "lien vers une boite inexistante %r" % (ln,))
    if s[0] in boxes and d[0] in boxes:
        check(s[1] < boxes[s[0]]["numoutlets"], "sortie %d inexistante sur %s" % (s[1], s[0]))
        check(d[1] < boxes[d[0]]["numinlets"], "entree %d inexistante sur %s" % (d[1], d[0]))

longnames = [b["saved_attribute_attributes"]["valueof"]["parameter_longname"]
             for b in boxes.values() if "saved_attribute_attributes" in b]
check(len(longnames) == len(set(longnames)), "noms de parametres en double")
check(len(longnames) == 12, "attendu 12 parametres Live (2 lignes x 6), trouve %d" % len(longnames))

texts = [b.get("text", "") for b in boxes.values()]
check("midiin" in texts and "midiout" in texts, "chemin des notes midiin -> midiout absent")
midiin = [i for i, b in boxes.items() if b.get("text") == "midiin"][0]
midiout = [i for i, b in boxes.items() if b.get("text") == "midiout"][0]
check(any(l["patchline"]["source"][0] == midiin and l["patchline"]["destination"][0] == midiout
          for l in p["lines"]), "midiin n'est pas relie a midiout")
check("js curve_lanes.js" in texts, "objet js absent")
check("ctlout" in texts, "ctlout absent")

js_id = [i for i, b in boxes.items() if b.get("text") == "js curve_lanes.js"][0]
ctl_id = [i for i, b in boxes.items() if b.get("text") == "ctlout"][0]
for outlet in range(3):
    check(any(l["patchline"]["source"] == [js_id, outlet] and l["patchline"]["destination"] == [ctl_id, outlet]
              for l in p["lines"]), "js sortie %d non reliee a ctlout" % outlet)

for i, b in boxes.items():
    if b.get("presentation"):
        r = b["presentation_rect"]
        check(r[0] + r[2] <= p["devicewidth"], "%s depasse la largeur de l'appareil" % i)
        check(r[1] + r[3] <= 169, "%s depasse la hauteur maximale (169) de l'appareil" % i)

raw = (ROOT / "device" / "CurveEditor-proto.amxd").read_bytes()
check(raw[:4] == b"ampf", "en-tete ampf absent")
check(raw[8:12] == b"mmmm", "type d'appareil different d'un effet MIDI")
check(raw[12:16] == b"meta", "bloc meta absent")
check(raw[24:28] == b"ptch", "bloc ptch absent")
length = struct.unpack("<I", raw[28:32])[0]
check(len(raw) == 32 + length, "longueur du bloc ptch incoherente")
body = raw[32:]
check(json.loads(body.rstrip(b"\x00\n").decode("utf-8")) == maxpat, ".amxd et .maxpat differents")

print("\n%d erreur(s)" % len(errors))
sys.exit(1 if errors else 0)
