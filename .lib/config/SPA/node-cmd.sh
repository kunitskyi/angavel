#!/bin/sh

FIRST_ARG="$1"

if [ "$FIRST_ARG" = "fresh-install/build" ]; then
    npm --prefix /var/www/angular/ install
    ng build --configuration $BUILD_ENV
fi
