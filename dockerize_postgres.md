### How to dockerize postgresql database server

#### Why
Because on a rolling release, postgresql updates happen regularly and could break database access.

Remark : no updates issues with ruby because of `rbenv` usage..

#### Before all stop any postgres server
```
systemctl stop postgres
systemctl disable postgres
```

#### Docker package
```
yay -S docker docker-compose
```

#### Docker deamon
```
systemctl start docker
```

#### Import postgres image
```
sudo docker pull postgres:16-alpine3.20
```
Now `docker images` list contains postgres:16-alpine3.20

Now `docker rmi postgres:16-alpine3.20` removes postgres:16-alpine3.20 image.

#### Start container "manually"
```
sudo docker run --name my-postgres -e POSTGRES_PASSWORD=xxxx -d -p 5432:5432 postgres:16-alpine3.20
```
Now `docker container ls` list contains my-postgres

```
sudo docker exec -it my-postgres bash # enter the container
su - postgres # change user
psql -l # interact with database
createuser ...
createdb ...
exit # from 'user' postgres
exit # from container
```

`sudo docker stop my-postgres`

`sudo docker container rm my-postgres`

#### Start container with docker-compose
First, write `docker-compose.yml` and `init.sql` files in the app root 
directory :
```
# init.sql (will be executed at container creation)
-- Only used for development where Postgres is run in Docker
create role my_app with CREATEDB SUPERUSER login password 'my_pwd';

# docker-compose.yml
services:
  database:
    image: postgres:16-alpine3.20
    volumes:
      # Named volume to persist database data outside of container.
      # Format is "named_volume:path/in/container"
      - db_pg_data:/var/lib/postgresql/data
      # Host mount for one-time initialization.
      # Format is "./path/on/host:/path/in/container"
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      # Map to something other than default 5432 on host in case Postgres
      # is also running natively on host.
      # Format is "host:container"
      - "5432:5432"
    environment:
      # Sets the superuser password for PostgreSQL
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
volumes:
  db_pg_data:
```

Add a `.env` file containing 
`POSTGRES_PASSWORD=the-container-postgres-password`; this will be automatically 
readed at container creation.

Run the container : `sudo docker-compose up -d` (`-d` flag for a silent run).

Now, your app (rails or hanami) will access container via :
```
postgres://my_app:my_pwd@0.0.0.0/my_app
```

#### Other commands
```
docker container ls
docker container rm my-container
docker volume ls
docker volume rm my-volume
docker image ls
docker image rm my-image
docker ps -a
docker-compose stop
```
