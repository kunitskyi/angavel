#!/bin/bash

##
#
# Module Entrypoint
#
#######

GLOBAL_MODULE_PWD="${GLOBAL_PWD}/module/angavel"

source "${GLOBAL_MODULE_PWD}/config/selectors.sh"
source "${GLOBAL_MODULE_PWD}/lib/.index.sh"

function module-entrypoint { # FUNCTION NAME is standard
    
    selector-logic GLOBAL_MODULE_MAIN_SELECTOR GLOBAL_MODULE_MAIN_DESCRIPTION
    
}

module-entrypoint