#!/bin/bash

##
#
# Project Script
#
#######

function angavel:core:project:stop {

    angavel:srp:_stop
    angavel:api:_stop
    angavel:spa:_stop

    angavel:selector:main
}
