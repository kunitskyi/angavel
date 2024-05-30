#!/bin/bash

##
#
# Module Argument Initialization
#
#######

function angavel:initialization:argument {

    local DOCKER_ENV_PATH="${GLOBAL_MODULE_PWD}/.env/${GLOBAL_CURRENT_ENVIRONMENT}/docker.env"

    @edit-env-file \
        "${DOCKER_ENV_PATH}" \
        "AG_MODULE_PATH" \
        "${GLOBAL_MODULE_PWD}/"

    @edit-env-file \
        "${DOCKER_ENV_PATH}" \
        "AG_NETWORK_NAME" \
        "${GLOBAL_MODULE_NETWORK_NAME}"
}
