#!/bin/bash

##
#
# SRP Manager
#
#######

function angavel:manager:site {

    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/SRP/docker.yml"

    docker compose \
        --env-file $GLOBAL_COMPOSE_ENV_PATH -f $COMPOSE_PATH \
        run --rm \
        "srp_webserver" \
        /nginx-cmd-smn.sh
}
