#!/bin/bash

### Auxiliar functions
##
# @Description
# Import all the scripts from the objective folder
# @Parameters
# $1 Directory to import scripts from
##
import_from_dir() {
    directory="$1"
    # shellcheck disable=SC1090
    for file in $( find "$directory" -type f -name "*.sh" -print | sort ); 
    do
        source "$file"
    done
}


### Import utilities
# Get the path to the main directory.
full_path_to_script="$(realpath "${BASH_SOURCE[0]}")"
BASE_PATH="$(dirname "$full_path_to_script")"
export BASE_PATH
# Proper import of utilities
import_from_dir "$BASE_PATH/utilities"

### Check commands input
# Validate if command among available ones
if [[ ! " ${COMMAND_TYPES[*]} " =~ [[:space:]]$1[[:space:]] ]]; then
    echo "$COMMAND_NOT_VALID_MESSAGE"
    help_message
fi

# Execute rutine depending on command
# Import commnands functions
import_from_dir "$BASE_PATH/commands"
case $1 in
    "$INSTALL_COMMAND")
        install_command "$2" "$3"
        ;;
    "$UPDATE_COMMAND")
        update_command "$2"
        ;;
    "$SETUP_COMMAND")
        setup_command "$2"
        ;;
    *)
        echo "$COMMAND_NOT_VALID_MESSAGE"
        help
        ;;
esac
