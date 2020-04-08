#!/bin/sh
echo "python manage.py migrate --no-input"

python manage.py migrate --no-input

exec "$@"