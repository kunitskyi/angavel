#!/bin/bash

##
#
# MODULE LIBRARY LOGIC SRP Index File
#
#######

function MODULE-LIBRARY-LOGIC-SRP-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/logic/srp"

    source $LOCAL_PWD/manager.sh
    source $LOCAL_PWD/ssl.sh

}

MODULE-LIBRARY-LOGIC-SRP-INDEX
