#!/bin/bash

##
#
# SPA Initialization
#
#######

function angavel:spa:project:_initialization {

    local COMPOSE_PATH="${GLOBAL_CONFIG_PWD}/SPA/docker.yml"

    git clone \
        -b "${ENV_SPA_GIT_BRANCH}" \
        "${ENV_SPA_GIT_URL}" \
        "${GLOBAL_DATA_PWD}/SPA"

    @comment-strings-where 1 "command:" "${COMPOSE_PATH}"
    angavel:general:project:control:_start "SPA"
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
    angavel:general:project:control:_stop "SPA"
    @comment-strings-where 0 "command:" "${COMPOSE_PATH}"

}
