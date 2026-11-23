# Feuille de test dans Live

Tout est teste en Node (logique, souris, messages). Rien n'a pu etre lance dans Max/Live ici : c'est a toi de confirmer.

## Installer
1. Dossier avec `CurveEditor.amxd`, `curve_engine.js`, `curve_ui.js`.
2. Glisser sur une piste MIDI. Ouvrir la console Max (clic droit sur le titre du module > Open) et noter toute ligne rouge.

## A tester
1. "Ouvrir l'editeur" : la fenetre s'ouvre (8 onglets, 3 pages).
2. Dessin libre : trait continu, pas en escalier. Mode Points : ajouter, deplacer, courber.
3. Boutons : Copier, Coller, Annuler, Verrouiller, Inverser, Varier, Lisser, menu Forme.
4. Page Destination : canal, CC, valeur manuelle, Reprendre, renommer, export MIDI.
5. Page Decrire / Code : taper un texte, Previsualiser, Appliquer ; mode Code idem.
6. Lecture : les CC sortent (verifier avec un Serum / un moniteur MIDI).
7. Sauver le set, rouvrir : l'etat revient. Export / import de session.

## Serum, MIDI Learn
Serum apprend le premier CC recu : n'allumer qu'une seule ligne pendant l'apprentissage.

## Points les plus risques (a me rapporter en priorite)
- `---` dans le sous-patch, `pcontrol open`, sortie des champs texte (`bang`), `hidden` sur textedit
- jsui dans la fenetre flottante, sauvegarde de l'etat (dict), chemins des boites de dialogue
- en-tete `.amxd` (sinon coller le `.maxpat`)
- mise a jour des valeurs live.* par `set`

Rapporter : lignes rouges de la console + capture d'ecran.
