# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Run with docker
Build container
```
docker build -t bigsea/thorn .
```
Run thorn with docker

```
# Initiate mysql database
docker run --rm \
  -e MYSQL_ROOT_PASSWORD="" \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  -v /var/run/mysqld/ \
  --name thorn_mysql mariadb

# Setup database
docker run --rm \
  --volumes-from thorn_mysql \
  bigsea/thorn rake db:setup

# Run rails
docker run --rm \
  -e RAILS_CORS_ORIGINS=localhost:8080 \
  -p 3000:3000 \
  --volumes-from thorn_mysql \
  bigsea/thorn
```
