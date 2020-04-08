#!/bin/sh
echo "python manage.py migrate"
python manage.py migrate 
echo "python manage.py collecstatic --no-input"
python manage.py collecstatic --no-input
echo "app running production mode" 

exec "$@"
