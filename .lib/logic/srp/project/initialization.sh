#!/bin/bash

##
#
# SRP Initialization
#
#######

function angavel:srp:_initialization {

    local ARRAY_OF_DOMAINS=()
    local ARRAY_OF_CONFIGS=()

    IFS="," read -r -a ARRAY_OF_DOMAINS <<<"${ENV_SRP_DOMAINS_LIST}"
    IFS="," read -r -a ARRAY_OF_CONFIGS <<<"${ENV_SRP_CONFIGS_LIST}"

    if [ $ENV_FLAG_RUN_SRP = 1 ]; then

        # IF ssl-dhparams.pem isn't exist, then generate
        if [ ! -f "$GLOBAL_CACHE_PWD/SRP/certbot/conf/ssl-dhparams.pem" ]; then
            mkdir -p $GLOBAL_CACHE_PWD/SRP/certbot/conf/
            openssl dhparam -out $GLOBAL_CACHE_PWD/SRP/certbot/conf/ssl-dhparams.pem 4096
        fi

        angavel:general:project:control:_start "SRP"
        ws:docker:compose:send-cmd \
            "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
            "srp_webserver" "chmod +x /nginx-cmd-smn.sh"

        for DOMAIN in "${ARRAY_OF_DOMAINS[@]}"; do
            angavel:srp:ssl:_create-new "${DOMAIN}"
        done

        for CONFIG in "${ARRAY_OF_CONFIGS[@]}"; do
            ws:docker:compose:send-cmd \
                "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
                "srp_webserver" "/nginx-cmd-smn.sh ENABLE ${CONFIG}"
        done

    fi
}
