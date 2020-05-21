# Django base app with docker

Django base app build with python 3.8, uWSGI, nginx, postgres, docker and docker-compose.

In this project I use [multi stages](https://docs.docker.com/develop/develop-images/multistage-build/) to optimize Dockerfile and I use [multiple Compose files](https://docs.docker.com/compose/extends/#multiple-compose-files)

## Requirements 

Before to run the project you need to install [Docker](https://docs.docker.com/engine/install/ubuntu/) and [Docker-Compose](https://docs.docker.com/compose/install/)

## Usage Docker compose for development environment

Build docker-compose

```bash
docker-compose build
```

Start docker-compose

```bash
docker-compose up
```

## Usage Docker compose for production environment

Build docker-compose 

```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml build
```

Start docker-compose

```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

## Add environment variable

```
# app
DEBUG=False
SECRET_KEY=SECRET_KEY_PROD
DATABASE_URL=postgres://production:production123@db:5432/database_prod
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]
DJANGO_SETTINGS_MODULE=respirar.settings
STATIC_URL=/static/
MEDIA_URL=/media/

```

```
#db
POSTGRES_USER=production
POSTGRES_PASSWORD=production123
POSTGRES_DB=database_prod
POSTGRES_PORT=5432

```
