<div align="center">

# ANKS LABS / CURVE EDITOR M4L
### MAX FOR LIVE · EFFET MIDI · ABLETON LIVE 12

![Status](https://img.shields.io/badge/STATUS-PROTOTYPE_NON_TESTE_DANS_LIVE-EF343E?style=for-the-badge&labelColor=10151E)
![ANKS Labs](https://img.shields.io/badge/ANKS_LABS-AUDIO_DEVELOPMENT-19B9FF?style=for-the-badge&labelColor=10151E)

**BUILD. BREAK. REWIRE. LISTEN.**

</div>

---

## CE QUE C'EST

**Curve Editor M4L** est la version **Max for Live** de Curve Mini : un vrai **effet MIDI Ableton**. Il se pose avant l'instrument, laisse passer les notes (par exemple celles de MLG) et y ajoute des CC dessinés à la souris, en boucle sur 1 à 16 mesures, synchronisés sur le tempo de Live.

Pourquoi Max for Live : un VST3 ne peut pas être un effet MIDI dans Live. Curve Mini (VST3) doit donc vivre sur sa propre piste et passer par loopMIDI. Ici, l'appareil se place dans la chaîne de la piste de l'instrument, sans routage.

## ÉTAT

**Prototype à 2 lignes. Non testé dans Live** : le moteur est vérifié par des tests automatiques avec un faux Live, la structure du patch est contrôlée, mais l'appareil n'a jamais été ouvert dans Max ni dans Live. Voir [`FEUILLE_TEST_LIVE_FR.md`](FEUILLE_TEST_LIVE_FR.md).

| | Prototype |
|---|---|
| Lignes | 2 (CC 20 et 21 par défaut) |
| Courbe | 16 points dessinés à la souris, lecture en boucle avec interpolation |
| Réglages par ligne | on/off, CC, canal, durée en mesures (1 à 16), min, max |
| Notes | passent sans modification (`midiin` vers `midiout`) |
| Synchro | position de Live (`current_song_time`), signature de mesure lue dans Live |

**Pas encore fait** (repris de Curve Mini) : 8 lignes, décalage, lissage, formes et tension des points, sauvegarde du dessin avec le set Live, export MIDI.

## FICHIERS

- `device/CurveEditor-proto.maxpat` : le patch, à coller dans un Max MIDI Effect vide (chemin sûr)
- `device/CurveEditor-proto.amxd` : l'appareil généré par script, probablement refusé par Live (en-tête avec somme de contrôle)
- `device/curve_lanes.js` : le moteur, **à garder dans le même dossier que l'appareil**
- `tools/build_device.py` : régénère l'appareil
- `tests/` : tests du moteur (Node) et contrôle du patch (Python)

```
node tests/test_curve_lanes.js
python3 -I tests/check_device.py
```

---

*ANKS Labs, indépendant, expérimental.*
