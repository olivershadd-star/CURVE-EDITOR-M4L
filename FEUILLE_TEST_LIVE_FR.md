# Test du prototype Curve Editor M4L dans Live 12

Ce prototype n'a jamais été ouvert dans Max. Cette feuille sert à voir ce qui marche et à me dire précisément ce qui ne marche pas.

## Installation (chemin principal : copier-coller du patch)

Le fichier `.amxd` est fabriqué par un script. L'en-tête d'un `.amxd` contient une somme de contrôle, et d'après les forums de Cycling '74 Live refuse les fichiers retouchés à la main : il sera donc **probablement refusé**. Tu peux l'essayer, mais le chemin sûr est celui-ci.

1. Mets `curve_lanes.js` dans un dossier à toi, par exemple
   `Documents\Ableton\User Library\Presets\MIDI Effects\Max MIDI Effect\CurveEditor\`
2. Dans Live, glisse un **Max MIDI Effect** vide (navigateur : MIDI Effects, Max MIDI Effect) sur la piste de ton instrument, **avant** l'instrument. Clique sur le bouton d'édition (Max s'ouvre).
3. Dans Max, enregistre tout de suite l'appareil sous un nom (par exemple `CurveEditor`) **dans le même dossier que `curve_lanes.js`**.
4. Ouvre `CurveEditor-proto.maxpat` dans Max (menu Fichier, Ouvrir), Ctrl+A, Ctrl+C.
5. Reviens à la fenêtre de ton appareil, supprime les deux objets du modèle (`midiin` et `midiout`), Ctrl+V, puis enregistre (Ctrl+S).
6. Passe en mode présentation (Ctrl+Alt+E) si l'interface ne s'affiche pas comme prévu.

**Essai direct du `.amxd` (facultatif)** : mets `CurveEditor-proto.amxd` et `curve_lanes.js` dans le même dossier de la User Library et glisse l'appareil sur la piste. S'il s'affiche, tant mieux ; sinon, utilise le chemin ci-dessus.

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
