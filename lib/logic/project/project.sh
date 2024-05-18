#!/bin/bash

##
#
# Project Script
#
#######

function angavel:project:stop {
    
    angavel:project:stop:_srp
    angavel:project:stop:_api
    angavel:project:stop:_spa
    
    angavel:selector:main
}

function angavel:project:start-fresh {
    
    ws:docker:set-network "${GLOBAL_MODULE_NETWORK_NAME}"
    
    angavel:project:stop:_srp
    angavel:project:stop:_api
    angavel:project:stop:_spa
    
    angavel:project:init
    
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
    
    angavel:project:start:_srp
    angavel:project:start:_api
    angavel:project:start:_spa
    
    angavel:selector:main
}
