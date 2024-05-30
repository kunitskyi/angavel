#!/bin/bash

##
#
# Core Project Start
#
#######

function angavel:core:project:start-fresh {

    ws:docker:set-network "${GLOBAL_MODULE_NETWORK_NAME}"

    # angavel:project:stop:_srp
    # angavel:project:stop:_api
    # angavel:project:stop:_spa

    angavel:core:project:initialization

    angavel:core:project:start

}

function angavel:core:project:start-refresh {

    echo -e "\033[1;41m!!!REMOVING FOLDERS BELLOW!!!\033[0m"
    echo -e "\033[1m${GLOBAL_DATA_PWD}\033[0m"
    echo -e "\033[1m${GLOBAL_CACHE_PWD}\033[0m"
    sudo rm -rfI \
        "${GLOBAL_DATA_PWD}" \
        "${GLOBAL_CACHE_PWD}"

    ws:docker:prune
    angavel:core:project:start-fresh

}

function angavel:core:project:start {

    # angavel:project:start:_srp
    # angavel:project:start:_api
    # angavel:project:start:_spa

    angavel:selector:main
}
