#!/bin/bash

##
# @Description
# Update and upgrade the packages of the system
##
update() {
    # Snap packages update
    update_snap
    # Flatpak packages update
    update_flatpak
    # APT packages update
    update_apt
}
