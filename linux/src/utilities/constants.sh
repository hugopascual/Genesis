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
export INSTALL_CONFIGS_PATH="$BASE_PATH/install_configs"
export LOGS_PATH="$BASE_PATH/logs"
export PACKAGES_PATH="$BASE_PATH/packages"
export STATICS_PATH="$BASE_PATH/statics"

### Installation configs paths
export DEFAULT_DEKSTOP_INSTALL_PATH="$INSTALL_CONFIGS_PATH/desktop.txt"
export DEFAULT_SERVER_INSTALL_PATH="$INSTALL_CONFIGS_PATH/server.txt"

### Logs paths
export LOG_FILE="$LOGS_PATH/genesis_$(date +%Y%m%d_%H%M%S).log"

### Statis files paths
export REPOSITORIES_CLONE_SCRIPT_PATH="$STATICS_PATH/clone.sh"

## src paths
export COMMANDS_PATH="$SRC_PATH/commands"
export CONFIG_PATH="$SRC_PATH/config"
export SCRIPTS_PATH="$SRC_PATH/scripts"
export UTILITIES_PATH="$SRC_PATH/utilities"

### config paths
export AVAILABLE_DISTROS_FILEPATH="$CONFIG_PATH/available_distros.txt"

### Functions paths
export UPDATE_SCRIPTS_PATH="$SCRIPTS_PATH/update"
export SETUP_SCRIPTS_PATH="$SCRIPTS_PATH/setup"

################################################################################

# Setups folders creation paths
export VPN_PATH="$HOME/vpns"
export WINDOWS_APPS_PATH="$HOME/windows_apps"
export BASE_DEVELOPMENT_PATH="$HOME/devops"
export REPOSITORIES_PATH="$BASE_DEVELOPMENT_PATH/repos"
export DEPLOYMENTS_BASE_PATH="$BASE_DEVELOPMENT_PATH/deployments"
export DEPLOYMENTS_VOLUMES_PATH="$DEPLOYMENTS_BASE_PATH/volumes"
export NFS_SHARE_PATH="$HOME/nfs"

################################################################################

# Load available distros
load_available_distros() {
    local distros=()

    if [[ ! -f "$AVAILABLE_DISTROS_FILEPATH" ]]; then
        echo "Error: Distros config file not found: $AVAILABLE_DISTROS_FILEPATH"
        exit 1
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do
        line="${line%%#*}"
        line="$(echo "$line" | xargs)"
        [[ -z "$line" ]] && continue
        distros+=("$line")
    done < "$AVAILABLE_DISTROS_FILEPATH"

    if [[ ${#distros[@]} -eq 0 ]]; then
        echo "Error: Distros config file is empty: $AVAILABLE_DISTROS_FILEPATH"
        exit 1
    fi

    # shellcheck disable=SC2034
    AVAILABLE_DISTROS=("${distros[@]}")
}

load_available_distros

################################################################################
