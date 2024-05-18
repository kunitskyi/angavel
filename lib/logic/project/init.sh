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
    if [ $ENV_FLAG_RUN_SRP = 1 ]
    then
        @stop
        @wip
        
        local DIR_PATH="./panel/srp/nginx/sites"
        rm -rf ./panel/srp/nginx/sites-enabled/dracody-spa.conf
        rm -rf ./panel/srp/nginx/sites-enabled/dracody-api.conf
        mkdir -p ./panel/srp/nginx/conf.d_holder/
        mv ./panel/srp/nginx/conf.d/default-ssl.conf ./panel/srp/nginx/conf.d_holder/default-ssl.conf
        rm -rf ./.magic/$CURR_ENV/rocket/oxygen/certbot/conf/
        mkdir -p ./.magic/$CURR_ENV/rocket/oxygen/certbot/conf/
        openssl dhparam -out ./.magic/$CURR_ENV/rocket/oxygen/certbot/conf/ssl-dhparams.pem 4096
        add_ssl_cert_logic "dracody.com"
        add_ssl_cert_logic "api.dracody.com"
        add_ssl_cert_logic "www.dracody.com"
        cp ./panel/srp/nginx/sites-available/dracody-spa.conf ./panel/srp/nginx/sites-enabled/dracody-spa.conf
        cp ./panel/srp/nginx/sites-available/dracody-api.conf ./panel/srp/nginx/sites-enabled/dracody-api.conf
        mv ./panel/srp/nginx/conf.d_holder/default-ssl.conf ./panel/srp/nginx/conf.d/default-ssl.conf
        rm -rf ./panel/srp/nginx/conf.d_holder/
        control_container_logic srp restart
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