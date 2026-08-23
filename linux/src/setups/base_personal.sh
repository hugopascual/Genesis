#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Create basics folders structure 
desktop_folder_structure_creation

################################################################################
# Configure environment
selected_statics_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED"
copy_config_statics

################################################################
# Add second keyboard distribution

################################################################
# Startup applications

################################################################################
# Other setup configurations

aliases_setup

# .bashrc configuration and customization
sed -iE 's/\\w/\\W/' "$HOME/.bashrc"

################################################################################
# Graphics drivers
