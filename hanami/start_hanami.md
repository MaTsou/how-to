### Start a fresh new Hanami app

#### Initialization
```
hanami new blog
cd blog
```

#### Set env vars
```
# .env.development
DATABASE_URL=postgres://blog@localhost/blog
SESSION_SECRET=Mylong_secret_string_which_has_to_be_more_than_64_char_long_and_l
```

#### Set ROM-DB

#### Initialize Hotwired Turbo and Stimulus

#### Allow actions to external cloud (currently infomaniak openstack)
1. Set your container :
  + to provide Access-Control-Cross-Origin headers
    ```
    # Here is the `curl` syntax :
    curl -S -H "X-Auth-Token: ${OS_AUTH_TOKEN}"
    -H "X-Container-Meta-Access-Control-Expose-Headers: Access-Control-Allow-Origin"
    -X POST ${OS_STORAGE_URL}/your-container
    ```
  + to accept your app domain
    ```
    # Here is the `curl` syntax :
    curl -S -H "X-Auth-Token: ${OS_AUTH_TOKEN}"
    -H "X-Container-Meta-Access-Control-Allow-Origin: http://localhost:2300"
    -X POST ${OS_STORAGE_URL}/your-container
    ```
1. Set Hanami `content-security-policy` to allow browser to fetch to your 
   storage :
   ```
   # config/app.rb
   module MyApp
     class App < Hanami::App
       config.actions.content_security_policy[:connect_src] +=
         " https://s3.pub1.infomaniak.cloud/object/v1/AUTH_#{settings.os_project_id}/"
     end
   end
   ```
Now, javascript fetch to your storage urls are allowed..
