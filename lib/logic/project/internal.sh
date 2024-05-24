#!/bin/bash

##
#
# Project Start
#
#######

function angavel:project:_start {

    # TODO: check $1 in array
    local COMPOSITION_NAME=$1 # folder ./../../../config/$LOCAL_PROJECT_NAME

    ws:docker:compose-control \
        "$GLOBAL_MODULE_PWD/.env/$GLOBAL_CURRENT_ENVIRONMENT/docker.env" \
        "$GLOBAL_MODULE_PWD/config/$COMPOSITION_NAME/docker.yml" \
        "up -d"

}

function angavel:project:_stop {

    # TODO: check $1 in array
    local COMPOSITION_NAME=$1 # folder ./../../../config/$LOCAL_PROJECT_NAME

    ws:docker:compose-control \
        "$GLOBAL_MODULE_PWD/.env/$GLOBAL_CURRENT_ENVIRONMENT/docker.env" \
        "$GLOBAL_MODULE_PWD/config/$COMPOSITION_NAME/docker.yml" \
        "down"

}
