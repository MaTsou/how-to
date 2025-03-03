### Mars 2023

#### Mettre à jour un gem
```
bundle update the_gem_name
```

met à jour conformément aux limites de version définies dans `Gemfile`.

Ne pas hésiter à bien tester et à user de `git reset --hard` en cas de crash.

#### Mettre à jour rails ou ruby
Même procédure mais il est vivement conseillé d'y aller progressivement :
Les noms de version sont du type `n.m.l`
1. aller au `l` le plus grand. Tester. Corriger.
2. passer au `m` (avec le `l` max) suivant. Tester. Corriger.
3. etc.

La  raison est que les `l` sont des corrections de bugs essentiellement. 
Prendre le dernier, c'est disposer de la meilleure version. Corriger le code 
avec cette version assure que le passage à la version supérieure a des chances 
de bien se passer.
