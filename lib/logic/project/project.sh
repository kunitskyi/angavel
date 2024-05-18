#!/bin/bash

##
#
# Project Script
#
#######

function angavel:project:stop {
    
    angavel:project:stop:srp
    angavel:project:stop:api
    angavel:project:stop:spa
    
    angavel:selector:main
}

function angavel:project:start-fresh {
    
    local LOCAL_API_COMPOSE_PATH="${GLOBAL_COMPOSE_PWD}/API/docker.yml"
    local LOCAL_SPA_COMPOSE_PATH="${GLOBAL_COMPOSE_PWD}/SPA/docker.yml"
    
    ws:docker:set-network "${GLOBAL_MODULE_NETWORK_NAME}"
    
    angavel:project:stop
    
    git clone \
    -b "${ENV_API_GIT_BRANCH}" \
    "${ENV_API_GIT_URL}" \
    "${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}/API"
    
    git clone \
    -b "${ENV_SPA_GIT_BRANCH}" \
    "${ENV_SPA_GIT_URL}" \
    "${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}/SPA"
    
    angavel:project:_start "API"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_API_COMPOSE_PATH}" \
    "api_cgi" "chmod +x /cgi-cmd.sh"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_API_COMPOSE_PATH}" \
    "api_cgi" "/cgi-cmd.sh change-group/owner"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_API_COMPOSE_PATH}" \
    "api_cgi" "/cgi-cmd.sh composer-install"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_API_COMPOSE_PATH}" \
    "api_cgi" "/cgi-cmd.sh artisan-key-gen"
    angavel:project:_stop "API"
    
    @comment-strings-where  1 "command:" "${LOCAL_SPA_COMPOSE_PATH}"
    angavel:project:_start "SPA"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_SPA_COMPOSE_PATH}" \
    "spa_angular" "chmod +x /node-cmd.sh"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_SPA_COMPOSE_PATH}" \
    "spa_angular" "/node-cmd.sh fresh-install/build"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_SPA_COMPOSE_PATH}" \
    "spa_webserver" "chmod +x /nginx-cmd.sh"
    ws:docker:compose:send-cmd \
    "${GLOBAL_COMPOSE_ENV_PATH}" "${LOCAL_SPA_COMPOSE_PATH}" \
    "spa_webserver" "/nginx-cmd.sh change-group/owner"
    angavel:project:_stop "SPA"
    @comment-strings-where  0 "command:" "${LOCAL_SPA_COMPOSE_PATH}"
    
    angavel:project:start
    
}

function angavel:project:start-refresh {
    
    local DATA_DIR_PWD="${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}"
    local CACHE_DIR_PWD="${GLOBAL_MODULE_PWD}/cache/${GLOBAL_CURRENT_ENVIRONMENT}"
    
    echo -e "\033[1;41m!!!REMOVING FOLDERS BELLOW!!!\033[0m"
    echo -e "\033[1m${DATA_DIR_PWD}\033[0m"
    echo -e "\033[1m${CACHE_DIR_PWD}\033[0m"
    sudo rm -rfI \
    "${DATA_DIR_PWD}" \
    "${CACHE_DIR_PWD}"
    
    ws:docker:prune
    angavel:project:start-fresh
    
}

function angavel:project:start {
    
    # angavel:project:start:srp
    angavel:project:start:api
    angavel:project:start:spa
    
    angavel:selector:main
}
