#!/usr/bin/env python3
"""Verifications statiques de l'appareil genere (pas de Max ici : tout ce qui peut etre controle l'est).

 1. patch : liaisons valides, noms de script et de parametres uniques, tout visible dans le bandeau (169 px)
 2. fenetre d'edition : taille identique entre patch et jsui (sinon la souris est decalee), champs texte dans la fenetre
 3. protocole : chaque message envoye par le JS existe de l'autre cote ; chaque objet cherche par nom existe
 4. JS : ES5 uniquement, ASCII uniquement, aucun nom de fonction en double dans un meme fichier
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEV = ROOT / "device"
errors = []


def err(msg):
    errors.append(msg)


def check_patcher(p, label, width, height):
    ids = {}
    for b in p["boxes"]:
        box = b["box"]
        if box["id"] in ids:
            err("%s : identifiant en double %s" % (label, box["id"]))
        ids[box["id"]] = box
    for l in p["lines"]:
        pl = l["patchline"]
        for end, key in (("source", "numoutlets"), ("destination", "numinlets")):
            ident, n = pl[end]
            if ident not in ids:
                err("%s : liaison vers un objet inconnu %s" % (label, ident))
                continue
            if n >= ids[ident][key]:
                err("%s : %s %s (%s) n'a pas de connecteur %d" % (label, ids[ident]["maxclass"], ident, ids[ident].get("text", ""), n))
    names, longs = {}, {}
    for box in ids.values():
        v = box.get("varname")
        if v:
            if v in names:
                err("%s : nom de script en double %s" % (label, v))
            names[v] = box
        lg = box.get("saved_attribute_attributes", {}).get("valueof", {}).get("parameter_longname")
        if lg and box.get("parameter_enable"):
            if lg in longs:
                err("%s : nom de parametre Live en double %s" % (label, lg))
            longs[lg] = box
        if box.get("presentation"):
            x, y, w, h = box["presentation_rect"]
            if x < 0 or y < 0 or x + w > width or y + h > height:
                err("%s : %s hors de la zone visible : %s" % (label, v or box.get("text"), box["presentation_rect"]))
        if box["maxclass"] == "jsui" and box["patching_rect"][2:] != box.get("presentation_rect", box["patching_rect"])[2:]:
            err("%s : jsui %s : tailles patching et presentation differentes (la souris serait decalee)" % (label, v))
    used_in = {l["patchline"]["destination"][0] for l in p["lines"]}
    used_out = {(l["patchline"]["source"][0], l["patchline"]["source"][1]) for l in p["lines"]}
    for ident, box in ids.items():
        if box["maxclass"] == "message" and ident not in used_in:
            err("%s : message sans entree : %s" % (label, box.get("text")))
        if box["maxclass"] == "newobj" and box.get("text", "").startswith("prepend") and (ident, 0) not in used_out:
            err("%s : prepend sans sortie : %s" % (label, box["text"]))
    return ids, names, longs


def functions(text):
    return re.findall(r"^function ([A-Za-z_0-9]+)", text, re.M)


def main():
    patch = json.loads((DEV / "CurveEditor.maxpat").read_text(encoding="utf-8"))["patcher"]
    ids, names, longs = check_patcher(patch, "bandeau", patch["devicewidth"], 169)
    sub = names["editor"]["patcher"]
    ui_text = (DEV / "curve_ui.js").read_text(encoding="utf-8")
    eng_text = (DEV / "curve_engine.js").read_text(encoding="utf-8")
    src_ui = (ROOT / "src" / "ui.js").read_text(encoding="utf-8")
    win = re.search(r"var W = (\d+), H = (\d+);", src_ui)
    ww, wh = int(win.group(1)), int(win.group(2))
    sids, snames, _ = check_patcher(sub, "fenetre", ww, wh)
    if sub["rect"][2:] != [float(ww), float(wh)]:
        err("fenetre : taille du sous-patch %s differente de ui.js (%d x %d)" % (sub["rect"][2:], ww, wh))
    if snames["ui"]["patching_rect"] != [0, 0, ww, wh]:
        err("fenetre : le jsui doit couvrir toute la fenetre")
    layout = json.loads(re.search(r"var LAYOUT_TEXT = (\{.*?\});", src_ui).group(1))
    for key, name in (("name", "name_edit"), ("body", "body_edit")):
        if snames[name]["presentation_rect"] != layout[key]:
            err("fenetre : %s ne correspond pas a LAYOUT_TEXT" % name)
        x, y, w, h = layout[key]
        if x + w > ww or y + h > wh:
            err("fenetre : %s sort de la fenetre" % name)

    # objets cherches par nom
    for n in sorted(set(re.findall(r'mobj\("([a-z_0-9]+)"\)', eng_text))):
        if n not in names:
            err("le moteur cherche l'objet '%s' absent du bandeau" % n)
    for k in range(8):
        for key in ("on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"):
            if "p%d_%s" % (k, key) not in names:
                err("reglage Live manquant : p%d_%s" % (k, key))
    for n in set(re.findall(r'getObj\("([a-z_0-9]+)"\)', ui_text)) | {"name_edit", "body_edit"}:
        if n not in snames:
            err("la fenetre cherche l'objet '%s' absent de [p editor]" % n)

    # protocole moteur <-> fenetre
    eng_fn, ui_fn = set(functions(eng_text)), set(functions(ui_text))
    for sel in set(re.findall(r'\bsend\("([a-z_]+)"', ui_text)):
        if sel not in eng_fn:
            err("la fenetre envoie '%s' que le moteur ne comprend pas" % sel)
    for sel in set(re.findall(r'toUi\("([a-z_]+)"', eng_text)) | set(re.findall(r'toUi\.apply\(this, \["([a-z_]+)"', eng_text)):
        if sel not in ui_fn:
            err("le moteur envoie '%s' que la fenetre ne comprend pas" % sel)
    for sel in ("edit_name", "edit_body"):
        if sel not in ui_fn:
            err("fonction manquante dans la fenetre : %s" % sel)
    # messages du patch
    known = eng_fn | ui_fn
    for p, label in ((patch, "bandeau"), (sub, "fenetre")):
        for b in p["boxes"]:
            t = b["box"].get("text", "")
            if b["box"]["maxclass"] == "message" and t.split()[0] not in known | {"1", "open"}:
                err("%s : message inconnu : %s" % (label, t))
            m = re.match(r"prepend (\w+)", t)
            if m and m.group(1) not in known:
                err("%s : prepend vers une fonction inconnue : %s" % (label, t))
    # canaux send / receive : chaque nom a un emetteur et un recepteur
    def bus(p):
        s, r = set(), set()
        for b in p["boxes"]:
            t = b["box"].get("text", "")
            if t.startswith("s "):
                s.add(t[2:])
            if t.startswith("r "):
                r.add(t[2:])
        return s, r
    s1, r1 = bus(patch)
    s2, r2 = bus(sub)
    for name in (s1 | s2):
        if name not in (r1 | r2):
            err("emetteur sans recepteur : %s" % name)
    for name in (r1 | r2):
        if name not in (s1 | s2):
            err("recepteur sans emetteur : %s" % name)

    # JS : ES5, ASCII, pas de doublons
    banned = [(r"=>", "fleche"), (r"\blet\s", "let"), (r"\bconst\s", "const"), (r"`", "gabarit"), (r"\bclass\s", "class"),
              (r"Math\.(fround|sign|trunc|log2|hypot|cbrt)", "Math ES6"), (r"Number\.(isFinite|isInteger|isNaN)", "Number ES6"),
              (r"Array\.from|\.includes\(|\.padStart|\.padEnd|\.startsWith|\.endsWith|\.repeat\(|\.find\(|\.findIndex\(", "methode ES6"),
              (r"Float32Array|Uint8Array|Int32Array|Uint32Array|Float64Array|Uint16Array|Int16Array|ArrayBuffer|\bMap\(|\bSet\(|Symbol", "type ES6"),
              (r"\.\.\.(?=[A-Za-z_\[(])", "spread"), (r"\bfor\s*\([^;)]*\bof\b", "for-of")]
    for f, text in (("curve_engine.js", eng_text), ("curve_ui.js", ui_text)):
        for i, c in enumerate(text):
            if ord(c) > 127:
                err("%s : caractere non ASCII a la position %d" % (f, i))
                break
        fns = functions(text)
        for fn in set(fns):
            if fns.count(fn) > 1:
                err("%s : fonction definie plusieurs fois (collision) : %s" % (f, fn))
        for pat, name in banned:
            for m in re.finditer(pat, text):
                line = text.count("\n", 0, m.start()) + 1
                src = text.splitlines()[line - 1]
                if src.strip().startswith("//"):
                    continue
                err("%s ligne %d : %s interdit : %s" % (f, line, name, src.strip()[:80]))
    if errors:
        print("\n".join(errors))
        print("\n%d probleme(s)" % len(errors))
        return 1
    print("bandeau : %d objets ; fenetre : %d objets ; %d parametres Live ; JS en ES5 et ASCII : OK"
          % (len(patch["boxes"]), len(sub["boxes"]), len(longs)))
    return 0


sys.exit(main())
