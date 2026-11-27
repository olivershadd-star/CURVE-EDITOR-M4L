# Curve Editor M4L (ANKS Labs)

Portage complet de Curve Mini (VST3) en module Max for Live (effet MIDI) pour Ableton Live 12.

- 8 lignes de courbes, un onglet par ligne, chacune envoie un CC MIDI (canal et CC reglables).
- Le module dans Live est un bandeau compact (8 interrupteurs, bouton "Ouvrir l'editeur").
- L'editeur s'ouvre dans une fenetre, 3 pages : Courbe, Destination, Decrire / Code (volet texte et dictionnaire de mouvements).
- Export / import de session (JSON), export de la courbe en fichier MIDI.
- Abandonnes (sans sens dans Live) : choix du port MIDI, Connecter, ENVOI, Assigner, transport autonome, Placer a gauche.

## ⬇ TÉLÉCHARGER ET INSTALLER — DOWNLOAD

[![TÉLÉCHARGER LA DERNIÈRE VERSION](https://img.shields.io/github/v/release/olivershadd-star/CURVE-EDITOR-M4L?include_prereleases&sort=date&display_name=tag&style=for-the-badge&logo=github&logoColor=F7FAFF&label=T%C3%89L%C3%89CHARGER&labelColor=10151E&color=EF343E)](../../releases/latest) [![TOUTES LES VERSIONS](https://img.shields.io/badge/TOUTES_LES-VERSIONS-F5C343?style=for-the-badge&labelColor=10151E)](../../releases)

1. Clique sur **TÉLÉCHARGER**, puis, dans la rubrique *Assets*, télécharge `CurveEditor-M4L-X.Y.Z.zip` (X.Y.Z = numéro de version : prends toujours le plus grand).
2. Clic droit sur le ZIP → **Extraire tout**.
3. Garde ensemble dans un même dossier `CurveEditor.amxd`, `curve_engine.js` et `curve_ui.js` (par exemple dans `Documents\Max 9\Library\`).
4. Dans Live (Suite, ou Standard + Max for Live), glisse `CurveEditor.amxd` sur une piste MIDI.

**EN —** Click **DOWNLOAD**, get `CurveEditor-M4L-X.Y.Z.zip` from *Assets*, extract it, keep the three files together and drop `CurveEditor.amxd` on a MIDI track.

---

## Installation
Garder ensemble dans un meme dossier : `CurveEditor.amxd` (ou `.maxpat`), `curve_engine.js`, `curve_ui.js`.
Glisser le `.amxd` sur une piste MIDI. Si Live refuse le `.amxd` : ouvrir un "Max MIDI Effect" vide, coller le contenu de `CurveEditor.maxpat`, sauver a cote des deux `.js`.

## Developpement
Numero de version : fichier `VERSION`. Quand il change, GitHub publie tout seul `CurveEditor-M4L-X.Y.Z.zip` dans Releases.
`bash tests/run_all.sh` : golden C++ (81), moteur, fenetre, colle Max, build, controle statique.
Source : `src/` (core, engine, glue, ui) ; build : `tools/build_device.py` -> `device/`.

## Non verifie dans Max / Live
Voir `FEUILLE_TEST_LIVE_FR.md`.
