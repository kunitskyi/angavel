#!/bin/bash

##
#
# MODULE LIBRARY CORE Index File
#
#######

function MODULE-LIBRARY-CORE-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/core"

    source $LOCAL_PWD/initialization/.index.sh
    source $LOCAL_PWD/project/.index.sh

}

MODULE-LIBRARY-CORE-INDEX
