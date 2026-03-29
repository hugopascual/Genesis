#!/bin/bash

################################################################################

# Configuration
## Logging
export GENESIS_LOG_ENABLED="${GENESIS_LOG_ENABLED:-true}"
export LOG_LEVEL_SEVERE="SEVERE"
export LOG_LEVEL_WARNING="WARNING"
export LOG_LEVEL_INFO="INFO"
export LOG_LEVEL_CONFIG="CONFIG"
export LOG_LEVEL_FINE="FINE"
export LOG_LEVEL_FINER="FINER"
export LOG_LEVEL_FINEST="FINEST"

################################################################################

# Available command types
export INSTALL_COMMAND='install'
export UPDATE_COMMAND='update'
export SETUP_COMMAND='setup'

export COMMAND_TYPES=(
    "$INSTALL_COMMAND" 
    "$UPDATE_COMMAND" 
    "$SETUP_COMMAND"
)

# Available installation types
export INSTALL_TYPE_DESKTOP='desktop'
export INSTALL_TYPE_SERVER='server'

export INSTALL_COMMAND_TYPES=(
    "$INSTALL_TYPE_DESKTOP" 
    "$INSTALL_TYPE_SERVER"
)

# Available distros
export UBUNTU='ubuntu'
export DEBIAN='debian'
export ARCH='arch'

export AVAILABLE_DISTROS=(
    "$UBUNTU" 
    "$DEBIAN"
    "$ARCH"
)

# Available setup types
export GNOME='gnome'
export HYPRLAND='hyprland'

export SETUP_TYPES=(
    "$GNOME"
    "$HYPRLAND"
)

################################################################################

# Messages
export COMMAND_NOT_VALID_MESSAGE="Command selected not valid"
export INSTALLATION_TYPE_NOT_VALID_MESSAGE="Installation type selected not valid"
export DISTRIBUTION_NOT_VALID_MESSAGE="Distribution selected not valid"
export SETUT_NOT_VALID_MESSAGE="Setup selected not valid"

################################################################################

# Paths constants
## Basic paths
export COMMANDS_PATH="$BASE_PATH/commands"
export CONFIGS_PATHS="$BASE_PATH/configs"
export FUNCTIONS_PATH="$BASE_PATH/functions"
export LOGS_PATH="$BASE_PATH/logs"
export PACKAGES_PATH="$BASE_PATH/packages"
export UTILITIES_PATH="$BASE_PATH/utilities"
export STATICS_PATH="$BASE_PATH/statics"

## Functions paths
export INSTALL_FUNCTIONS_PATH="$FUNCTIONS_PATH/install"
export UPDATE_FUNCTIONS_PATH="$FUNCTIONS_PATH/update"
export SETUP_FUNCTIONS_PATH="$FUNCTIONS_PATH/setup"

## Installation default configs paths
export DEFAULT_DEKSTOP_INSTALL_PATH="$CONFIGS_PATHS/default_desktop.txt"
export DEFAULT_SERVER_INSTALL_PATH="$CONFIGS_PATHS/default_server.txt"

## Logs paths
export LOG_FILE="$LOGS_PATH/genesis_$(date +%Y%m%d_%H%M%S).log"

## Setup paths
export VPN_PATH="$HOME/vpns"
export WINDOWS_APPS_PATH="$HOME/windows_apps"
export BASE_DEVELOPMENT_PATH="$HOME/devops"
export REPOSITORIES_PATH="$BASE_DEVELOPMENT_PATH/repos"
export DOCKER_VOLUMES_PATH="/mnt/docker_volumes"
export PERSONAL_NAS_PATH="/mnt/nas_personal"
export WORK_NAS_PATH="/mnt/nas_work"

################################################################################
