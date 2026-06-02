#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Configure desktop environment

################################################################################
# Create basics folders structure 

base_folder_structure_creation

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

