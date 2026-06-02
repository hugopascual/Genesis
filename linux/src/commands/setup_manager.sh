#!/bin/bash

##
# @Description
# 
##
setup_command() {
    check_option_supported "$OPTION_SELECTED" \
        "$SETUP_NOT_VALID_MESSAGE" \
        "${SETUP_TYPES[@]}"

    log_info "Starting setup for $DISTRO_PLUS_TYPE"
    # shellcheck disable=SC1090
    source "$SETUP_SCRIPTS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED.sh"
}

base_folder_structure_creation() {
    mkdir -p "$BASE_DEVELOPMENT_PATH"
    mkdir -p "$REPOSITORIES_PATH"
    mkdir -p "$DEPLOYMENTS_BASE_PATH"
    mkdir -p "$DEPLOYMENTS_VOLUMES_PATH"
    mkdir -p "$NFS_SHARE_PATH"
    mkdir -p "$VPN_PATH"
    mkdir -p "$WINDOWS_APPS_PATH"
}

aliases_setup(){
    # Add user setup aliases
    cat "$ALIASES_DEFINITIONS_FILEPATH" >> "$HOME/.bashrc"
}
