#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Create basics folders structure 
base_folder_structure_creation

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

################################################################################
# Graphics drivers
