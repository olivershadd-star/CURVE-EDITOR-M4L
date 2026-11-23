#!/usr/bin/env python3
"""Verifications statiques de l'appareil genere (pas de Max ici : ce qui peut etre controle l'est).

 1. patch : liaisons valides, noms de script uniques, noms de parametres Live uniques, tout visible dans 169 px
 2. noms de script utilises par le JS (getnamed, p<i>_<cle>, sel<i>, man<i>) presents dans le patch
 3. JS : uniquement ES5 (Max utilise un vieux moteur), aucune syntaxe moderne
"""
import json, re, sys
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
                err("%s : liaison vers un objet inconnu %s" % (label, ident)); continue
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
        # un objet qui envoie sans destination est suspect (sauf sorties finales)
    used_out = {(l["patchline"]["source"][0], l["patchline"]["source"][1]) for l in p["lines"]}
    used_in = {l["patchline"]["destination"][0] for l in p["lines"]}
    for ident, box in ids.items():
        if box["maxclass"] in ("message",) and ident not in used_in:
            err("%s : message sans entree : %s" % (label, box.get("text")))
        if box["maxclass"] == "newobj" and box.get("text", "").startswith("prepend") and (ident, 0) not in used_out:
            err("%s : prepend sans sortie : %s" % (label, box["text"]))
    return names, longs


def main():
    patch = json.loads((DEV / "CurveEditor.maxpat").read_text(encoding="utf-8"))["patcher"]
    names, longs = check_patcher(patch, "principal", patch["devicewidth"], 169)
    sub = names["tools"]["patcher"]
    snames, _ = check_patcher(sub, "tools", 540, 420)

    glue = (DEV / "curve_engine.js").read_text(encoding="utf-8")
    needed = set(re.findall(r'mobj\("([a-z_0-9]+)"\)', glue)) | {"engine"}
    for k in range(8):
        needed |= {"sel%d" % k, "man%d" % k}
        for key in ("on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"):
            if key in ("on", "min", "max", "bars", "offset", "smooth", "depth", "value", "cc", "channel"):
                needed.add("p%d_%s" % (k, key))
    for n in sorted(needed):
        if n not in names:
            err("le JS cherche l'objet '%s' absent du patch" % n)
    ui = (DEV / "curve_ui.js").read_text(encoding="utf-8")
    for n in re.findall(r'patcher\.getnamed\("([a-z_0-9]+)"\)', ui):
        if n not in names:
            err("l'editeur cherche '%s' absent du patch" % n)
    for n in re.findall(r'subobj\("tools", "([a-z_]+)"\)', glue):
        if n not in snames:
            err("le JS cherche '%s' absent de [p tools]" % n)

    # fonctions appelees par les messages du patch : doivent exister dans le JS correspondant
    def messages(p, target_texts):
        out = set()
        for b in p["boxes"]:
            t = b["box"].get("text", "")
            for m in re.finditer(r"^(?:prepend |loadmess )?([a-z_]+)", t):
                out.add(m.group(1))
        return out
    engine_fns = set(re.findall(r"^function ([a-zA-Z_0-9]+)", glue, re.M))
    ui_fns = set(re.findall(r"^function ([a-zA-Z_0-9]+)", ui, re.M))
    to_engine = {"p", "select", "ready", "dictionary", "btn", "resume", "shape_preset", "vary_amount",
                 "smooth_amount", "text", "tools", "dialog_path", "bang"}
    for f in to_engine:
        if f not in engine_fns:
            err("fonction moteur manquante : %s" % f)
    for f in ("setgridindex", "setsnap", "setbrush", "stretch", "tilt", "shape_seg", "view", "playhead", "setpreview"):
        if f not in ui_fns:
            err("fonction editeur manquante : %s" % f)
    # chaque message envoye par le patch a l'editeur / au moteur est connu
    for b in patch["boxes"]:
        t = b["box"].get("text", "")
        if b["box"]["maxclass"] == "message":
            head = t.split()[0]
            if head not in (to_engine | ui_fns | {"1"}):
                err("message inconnu : %s" % t)
        m = re.match(r"prepend (\w+)", t)
        if m and m.group(1) not in (to_engine | ui_fns):
            err("prepend vers une fonction inconnue : %s" % t)

    # ES5
    banned = [(r"=>", "fleche"), (r"\blet\s", "let"), (r"\bconst\s", "const"), (r"`", "gabarit"), (r"\bclass\s", "class"),
              (r"Math\.(fround|sign|trunc|log2|hypot|cbrt)", "Math ES6"), (r"Number\.(isFinite|isInteger|isNaN)", "Number ES6"),
              (r"Array\.from|\.includes\(|\.padStart|\.padEnd|\.startsWith|\.endsWith|\.repeat\(|\.find\(|\.findIndex\(", "methode ES6"),
              (r"Float32Array|Uint8Array|Int32Array|Uint32Array|Float64Array|Uint16Array|Int16Array|ArrayBuffer|\bMap\(|\bSet\(|Symbol", "type ES6"),
              (r"\.\.\.", "spread"), (r"\bfor\s*\([^;)]*\bof\b", "for-of")]
    for f in ("curve_engine.js", "curve_ui.js"):
        text = (DEV / f).read_text(encoding="utf-8")
        for pat, name in banned:
            for m in re.finditer(pat, text):
                line = text.count("\n", 0, m.start()) + 1
                src = text.splitlines()[line - 1]
                if src.strip().startswith("//"):
                    continue
                err("%s ligne %d : %s interdit : %s" % (f, line, name, src.strip()[:80]))
    if errors:
        print("\n".join(errors)); print("\n%d probleme(s)" % len(errors)); return 1
    print("patch : %d objets, %d liaisons ; %d parametres Live ; JS en ES5 : OK" % (len(patch["boxes"]), len(patch["lines"]), len(longs)))
    return 0


sys.exit(main())
