#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$BASE_DIR/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$BASE_DIR/utils/installations.sh"
# shellcheck source=/dev/null
source "$BASE_DIR/utils/dit.sh"

#------------------------------- Test
"$BASE_DIR"/scripts/git_config.sh