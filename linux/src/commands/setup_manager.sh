#!/bin/bash

##
# @Description
# 
##
setup_command() {
    check_option_supported "$OPTION_SELECTED" \
        "$SETUP_NOT_VALID_MESSAGE" \
        "${SETUP_TYPES[@]}"

    log_info "Starting setup for distro -> $DISTRO_SELECTED with option -> $OPTION_SELECTED"
    # shellcheck disable=SC1090
    source "$SETUP_SCRIPTS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED.sh"
}

##############################
#--Auxiliar Setup Functions--#
##############################

base_folder_structure_creation() {
    mkdir -p "$BASE_DEVELOPMENT_PATH"
    mkdir -p "$REPOSITORIES_PATH"
    rsync -azP --delete --mkpath "$REPOSITORIES_CLONE_SCRIPT_PATH" "$REPOSITORIES_PATH/clone.sh"
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

copy_config_statics(){
    local source_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED/.config"
    folders_to_copy=()
    
    # Get all folders from the source path
    if [ -d "$source_path" ]; then
        for folder_path in "$source_path"/*; do
            if [ -d "$folder_path" ]; then
                folders_to_copy+=("$(basename "$folder_path")")
            fi
        done
    fi
    
    for folder in "${folders_to_copy[@]}";
    do
        rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED/.config/$folder/" "$HOME/.config/$folder"
    done
}
