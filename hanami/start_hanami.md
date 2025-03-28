### Start a fresh new Hanami app

#### Initialization
```
hanami new blog
cd blog
```

#### Set env vars
First, remove in `.env` the `DATABASE_URL` line.

```
# .env (because of test db creation with _test suffix to db name..)
DATABASE_URL=postgres://blog@localhost/blog

# .env.development AND .env.test OR .env
SESSION_SECRET=Mylong_secret_string_which_has_to_be_more_than_64_char_long_and_l
```

Define a `setting` for each...

#### Set ROM-DB
First, add `pg` gem to Gemfile.

Bad way (super-user is not recommended) :
1. Use .env file to store env vars :
  `DATABASE_URL=postgres://mazu@localhost/jobtickets`
1. Create database `hanami db create` will create db with owner mazu..

Good way :
--- DEPRECATED --- (see dockerize postgresql file !!)
1. create app specific user (with same name as app) :
  `createuser --interactive jobtickets` (not a super-user but create db 
  capability)
1. Use .env.development file to store env vars :
  `DATABASE_URL=postgres://jobtickets@localhost/jobtickets`
1. Create database `hanami db create`
1. Load `citext` extension (for CaseInsensitiveTEXT : login or email ..)
  `psql -c "CREATE EXTENSION citext" jobtickets`
1. Set migrations `hanami generate migration blabla`; `hanami db migrate`
--- DEPRECATED ---

In production, use a real env var..

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

#### integration test with Minitest
Seems that this is mandatory :
```
# frozen_string_literals: true
describe "Root" do
  include Rack::Test::Methods # here is the tip

  def app
    Hanami.app
  end

  it "is found" do
    get "/"
    _( last_response.status ).must_equal 200
  end
end
```
