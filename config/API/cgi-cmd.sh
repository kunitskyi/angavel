#!/bin/sh

FIRST_ARG="$1"

if [ "$FIRST_ARG" = "change-group/owner" ]; then
    chgrp www-data /var/www/api
    chown -R $USER:www-data /var/www/api/storage
    chmod -R 775 /var/www/api/storage
elif [ "$FIRST_ARG" = "composer-install" ]; then
    composer install
elif [ "$FIRST_ARG" = "artisan-key-gen" ]; then
    php artisan key:generate
fi
