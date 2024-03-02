#!/bin/bash

DIRECTORY=$(dirname "$0")
FUNCTIONS_FILEPATH="$DIRECTORY/support_scripts/functions.sh"
# Import auxiliar functions
# shellcheck source=/dev/null
source "$FUNCTIONS_FILEPATH"

echo_info "hola"