#!/bin/bash

##
#
# Module Entrypoint
#
#######

GLOBAL_MODULE_NETWORK_NAME="${GLOBAL_CURRENT_MODULE}-${GLOBAL_CURRENT_ENVIRONMENT}-net"

GLOBAL_MODULE_PWD="${GLOBAL_PWD}/module/${GLOBAL_CURRENT_MODULE}"

GLOBAL_ENVIRONMENT_PWD="${GLOBAL_MODULE_PWD}/environment/${GLOBAL_CURRENT_ENVIRONMENT}"
GLOBAL_CONFIG_PWD="${GLOBAL_MODULE_PWD}/.lib/config"
GLOBAL_DATA_PWD="${GLOBAL_ENVIRONMENT_PWD}/data/"
GLOBAL_CACHE_PWD="${GLOBAL_ENVIRONMENT_PWD}/cache/"

GLOBAL_COMPOSE_ENV_PATH="${GLOBAL_MODULE_PWD}/docker.env"

source "${GLOBAL_MODULE_PWD}/env/${GLOBAL_CURRENT_ENVIRONMENT}/panel.env"
source "${GLOBAL_MODULE_PWD}/env/${GLOBAL_CURRENT_ENVIRONMENT}/selectors.sh"
source "${GLOBAL_MODULE_PWD}/.lib/.index.sh"

function ws:module-entrypoint { # FUNCTION NAME is standard

    angavel:selector:main

}

angavel:initialization:argument
ws:module-entrypoint
