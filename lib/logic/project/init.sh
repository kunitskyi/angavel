#!/bin/bash

##
#
# Project Init
#
#######

function  angavel:project:init {
    
    angavel:project:init:_srp
    angavel:project:init:_spa
    angavel:project:init:_api
    
}

function  angavel:project:init:_srp {

    local ARRAY_OF_DOMAINS=()

    IFS="," read -r -a ARRAY_OF_DOMAINS <<< "${ENV_SRP_DOMAINS_LIST}"

    if [ $ENV_FLAG_RUN_SRP = 1 ]
    then
        
        mkdir -p "${GLOBAL_CACHE_PWD}/SRP/nginx/conf.d_temp/"
        mv \
        "${GLOBAL_MODULE_PWD}/config/SRP/nginx/conf.d/default-ssl.conf" \
        "${GLOBAL_MODULE_PWD}/config/SRP/nginx/conf.d_temp/default-ssl.conf"
        
        mkdir -p $GLOBAL_CACHE_PWD/SRP/certbot/conf/
        
        openssl dhparam -out $GLOBAL_CACHE_PWD/SRP/certbot/conf/ssl-dhparams.pem 4096
        
        for DOMAIN in "${ARRAY_OF_DOMAINS[@]}"
        do
            angavel:ssl:create-new "${DOMAIN}"
        done

        cp \
        $GLOBAL_ENV_PWD/sites-available/* \
        $GLOBAL_CACHE_PWD/SRP/nginx/sites-enabled/

        mv \
        "${GLOBAL_MODULE_PWD}/config/SRP/nginx/conf.d_temp/default-ssl.conf" \
        "${GLOBAL_MODULE_PWD}/config/SRP/nginx/conf.d/default-ssl.conf"
        
        rm -rf "${GLOBAL_CACHE_PWD}/SRP/nginx/conf.d_temp/"
        
    fi
}

function  angavel:project:init:_api {
    
    local COMPOSE_PATH="${GLOBAL_COMPOSE_PWD}/API/docker.yml"
    
    git clone \
    -b "${ENV_API_GIT_BRANCH}" \
    "${ENV_API_GIT_URL}" \
    "${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}/API"
    
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

function  angavel:project:init:_spa {
    
    local COMPOSE_PATH="${GLOBAL_COMPOSE_PWD}/SPA/docker.yml"
    
    git clone \
    -b "${ENV_SPA_GIT_BRANCH}" \
    "${ENV_SPA_GIT_URL}" \
    "${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}/SPA"
    
    @comment-strings-where  1 "command:" "${COMPOSE_PATH}"
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
    @comment-strings-where  0 "command:" "${COMPOSE_PATH}"
    
}