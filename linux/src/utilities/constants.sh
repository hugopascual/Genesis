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
export INSTALL_COMMAND_TYPES=(
    "personal"
    "work" 
    "server"
)

# Available setup types
# TODO: How to extract the available types from the actual scripts
export GNOME='gnome'
export HYPRLAND='hyprland'
export SERVER='server'
export KDE='kde'

export SETUP_TYPES=(
    "$GNOME"
    "$HYPRLAND"
    "$SERVER"
    "$KDE"
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

### Logs paths
export LOG_FILE="$LOGS_PATH/genesis_$(date +%Y%m%d_%H%M%S).log"

### Statis files paths
export REPOSITORIES_CLONE_SCRIPT_PATH="$STATICS_PATH/clone.sh"

## src paths
export COMMANDS_PATH="$SRC_PATH/commands"
export CONFIG_PATH="$SRC_PATH/config"
export SETUP_SCRIPTS_PATH="$SRC_PATH/setups"
export UTILITIES_PATH="$SRC_PATH/utilities"

### config paths
export AVAILABLE_DISTROS_FILEPATH="$CONFIG_PATH/available_distros.txt"
#### config path destinations
export CUSTOM_CONFIG_DESTINATION_PATH="$HOME/.config/custom"
export THEMES_CONFIG_DESTINATION_PATH="$CUSTOM_CONFIG_DESTINATION_PATH/themes"
export BACKGROUND_DESTINATION_PATH="$THEMES_CONFIG_DESTINATION_PATH/background.jpg"
export SCREENSAVER_DESTINATION_PATH="$THEMES_CONFIG_DESTINATION_PATH/screensaver.jpg"
export SHELLS_CONFIG_DESTINATION_PATH="$CUSTOM_CONFIG_DESTINATION_PATH/shells"
export BASH_CONFIG_DESTINATION_PATH="$SHELLS_CONFIG_DESTINATION_PATH/.bashrc_custom_config.sh"
export ZSH_CONFIG_DESTINATION_PATH="$SHELLS_CONFIG_DESTINATION_PATH/.zshrc_custom_config.sh"

################################################################################

# Setups folders creation paths
export BASE_DEVELOPMENT_PATH="$HOME/devops"
export REPOSITORIES_PATH="$BASE_DEVELOPMENT_PATH/repos"
export DEPLOYMENTS_BASE_PATH="$BASE_DEVELOPMENT_PATH/deployments"
export DEPLOYMENTS_VOLUMES_PATH="$DEPLOYMENTS_BASE_PATH/volumes"
export NFS_SHARE_PATH="$HOME/nfs"
export VPN_PATH="$HOME/vpns"
export WINDOWS_APPS_PATH="$HOME/windows"

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
