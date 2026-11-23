# Curve Editor M4L

**Curve Mini en Max for Live** — ANKS Labs. C'est la « version Max » de [Curve Mini](https://github.com/olivershadd-star/Curve-Mini) (VST3) : un vrai **effet MIDI** pour Ableton Live 12. Il laisse passer le MIDI de la piste et y ajoute des CC dessinés par 8 courbes.

Pourquoi : un VST3 déclaré instrument transforme la piste MIDI en piste audio. Un appareil Max for Live de type MIDI Effect garde le MIDI, se chaîne avec les autres effets MIDI et garde les notes.

## Ce qui est repris de Curve Mini

- 8 lignes, chacune avec : On, canal (défaut 16), CC (défaut 20 à 27), min, max, mesures (0,25 à 32), phase, lissage (ms), profondeur, valeur manuelle (0 à 127) et son état AUTO / MAN (clic sur MAN = reprendre la courbe).
- Éditeur de courbe : trait libre avec 3 pinceaux (rampe, triangle, sinus) ou points avec courbure, 7 formes de segment, sélection (Maj + glisser), étirer, pente, grille et aimantation.
- Formes de départ (vague, rampes, triangle, douce, paliers), inverser, varier, lisser, copier, coller, annuler, verrouiller.
- Fenêtre **Outils…** : nom de la ligne, **description en français** (aperçu puis appliquer), **code avancé** (`duration:`, `start:`, `ramp`, `hold`, `wave`, `saw`), export **.mid**, export / import de **session** (.json).
- Les calculs sont portés du C++ et **vérifiés contre lui** : `tests/golden.json` (81 cas) est produit par le vrai code de Curve Mini.

## Ce qui disparaît, car sans objet dans Live

Choix du port MIDI, bouton Connecter, ENVOI, Assigner, transport autonome : l'appareil écrit directement dans la chaîne MIDI de la piste et suit la lecture de Live (position, tempo, signature).

## Installation

Voir `FEUILLE_TEST_LIVE_FR.md`. En deux mots : garder les trois fichiers de `device/` ensemble (`curve_engine.js`, `curve_ui.js`, plus l'appareil), puis glisser `CurveEditor.amxd` sur une piste MIDI. Si Live le refuse, la voie de secours est de coller `CurveEditor.maxpat` dans un « Max MIDI Effect » vide.

## Utilisation

Les lignes sont **éteintes par défaut** : allumer *On* pour entendre les CC. Cliquer le numéro d'une ligne pour l'éditer. Les réglages du tableau sont des paramètres Live : automatisables et mappables. Les courbes sont enregistrées avec le set.

Éditeur : clic = ajouter un point ; glisser = déplacer ; Alt + clic = supprimer ; glisser la poignée au milieu d'un segment = courbure (double-clic = remise à zéro) ; Maj + glisser dans le vide = sélection ; Maj = sans aimantation.

## Développement

```
tests/run_all.sh        # tests Node, construction de device/, contrôles statiques
```

- `src/core.js` courbes, langage de mouvement, formules (ES5, testé contre le C++)
- `src/engine.js` modèle des 8 lignes, tick, export MIDI, session
- `src/glue.js` messages Max, Live API, fichiers
- `src/ui.js` éditeur (`jsui`)
- `tools/build_device.py` assemble `device/` et génère le patch ; `tools/check_device.py` le contrôle
- `tools/golden_gen.cpp` regénère `tests/golden.json` à partir des sources de Curve Mini

Le JS est en ES5 : c'est le seul JavaScript que lit le `[js]` de Max.
