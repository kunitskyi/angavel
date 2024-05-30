#!/bin/bash

##
#
# Core Project Start
#
#######

function angavel:core:project:start-fresh {

    ws:docker:set-network "${GLOBAL_MODULE_NETWORK_NAME}"

    angavel:srp:_stop
    angavel:api:_stop
    angavel:spa:_stop

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

    angavel:srp:_start
    angavel:api:_start
    angavel:spa:_start

    angavel:selector:main
}
