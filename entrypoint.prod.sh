#!/bin/sh
echo "python manage.py migrate"
python manage.py migrate 
echo "python manage.py collecstatic --no-input"
python manage.py collectstatic --no-input
echo "app running production mode" 

exec "$@"
