#!/bin/bash

##
# @Description
# 
##
update() {
    # Snap packages update
    update_snap
    # Flatpak packages update
    update_flatpak
    # APT packages update
    update_apt
}
