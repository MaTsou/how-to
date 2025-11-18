### Rebuild db
When I switch from a system wide postgres installation to a dockerized one, I 
need to re-create the db inside the container.

Since many migrations have to be made, and some of them used model class, I ran 
into issues trying `rails db:migrate`. This is because some model were not in 
the state they were when migration was performed..

But there is a better way : use schema to build a empty db with the last structure :
```
rails db:schema:load
```
and enjoy !
