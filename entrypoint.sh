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

GLOBAL_COMPOSE_ENV_PATH="${GLOBAL_ENVIRONMENT_PWD}/.conf/docker.env"

source "${GLOBAL_ENVIRONMENT_PWD}/.conf/panel.env"
source "${GLOBAL_ENVIRONMENT_PWD}/.conf/selectors.sh"
source "${GLOBAL_MODULE_PWD}/.lib/.index.sh"

function ws:module-entrypoint { # FUNCTION NAME is standard

    angavel:selector:main

}

angavel:core:initialization
ws:module-entrypoint
