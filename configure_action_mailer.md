<style>
pre {
  margin: 0pt!important;
  padding: 12px!important;
}

.markdown-content * {
  //margin-bottom: .5ex!important;
}

h3, h4 {
  margin-bottom: 0pt!important;
}
</style>

### Août 2024 -- Configure ActionMailer

ActionMailer est utilisé par défaut par Rodauth, donc est un élément essentiel 
de toute application.

La configuration est très simple. Il suffit de rajouter les lignes suivantes 
dans `config/environments/production.rb`
```
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: ENV['APP_DOMAIN'] }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    port: '465',
    domain: 'logicore.fr',
    address: ENV['MAIL_SMTP_PROVIDER'],
    user_name: ENV['MAIL_ACCOUNT_USER_NAME'],
    password: ENV['MAIL_ACCOUNT_PWD'],
    authentication: :plain,
    enable_starttls_auto: true,
    ssl: true,
    tls: true
  }
```
J'utilise des variables d'environnement, impérative pour le mot de passe, mais 
utile pour une mise à jour sans redéploiement. Actuellement, elles contiennent 
:
```
APP_DOMAIN=budgetapp-testingzone.logicore.fr# root url du projet (sert à la génération de liens)
MAIL_SMTP_PROVIDER=mail.infomaniak.com# server smtp
MAIL_ACCOUNT_USER_NAME=contact@logicore.fr
MAIL_ACCOUNT_PWD=...
```

**Note** : avec `rodauth-rails` il faut également ajouter dans 
`app/misc/rodauth_main.rb` :
```
email_from 'contact@logicore.fr`
```
