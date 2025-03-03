### Postgres database CLI access

#### The `psql` command line
+ `psql -l` list existing databases
+ `psql -d database_name` connect to the named database. Now the prompt changes 
  and you see `database_name=#`. Lets enter commands :
  + `database_name=# SELECT * from tableA;` -> tableA content
  + `database_name=# REINDEX DATABASE "database_name";` take care of needed `"` quote marks !
  + `database_name=# ALTER DATABASE "database_name" REFRESH COLLATION VERSION;`
  + `database_name=# \l;` -> liste all databases.
  + `database_name=# \dt;` -> liste all tables.
  + `database_name=# \c database_name;` -> change connected database.
  + `database_name=# exit;` -> back to bash shell.
+ `psql -d database_name -c command` : execute command and exit. Equivalent of 
  preceeding commands :
  + `psql -d database_name -c 'SELECT * FROM tableA;'`
  + `psql -d database_name -c 'REINDEX DATABASE "database_name";'`
  + `psql -d database_name -c 'SELECT * FROM "database_name";'`

#### Other command line
Priliminary : `sudo chown postgres:postgres /var/lib/postgres`

+ Create a user with abilities :
  ```
  sudo -iu postgres
  createuser --interactive user_name
  superuser?y; create-db-abilily?y; create-user?n
  ```
+ Create standard user
  + `createuser john` if actual user has create-user ability
  + `sudo -iu postgres psql -c 'createuser john'` if not
+ Drop user
  + `dropuser john` if actual user has create-user ability
  + `sudo -u postgres psql -c 'drop user john;'` if not
+ Create db
  + `createdb -O mazu jobtickets (create database owned by mazu)
  + `sudo -iu postgres psql -c 'create database jobtickets'
