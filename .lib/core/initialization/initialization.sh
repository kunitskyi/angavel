#!/bin/bash

##
#
# Module Core Initialization
#
#######

function angavel:core:initialization {

    local DOCKER_ENV_PATH="${GLOBAL_COMPOSE_ENV_PATH}"

    @edit-env-file \
        "${DOCKER_ENV_PATH}" \
        "AG_MODULE_PATH" \
        "${GLOBAL_MODULE_PWD}/"

    @edit-env-file \
        "${DOCKER_ENV_PATH}" \
        "AG_NETWORK_NAME" \
        "${GLOBAL_MODULE_NETWORK_NAME}"
}
