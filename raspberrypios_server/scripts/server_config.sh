#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

# ------------------------------- Terminal
# Modify file .bashrc changing \w with \W
sed -iE 's/\\w/\\W/' ~/.bashrc