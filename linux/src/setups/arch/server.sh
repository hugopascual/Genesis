#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Configure desktop environment

################################################################################
# Create basics folders structure 

##
# @Description
# Help command or with error usage
##
folder_structure_creation() {
    mkdir -p "$WINDOWS_APPS_PATH"
    mkdir -p "$VPNS_PATH"
    mkdir -p "$REPOSITORIES_PATH"
    rsync -azP --delete --mkpath "$STATICS_PATH/clone.sh" "$REPOSITORIES_PATH/"
    sudo mkdir -p "$DEPLOYMENTS_VOLUMES_PATH"
    sudo mkdir -p "$PERSONAL_NAS_PATH"
    sudo mkdir -p "$WORK_NAS_PATH"
}

################################################################
# Add second keyboard distribution

################################################################
# Startup applications

################################################################################
# Other setup configurations

# .bashrc configuration and customization
sudo sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

# Add aliases to .bashrc
echo \
"
alias ll='ls -alF'
" >> "$HOME/.bashrc"

################################################################################
# Graphics drivers

