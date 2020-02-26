FROM python:3.8.0-slim-buster AS build
LABEL respirar.version="0.0.1-beta"
ARG workdir
RUN echo "WORKDIR is $workdir"
WORKDIR ${workdir}

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
  # libpq-dev for pg_config error message 
RUN apt-get update && apt-get -yq install \
  libpq-dev \ 
  gcc \
  python3-pip \
  python3-dev



#install dependencies
RUN pip install --upgrade pip
COPY ./requirements/base.txt ${workdir}/requirements/base.txt
RUN pip3 install -r requirements/base.txt

#copy project
COPY . ${workdir}

# run entrypoint.sh
ENTRYPOINT ["./dev/entrypoint.sh"]