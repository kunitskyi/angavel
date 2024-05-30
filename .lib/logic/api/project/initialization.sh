#!/bin/bash

##
#
# API Project Initialization
#
#######

function angavel:api:project:_initialization {

    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/API/docker.yml"

    git clone \
        -b "${ENV_API_GIT_BRANCH}" \
        "${ENV_API_GIT_URL}" \
        "${GLOBAL_DATA_PWD}/API"

    angavel:general:project:control:_start "API"
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
    angavel:general:project:control:_stop "API"

}
