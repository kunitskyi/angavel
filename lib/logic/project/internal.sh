#!/bin/bash

##
#
# SPA Project Start
#
#######

function angavel:project:_start {
    
    # TODO: check $1 in array
    local COMPOSITION_NAME=$1 # folder ./../../../config/$LOCAL_PROJECT_NAME
    
    ws:docker:compose-control \
    "$GLOBAL_MODULE_PWD/.env/$GLOBAL_CURRENT_ENVIRONMENT/docker.env" \
    "$GLOBAL_MODULE_PWD/config/$COMPOSITION_NAME/docker.yml" \
    "up -d"
    
}

function angavel:project:_stop {
    
    # TODO: check $1 in array
    local COMPOSITION_NAME=$1 # folder ./../../../config/$LOCAL_PROJECT_NAME
    
    ws:docker:compose-control \
    "$GLOBAL_MODULE_PWD/.env/$GLOBAL_CURRENT_ENVIRONMENT/docker.env" \
    "$GLOBAL_MODULE_PWD/config/$COMPOSITION_NAME/docker.yml" \
    "down"
    
}

function  angavel:project:init {
    
    angavel:project:init:_srp
    angavel:project:init:_spa
    angavel:project:init:_api
    
}

function  angavel:project:init:_srp {
    
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