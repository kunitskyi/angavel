#!/bin/sh

FIRST_ARG="$1"

if [ "$FIRST_ARG" = "change-group/owner" ]
then
    chgrp www-data /var/www/dist/*/
    chown -R www-data:www-data /var/www/dist/*/
fi
