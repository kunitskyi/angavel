#!/bin/bash

##
#
# Module Entrypoint
#
#######

GLOBAL_MODULE_PWD="${GLOBAL_PWD}/module/angavel"

source "${GLOBAL_MODULE_PWD}/.env/${GLOBAL_CURRENT_ENVIRONMENT}/selectors.sh"
source "${GLOBAL_MODULE_PWD}/lib/.index.sh"

function ws:module-entrypoint { # FUNCTION NAME is standard
    
    angavel:selector:main
    
}

ws:module-entrypoint