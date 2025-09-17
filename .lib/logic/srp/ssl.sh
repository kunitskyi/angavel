#!/bin/bash

##
#
# SSL
#
#######

function angavel:srp:ssl:_create-new {

    local DOMAIN_NAME=$1
    local FLAG_START_CERTBOT=$2
    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/SRP/docker.yml"

    if [ "$DOMAIN_NAME" != "" ]; then

        docker compose \
            --env-file $GLOBAL_COMPOSE_ENV_PATH -f $COMPOSE_PATH \
            stop \
            "srp_certbot"

        @comment-strings-where 1 "command:" "${COMPOSE_PATH}"
        @comment-strings-where 1 "entrypoint:" "${COMPOSE_PATH}"

        docker compose \
            --env-file $GLOBAL_COMPOSE_ENV_PATH -f $COMPOSE_PATH \
            run --rm \
            "srp_certbot" \
            certonly --webroot --webroot-path /var/www/certbot/ -d $DOMAIN_NAME

        @comment-strings-where 0 "command:" "${COMPOSE_PATH}"
        @comment-strings-where 0 "entrypoint:" "${COMPOSE_PATH}"

        if [[ $FLAG_START_CERTBOT = 1 ]]; then
            docker compose \
                --env-file $GLOBAL_COMPOSE_ENV_PATH -f $COMPOSE_PATH \
                up -d \
                "srp_certbot"
        fi

    else
        @throw-error 21 "Value not set!"
    fi

}
