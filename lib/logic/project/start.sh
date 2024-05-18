#!/bin/bash

##
#
# SPA Project Script
#
#######

function angavel:project:start:srp {
    
    if [ $ENV_FLAG_RUN_SRP = 1 ]
    then
        angavel:project:_start "SRP"
    fi
    
}

function angavel:project:start:api {
    
    angavel:project:_start "API"
    
}

function angavel:project:start:spa {
    
    angavel:project:_start "SPA"
    
}
