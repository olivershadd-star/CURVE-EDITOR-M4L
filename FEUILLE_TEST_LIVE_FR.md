# Feuille de test — Curve Editor M4L

Tout ce qui est calcul est testé hors de Live (courbes, CC, export MIDI, session). **Ce qui n'a jamais tourné dans Max** : le patch lui-même, l'éditeur, les dialogues et la sauvegarde avec le set. C'est ça qu'on teste ici.

## Installation

1. Garder ensemble : `device/curve_engine.js`, `device/curve_ui.js`, `device/CurveEditor.amxd` (+ `.maxpat`).
2. **Essai 1** : glisser `CurveEditor.amxd` sur une piste MIDI. Il doit s'afficher sans erreur.
3. **Essai 2** (si Live refuse le .amxd) : mettre un *Max MIDI Effect* vide sur la piste, cliquer l'icône d'édition, dans Max tout sélectionner et supprimer, ouvrir `CurveEditor.maxpat` dans un éditeur de texte, tout copier, coller dans le patch Max, puis enregistrer l'appareil **dans le même dossier que les deux `.js`**.
4. Ouvrir la console Max (fenêtre Max) : noter toute ligne rouge à l'ouverture.

## À tester, dans l'ordre

1. **Piste** : reste une piste MIDI (notes conservées), un instrument après l'appareil sonne toujours.
2. **Affichage** : tout tient dans l'appareil (169 px de haut), tableau à gauche, éditeur à droite.
3. **CC** : allumer *On* sur la ligne 1, lancer la lecture, voir les CC 20 sur canal 16 (un Monitor MIDI après l'appareil, ou mapper un paramètre).
4. **Dessin** : trait libre dans l'éditeur → le CC suit la courbe. Mode *Points* : ajouter, déplacer, Alt + clic supprimer, courbure.
5. **Le bouton de souris se relâche bien** (sinon le dessin « colle » après le clic).
6. **Menus** : Forme, Grille, Pinceau, Segment. Boutons : Copier, Coller, Annuler, Verrou, Inverser, Varier, Lisser, Étirer, Pente.
7. **Manuel** : changer la *Val.* d'une ligne → passe en MAN ; clic sur MAN → reprend la courbe.
8. **Outils…** : la fenêtre s'ouvre. Description en français → *Prévisualiser* → *Appliquer*. Code avancé idem. Renommer.
9. **Export .mid** et **export / import de session** : le chemin s'écrit-il bien (taper l'extension à la main si elle manque) ?
10. **Enregistrer le set, fermer, rouvrir** : courbes, noms et réglages sont-ils revenus ?
11. **Automation / mapping** d'un réglage du tableau dans Live.

## Points fragiles (hypothèses non vérifiées dans Max)

- le `.amxd` généré peut être refusé par Live (voie 2 alors)
- la sauvegarde des courbes dans le set passe par un `[dict]` branché sur les paramètres : si les courbes ne reviennent pas à la réouverture, dire lequel
- un clic sur un champ texte de la fenêtre Outils envoie-t-il bien le texte au moteur ?
- les chemins de fichier sur Mac (`Macintosh HD:/…`)
- les sauts de ligne du code avancé sont reconstruits (`#` commentaires perdus)

## À me rapporter

Pour chaque point qui ne marche pas : le numéro ci-dessus, ce qui s'affiche, et les **lignes rouges de la console Max**. Une capture d'écran de l'appareil aide beaucoup.
