#!/bin/bash

##
#
# Project Script
#
#######

function angavel:core:project:stop {

    angavel:srp:_start
    angavel:api:_start
    angavel:spa:_start

    angavel:selector:main
}
