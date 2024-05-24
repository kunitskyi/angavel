#!/bin/bash

##
#
# Module Entrypoint
#
#######

GLOBAL_MODULE_NETWORK_NAME="${GLOBAL_CURRENT_MODULE}-${GLOBAL_CURRENT_ENVIRONMENT}-net"
GLOBAL_MODULE_PWD="${GLOBAL_PWD}/module/${GLOBAL_CURRENT_MODULE}"
GLOBAL_COMPOSE_PWD="${GLOBAL_MODULE_PWD}/config"
GLOBAL_DATA_PWD="${GLOBAL_MODULE_PWD}/data/${GLOBAL_CURRENT_ENVIRONMENT}"
GLOBAL_CACHE_PWD="${GLOBAL_MODULE_PWD}/cache/${GLOBAL_CURRENT_ENVIRONMENT}"
GLOBAL_ENV_PWD="${GLOBAL_MODULE_PWD}/.env/${GLOBAL_CURRENT_ENVIRONMENT}"
GLOBAL_COMPOSE_ENV_PATH="${GLOBAL_ENV_PWD}/docker.env"

source "${GLOBAL_MODULE_PWD}/.env/${GLOBAL_CURRENT_ENVIRONMENT}/panel.env"
source "${GLOBAL_MODULE_PWD}/.env/${GLOBAL_CURRENT_ENVIRONMENT}/selectors.sh"
source "${GLOBAL_MODULE_PWD}/lib/.index.sh"

function ws:module-entrypoint { # FUNCTION NAME is standard

    angavel:selector:main

}

angavel:initialization:argument
ws:module-entrypoint
