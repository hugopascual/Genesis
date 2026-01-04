#!/bin/bash

##
# @Description
#
##
help() {
    echo \
"
Usage:  ./linux.sh $INSTALL_COMMAND { INSTALLATION_TYPE } { DISTRO }
        ./linux.sh $UPDATE_COMMAND { DISTRO }
        ./linux.sh $SETUP_COMMAND { SETUP_TYPE } { DISTRO }

where   INSTALLATION_TYPE := { ${INSTALL_COMMAND_TYPES[*]} }
        DISTRO := { ${AVAILABLE_DISTROS[*]} }
        SETUP_TYPE := { ${SETUP_TYPES[*]} }
"
    exit 1
}
