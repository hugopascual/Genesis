#!/bin/bash

################################################################################
# Get the path to the main directory.
full_path_to_script="$(realpath "${BASH_SOURCE[0]}")"
BASE_PATH="$(dirname "$full_path_to_script")"
export BASE_PATH

# Paths constants
export COMMANDS_PATH="$BASE_PATH/commands"
export FUNCTIONS_PATH="$BASE_PATH/functions"
export UTILITIES_PATH="$BASE_PATH/utilities"
export STATICS_PATH="$BASE_PATH/statics"

export INSTALL_FUNCTIONS_PATH="$FUNCTIONS_PATH/install"
export UPDATE_FUNCTIONS_PATH="$FUNCTIONS_PATH/update"
export SETUP_FUNCTIONS_PATH="$FUNCTIONS_PATH/setup"


################################################################################
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

################################################################################
### Imports
import_from_dir "$UTILITIES_PATH"
import_from_dir "$COMMANDS_PATH"

export COMMAND_SELECTED="$1"
check_option_supported "$COMMAND_SELECTED" \
    "$COMMAND_TYPES" \
    "$COMMAND_NOT_VALID_MESSAGE"

export DISTRO_SELECTED="$2"
check_option_supported "$DISTRO_SELECTED" \
    "$AVAILABLE_DISTROS" \
    "$DISTRIBUTION_NOT_VALID_MESSAGE"

export OPTION_SELECTED="$3"

# Display options selected and ask for confirmation
echo_info "Command selected: $COMMAND_SELECTED"
echo_info "Distribution selected: $DISTRO_SELECTED"
echo_info "Option selected: $OPTION_SELECTED"

read -p "Are you sure you want to continue? (y/n): " -n 1 -r ANSWER
echo
if [[ ! $ANSWER =~ ^[Yy]$ ]]; then
    echo_info "Operation cancelled by user"
    exit 1
fi

# Execute routine depending on command
case $COMMAND_SELECTED in
    "$INSTALL_COMMAND")
        install_command
        ;;
    "$UPDATE_COMMAND")
        update_command
        ;;
    "$SETUP_COMMAND")
        setup_command
        ;;
    *)
        echo "$COMMAND_NOT_VALID_MESSAGE"
        help
        ;;
esac
