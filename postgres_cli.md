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
