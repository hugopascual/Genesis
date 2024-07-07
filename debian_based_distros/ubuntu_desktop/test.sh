#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
UTILS_DIR="$BASE_DIR/utils/"
SCRIPTS_DIR="$BASE_DIR/scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$UTILS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Test
