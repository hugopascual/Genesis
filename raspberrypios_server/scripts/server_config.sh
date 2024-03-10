#!/bin/bash

#------------------------------- Imports
# Get the path to the main SCRIPTS_dir.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]]}")"
SCRIPTS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$SCRIPTS_DIR/../utils/auxiliar.sh"

#------------------------------- Terminal
# Modify file .bashrc changing \w with \W
sed -iE 's/\\w/\\W/' ~/.bashrc

#------------------------------- Locales
sudo locale-gen en_GB.UTF-8
sudo locale-gen es_ES.UTF-8

sudo localectl set-locale LANGUAGE=en_GB.UTF-8
