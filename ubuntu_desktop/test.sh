#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$DIRECTORY/utils/installations.sh"
# shellcheck source=/dev/null
source "$DIRECTORY/utils/dit.sh"

#------------------------------- Test