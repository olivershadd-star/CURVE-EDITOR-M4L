# Curve Editor M4L (ANKS Labs)

Portage complet de Curve Mini (VST3) en module Max for Live (effet MIDI) pour Ableton Live 12.

- 8 lignes de courbes, un onglet par ligne, chacune envoie un CC MIDI (canal et CC reglables).
- Le module dans Live est un bandeau compact (8 interrupteurs, bouton "Ouvrir l'editeur").
- L'editeur s'ouvre dans une fenetre, 3 pages : Courbe, Destination, Decrire / Code (volet texte et dictionnaire de mouvements).
- Export / import de session (JSON), export de la courbe en fichier MIDI.
- Abandonnes (sans sens dans Live) : choix du port MIDI, Connecter, ENVOI, Assigner, transport autonome, Placer a gauche.

## Installation
Garder ensemble dans un meme dossier : `CurveEditor.amxd` (ou `.maxpat`), `curve_engine.js`, `curve_ui.js`.
Glisser le `.amxd` sur une piste MIDI. Si Live refuse le `.amxd` : ouvrir un "Max MIDI Effect" vide, coller le contenu de `CurveEditor.maxpat`, sauver a cote des deux `.js`.

## Developpement
`bash tests/run_all.sh` : golden C++ (81), moteur, fenetre, colle Max, build, controle statique.
Source : `src/` (core, engine, glue, ui) ; build : `tools/build_device.py` -> `device/`.

## Non verifie dans Max / Live
Voir `FEUILLE_TEST_LIVE_FR.md`.
