#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
MAIN_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$MAIN_DIR/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$MAIN_DIR/utils/installations.sh"
# shellcheck source=/dev/null
source "$MAIN_DIR/utils/dit.sh"

#------------------------------- Test

