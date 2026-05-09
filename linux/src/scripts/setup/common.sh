#!/bin/bash


##
# @Description
# Help command or with error usage
##
folder_structure_creation() {
    mkdir -p "$WINDOWS_APPS_PATH"
    mkdir -p "$VPNS_PATH"
    mkdir -p "$REPOSITORIES_PATH"
    rsync -azP --delete --mkpath "$STATICS_PATH/clone.sh" "$REPOSITORIES_PATH/"
    sudo mkdir -p "$DOCKER_VOLUMES_PATH"
    sudo mkdir -p "$PERSONAL_NAS_PATH"
    sudo mkdir -p "$WORK_NAS_PATH"
}
