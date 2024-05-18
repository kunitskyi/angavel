#!/bin/bash

##
#
# MODULE LIBRARY LOGIC Index File
#
#######

function MODULE-LIBRARY-LOGIC-INDEX {
    
    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/lib/logic"
    
    source $LOCAL_PWD/initialization/.index.sh
    source $LOCAL_PWD/project/.index.sh
    
}

MODULE-LIBRARY-LOGIC-INDEX