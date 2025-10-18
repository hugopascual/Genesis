#!/bin/bash

##
# @Description
# Update and upgrade the packages of the system
##
system_update() {
    echo "update"
    # APT packages update
    update_apt
}
