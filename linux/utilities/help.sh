#!/bin/bash

##
# @Description
#
##
help() {
    echo \
"
Usage:  ./linux.sh install { INSTALLATION_TYPE } { DISTRO }
        ./linux.sh update { DISTRO }
        ./linux.sh customize { DESKTOP_ENVIRONMENT_TYPE }

where   INSTALLATION_TYPE := { desktop | server }
        DISTRO := { ubuntu | debian | raspberrypi }
        DESKTOP_ENVIRONMENT_TYPE := { gnome }
"
    exit 1
}
