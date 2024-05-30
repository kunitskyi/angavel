#!/bin/bash

##
#
# SRP Start
#
#######

function angavel:srp:_start {

    if [ $ENV_FLAG_RUN_SRP = 1 ]; then
        angavel:general:project:control:_start "SRP"
    fi

}
