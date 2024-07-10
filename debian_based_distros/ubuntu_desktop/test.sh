#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
UTILS_DIR="$BASE_DIR/functions/"
SCRIPTS_DIR="$BASE_DIR/scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$UTILS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Test
array=("item 1" 
"item 2" 
"item 3")
for i in "${array[@]}"; do   # The quotes are necessary here
    echo "$i"
done