### Juin 2022 -- Bulma css styling

#### C'était pourtant simple
_ Toutes les infos sur Rails-guide : Assets Pipeline ! _

Installer<sup>[1]</sup> `sassc-rails` et le compilateur `sassc`
```
yay -S sassc ; bundle add sassc-rails
```

Télécharger et extraire dans `app/assets/stylesheets` la dernière version de 
Bulma.

#### Lien avec l'application
Il suffit de saisir les lignes d'importation dans 
`stylesheets/application.css.scss` (renommage de `application.css` :

```
*= require_self // require c'est seulement pour les .css
@import "myfolder/mycssfile1"
@import "myfolder/mycssfile2"
@import "myotherfolder/mycssfile1"
@import "bulma/bulma"
```
`require_self` importe le contenu de `application.css` et `require_tree` 
importe récursivement le contenu du dossier (je supprime cette dernière ligne 
!)

Ajouter `//=link application.css` dans `app/assets/config/manifest.js`.

#### Personaliser Bulma
Il suffit de suivre les instructions du site officiel Bulma.

Les modifications peuvent se faire dans `bulma/bulma.sass` ou une copie, au 
choix (c'est le fichier sur lequel pointe `@import`).

Toute modification est automatiquement compilée dès la réactiualisation de la 
page. Pas de nécessité de relancer le serveur.

<hr>
[1] : _`bulma-rails` paraît sans intérêt._
