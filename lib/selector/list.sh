#!/bin/bash

##
#
# LIST of SELECTORS
#
#######

function angavel:selector:main {
    ws:selector-logic GLOBAL_MODULE_MAIN_SELECTOR GLOBAL_MODULE_MAIN_DESCRIPTION
}

function angavel:selector:project-control {
    ws:selector-logic GLOBAL_MODULE_PROJECT_CONTROL_SELECTOR GLOBAL_MODULE_PROJECT_CONTROL_DESCRIPTION
}

function angavel:selector:project-start {
    ws:selector-logic GLOBAL_MODULE_PROJECT_START_SELECTOR GLOBAL_MODULE_PROJECT_START_DESCRIPTION
}

function angavel:selector:docker {
    ws:selector-logic GLOBAL_MODULE_DOCKER_SELECTOR GLOBAL_MODULE_DOCKER_DESCRIPTION
}

function angavel:selector:docker-composition {
    @wip
    ws:selector-logic GLOBAL_MODULE_COMPOSITION_SELECTOR
}

function angavel:selector:backups {
    @wip
    ws:selector-logic GLOBAL_MODULE_BACKUPS_SELECTOR
}

function angavel:selector:git {
    @wip
    ws:selector-logic GLOBAL_MODULE_GIT_SELECTOR
}