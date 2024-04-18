### mars 2024
### Mise en place d'une solution `chargebee-hosted-pages` dans une application rails

1. créer un compte sandbox chez braintreegateway.

   Surtout, ne pas essayer de dire qu'on est en France. Remplir les champs avec 
   des données par défaut. Notamment :
   + tel : (201)555-0123
   + routing number : 011000015
   + account number : 1000 000 000 (sans les espaces)
   (cependant, même si la création du compte réussit, le lien avec chargebee n'a 
   pas fonctionné; je ne sais pas pourquoi.)
1. créer un compte sandbox chez chargebee.
  + opter pour `hosted pages`, c'est un petit lien javascript à insérer
  + créer les plans de souscription
  + attention, les emails qui fonctionnent en mode sandbox ne sont que ceux qui 
   sont liés au domaine `@logicore.fr`. J'ai  utilisé 
   `contact+test@logicore.fr` et la souscription apparaît bien sur le dashboard 
   de chargebee (même si je teste en localhost).
  + ajouter des payment gateways : ici braintree..

1. À la création de chargebee sandbox account, un contenu de balise `<script>` 
   est fourni (à mettre dans `<head>`).
1. À la création de chaque plan de souscription, un lien est fourni. L'insérer 
   dans la page de mon application qui gère les souscriptions : je pense que 
   cette page est celle vers laquelle un sign-up réussit doit renvoyer. Elle 
   affiche les différents subscription plan avec un design maison et contient 
   les liens chargebee associés.
1. le webhook de souscription réussit doit rediriger vers home.
1. Enfin, dans la page paramètres, le lien de update subscription doit 
   apparaître.
