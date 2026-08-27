#!/bin/bash

##
# @Description
# 
##
setup_command() {
    local setup_script_path="$SETUP_SCRIPTS_PATH/types/$OPTION_SELECTED.sh"
    local setup_exit_code=0

    check_option_supported "$OPTION_SELECTED" \
        "$SETUP_NOT_VALID_MESSAGE" \
        "${SETUP_TYPES[@]}"

    if [[ ! -f "$setup_script_path" ]]; then
        log_info "Error: Setup type script not found for setup '$OPTION_SELECTED': $setup_script_path"
        return 1
    fi

    log_info "Starting setup for distro -> $DISTRO_SELECTED with option -> $OPTION_SELECTED"
    # shellcheck disable=SC1090
    source "$setup_script_path" || setup_exit_code=$?

    return $setup_exit_code
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
}

desktop_folder_structure_creation() {
    base_folder_structure_creation
    mkdir -p "$VPN_PATH"
    mkdir -p "$WINDOWS_APPS_PATH"
}

server_folder_structure_creation() {
    base_folder_structure_creation
}

custom_shell_setup(){
    local bash_source_line="source $BASH_CONFIG_DESTINATION_PATH"
    local zsh_source_line="source $ZSH_CONFIG_DESTINATION_PATH"

    if [[ -f "$HOME/.bashrc" ]]; then
        grep -qxF "$bash_source_line" "$HOME/.bashrc" || echo "$bash_source_line" >> "$HOME/.bashrc"
    else
        echo "Skipping private functions for .bashrc: file not found"
    fi

    if [[ -f "$HOME/.zshrc" ]]; then
        grep -qxF "$zsh_source_line" "$HOME/.zshrc" || echo "$zsh_source_line" >> "$HOME/.zshrc"
    else
        echo "Skipping private functions for .zshrc: file not found"
    fi
}

copy_config_statics(){
    local source_path="$1"
    local folders_to_copy=()

    if [[ -z "$source_path" ]]; then
        source_path="$TYPES_STATICS_PATH/$OPTION_SELECTED"
    fi

    if [[ -z "$source_path" || ! -d "$source_path" ]]; then
        return 0
    fi

    if [ -d "$source_path/.config" ]; then
        for folder_path in "$source_path/.config"/*; do
            if [ -d "$folder_path" ]; then
                folders_to_copy+=("$(basename "$folder_path")")
            fi
        done
    fi

    for folder in "${folders_to_copy[@]}"; do
        rsync -azP --delete --mkpath "$source_path/.config/$folder/" "$HOME/.config/$folder"
    done
}

setup_install_bundle() {
    local bundle_name="$1"
    local bundle_path="$SETUP_BUNDLES_PATH/$bundle_name.txt"

    if [[ ! -f "$bundle_path" ]]; then
        log_info "Error: Setup bundle not found: $bundle_path"
        return 1
    fi

    install_from_config_file "$bundle_path" "$DISTRO_SELECTED" "true"
}

setup_finalize_type() {
    custom_shell_setup
    sed -iE 's/\\w/\\W/' "$HOME/.bashrc"
}

setup_copy_autostart_entry_if_exists() {
    local desktop_entry_path="$1"
    local autostart_folder="$HOME/.config/autostart"

    mkdir -p "$autostart_folder"

    if [[ -f "$desktop_entry_path" ]]; then
        cp "$desktop_entry_path" "$autostart_folder"
    else
        log_info "Warning: Startup desktop entry not found: $desktop_entry_path"
    fi
}

setup_configure_locales() {
    sudo sed -i -E 's/^# (en_US\.UTF-8 UTF-8)/\1/' /etc/locale.gen
    sudo sed -i -E 's/^# (en_GB\.UTF-8 UTF-8)/\1/' /etc/locale.gen
    sudo sed -i -E 's/^# (es_ES\.UTF-8 UTF-8)/\1/' /etc/locale.gen

    sudo locale-gen
    localectl set-locale LANG=en_GB.UTF-8
    localectl set-locale LANGUAGE=en_GB.UTF-8
    localectl set-locale LC_CTYPE=es_ES.UTF-8
    localectl set-locale LC_NUMERIC=es_ES.UTF-8
    localectl set-locale LC_TIME=es_ES.UTF-8
    localectl set-locale LC_COLLATE=es_ES.UTF-8
    localectl set-locale LC_MONETARY=es_ES.UTF-8
    localectl set-locale LC_MESSAGES=es_ES.UTF-8
    localectl set-locale LC_PAPER=es_ES.UTF-8
    localectl set-locale LC_NAME=es_ES.UTF-8
    localectl set-locale LC_ADDRESS=es_ES.UTF-8
    localectl set-locale LC_TELEPHONE=es_ES.UTF-8
    localectl set-locale LC_MEASUREMENT=es_ES.UTF-8
    localectl set-locale LC_IDENTIFICATION=es_ES.UTF-8
}
