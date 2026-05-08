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
export ADD_DISTRO_COMMAND='add-distro'

export COMMAND_TYPES=(
    "$INSTALL_COMMAND" 
    "$UPDATE_COMMAND" 
    "$SETUP_COMMAND"
    "$ADD_DISTRO_COMMAND"
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
export NEW_DISTRO_NOT_VALID_MESSAGE="New distribution name not valid"
export BASE_COMMAND_NOT_VALID_MESSAGE="Base command for new distribution not valid"
export DISTRO_ALREADY_INCLUDED_MESSAGE="New distribution is already included in package definitions"

################################################################################

# Paths constants
## Basic paths
export COMMANDS_PATH="$BASE_PATH/commands"
export CONFIGS_PATHS="$BASE_PATH/configs"
export FUNCTIONS_PATH="$BASE_PATH/functions"
export LOGS_PATH="$BASE_PATH/logs"
export PACKAGES_PATH="$BASE_PATH/packages"
export UTILITIES_PATH="$BASE_PATH/utilities"
### Statis files paths
export STATICS_PATH="$BASE_PATH/statics"
export REPOSITORIES_CLONE_SCRIPT_PATH="$STATICS_PATH/clone.sh"

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
export DOCKER_BASE_DEVELOPMENT_PATH="$BASE_DEVELOPMENT_PATH/docker"
export DOCKER_DEPLOYMENTS_PATH="$DOCKER_BASE_DEVELOPMENT_PATH/deployments"
export DOCKER_VOLUMES_PATH="$DOCKER_BASE_DEVELOPMENT_PATH/volumes"
export NFS_SHARE_PATH="$HOME/nfs"

################################################################################
