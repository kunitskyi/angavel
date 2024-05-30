#!/bin/bash

##
#
# Project Init
#
#######

function angavel:project:init {

    angavel:project:init:_srp
    angavel:project:init:_spa
    angavel:project:init:_api

}

function angavel:project:init:_srp {

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

        angavel:project:_start "SRP"
        ws:docker:compose:send-cmd \
            "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
            "srp_webserver" "chmod +x /nginx-cmd-smn.sh"

        for DOMAIN in "${ARRAY_OF_DOMAINS[@]}"; do
            angavel:ssl:create-new "${DOMAIN}"
        done

        for CONFIG in "${ARRAY_OF_CONFIGS[@]}"; do
            ws:docker:compose:send-cmd \
                "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
                "srp_webserver" "/nginx-cmd-smn.sh ENABLE ${CONFIG}"
        done

    fi
}

function angavel:project:init:_api {

    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/API/docker.yml"

    git clone \
        -b "${ENV_API_GIT_BRANCH}" \
        "${ENV_API_GIT_URL}" \
        "${GLOBAL_DATA_PWD}/API"

    angavel:project:_start "API"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "api_cgi" "chmod +x /cgi-cmd.sh"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "api_cgi" "/cgi-cmd.sh change-group/owner"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "api_cgi" "/cgi-cmd.sh composer-install"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "api_cgi" "/cgi-cmd.sh artisan-key-gen"
    angavel:project:_stop "API"

}

function angavel:project:init:_spa {

    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/SPA/docker.yml"

    git clone \
        -b "${ENV_SPA_GIT_BRANCH}" \
        "${ENV_SPA_GIT_URL}" \
        "${GLOBAL_DATA_PWD}/SPA"

    @comment-strings-where 1 "command:" "${COMPOSE_PATH}"
    angavel:project:_start "SPA"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "spa_angular" "chmod +x /node-cmd.sh"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "spa_angular" "/node-cmd.sh fresh-install/build"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "spa_webserver" "chmod +x /nginx-cmd.sh"
    ws:docker:compose:send-cmd \
        "${GLOBAL_COMPOSE_ENV_PATH}" "${COMPOSE_PATH}" \
        "spa_webserver" "/nginx-cmd.sh change-group/owner"
    angavel:project:_stop "SPA"
    @comment-strings-where 0 "command:" "${COMPOSE_PATH}"

}
