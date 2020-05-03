####### begin base image #######
FROM python:3.8.0-slim-buster AS base
LABEL respirar.version="1.0.0-beta"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
####### end base image #######


####### begin image builder #######
FROM base as dev
WORKDIR /usr/src/app/
# install psycopg2 dependencies
  # libpq-dev for pg_config error message
  # libpq allow client programs to pass queries to the PostgreSQL
  # musl-dev.- musl is a C standard library implementation for Linux
RUN apt-get update && apt-get -yq install \
  gcc \
  libpq-dev \
  python3-dev \
  musl-dev \
  python3-pip

#install dependencies
RUN pip3 install --upgrade pip
RUN pip3 install flake8
COPY ./requirements/base.txt ./requirements/base.txt
RUN flake8 --ignore=E501,F401 .
COPY . /usr/src/app/
RUN pip3 install -r ./requirements/base.txt
RUN pip3 wheel --progress-bar emoji --no-cache-dir --no-deps --wheel-dir ./wheels -r requirements/base.txt
COPY ./entrypoint.dev.sh .

# run entrypoint.sh
ENTRYPOINT ["./entrypoint.dev.sh"]
CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000" ]
###### end builder ######

####### begin image prod ######
# pull official base image
FROM base as prod

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup --system app && adduser --system app --ingroup app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=$HOME/respirar
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/mediafiles
WORKDIR $APP_HOME


# install dependencies
RUN apt-get update && apt-get install libpq-dev -yq
COPY --from=dev /usr/src/app/wheels /wheels
COPY --from=dev /usr/src/app/requirements/ ./requirements
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache /wheels/*

# copy entrypoint-prod.sh
COPY ./entrypoint.prod.sh $APP_HOME

# copy project

COPY . $APP_HOME
# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

# run entrypoint.prod.sh
ENTRYPOINT ["/home/app/respirar/entrypoint.prod.sh"]
CMD [ "gunicorn", "respirar.wsgi:application", "--bind", "0.0.0.0:8000" ]

####### end image prod ######

# nginx has one master process and several worker processes. The main purpose of the master process is to read and evaluate configuration, and maintain worker processes. Worker processes do actual processing of requests