# Test du prototype Curve Editor M4L dans Live 12

Ce prototype n'a jamais été ouvert dans Max. Cette feuille sert à voir ce qui marche et à me dire précisément ce qui ne marche pas.

## Installation

1. Télécharge `device/CurveEditor-proto.amxd` **et** `device/curve_lanes.js` depuis ce dépôt.
2. Mets les deux **dans le même dossier**, par exemple :
   `Documents\Ableton\User Library\Presets\MIDI Effects\Max MIDI Effect\CurveEditor\`
3. Dans Live, ouvre le navigateur : User Library, Presets, MIDI Effects, Max MIDI Effect, CurveEditor.
4. Glisse `CurveEditor-proto` sur la piste de ton instrument (Serum), **avant** l'instrument.

**Si l'appareil ne s'ouvre pas (message d'erreur, appareil vide)** : le fichier `.amxd` est fabriqué à la main et Live peut le refuser. Plan B :
1. Glisse un « Max MIDI Effect » vide sur la piste, clique sur le bouton d'édition.
2. Dans Max, ouvre `CurveEditor-proto.maxpat`, sélectionne tout (Ctrl+A), copie, et colle dans la fenêtre de l'appareil vide.
3. Enregistre l'appareil dans le même dossier que `curve_lanes.js`.

## Test

1. **L'appareil s'affiche** : deux lignes avec on/off, CC, Canal, Mes., Min, Max et une courbe à dessiner.
2. **Les notes passent** : fais jouer MLG (ou une note à la main) sur la piste. Serum doit sonner comme sans l'appareil.
3. **Pas de message d'erreur** dans la fenêtre Max (si tu l'ouvres, le bouton d'édition puis la console) : s'il y en a, copie-les-moi.
4. **Les CC partent** : lance la lecture de Live. Dans Serum, clique droit sur un macro, MIDI Learn, et la ligne 1 doit s'y assigner (CC 20, canal 1). Assigne la ligne 2 (CC 21) à un autre macro.
5. **La courbe bouge le macro** : le macro doit suivre le dessin en boucle.
6. **Dessine à la souris** dans l'éditeur : le mouvement du macro doit changer.
7. **Durée** : mets 2 mesures ou 4 : la boucle doit ralentir.
8. **Min / Max** : réduis l'étendue, le macro doit bouger moins.
9. **Tempo** : change le tempo de Live, la boucle suit.
10. **Arrêt** : arrête Live, plus aucun CC.

## À me dire

- Quelles étapes ont marché, lesquelles non.
- Les messages de la console Max, tels quels.
- Si le mouvement est saccadé, à quelle vitesse (7 bits seulement, 128 pas, comme Curve Mini).
