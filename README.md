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

