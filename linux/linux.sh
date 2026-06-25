#!/bin/bash

########################################################################################################################
# Get the path to the main directory.
full_path_to_script="$(realpath "${BASH_SOURCE[0]}")"
BASE_PATH="$(dirname "$full_path_to_script")"
SRC_PATH="$BASE_PATH/src"

export BASE_PATH
export SRC_PATH

########################################################################################################################
##
# @Description
# Import all the scripts recursively from the objective folder
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

########################################################################################################################
### Imports
import_from_dir "$SRC_PATH/utilities"
import_from_dir "$COMMANDS_PATH"

########################################################################################################################
### Initialize logging system
init_log

export COMMAND_SELECTED="$1"
export DISTRO_SELECTED="$2"
export OPTION_SELECTED="$3"

log_info "Command selected: $COMMAND_SELECTED"
log_info "Distribution selected: $DISTRO_SELECTED"
log_info "Option selected: $OPTION_SELECTED"

check_option_supported "$COMMAND_SELECTED" \
    "$COMMAND_NOT_VALID_MESSAGE" \
    "${COMMAND_TYPES[@]}" 

case $COMMAND_SELECTED in
    "$INSTALL_COMMAND"|"$SETUP_COMMAND")
        check_option_supported "$DISTRO_SELECTED" \
            "$DISTRIBUTION_NOT_VALID_MESSAGE" \
            "${AVAILABLE_DISTROS[@]}"
        ;;
    "$ADD_DISTRO_COMMAND")
        check_required_value "$DISTRO_SELECTED" "$NEW_DISTRO_NOT_VALID_MESSAGE"
        check_required_value "$OPTION_SELECTED" "$BASE_COMMAND_NOT_VALID_MESSAGE"
        check_distro_not_included_in_packages "$DISTRO_SELECTED"
        ;;
esac

# Display options selected and ask for confirmation
read -p "Are you sure you want to continue? (Y/n): " -r ANSWER
echo
if [[ -n "$ANSWER" && ! $ANSWER =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
    log_info "Operation cancelled by user"
    exit 1
fi

# Execute routine depending on command
case $COMMAND_SELECTED in
    "$INSTALL_COMMAND")
        log_info "Starting installation for $DISTRO_SELECTED with option $OPTION_SELECTED"
        install_command
        ;;
    "$UPDATE_COMMAND")
        log_info "Starting update for $DISTRO_SELECTED"
        update_command
        ;;
    "$SETUP_COMMAND")
        log_info "Starting setup for $DISTRO_SELECTED with option $OPTION_SELECTED"
        setup_command
        ;;
    "$ADD_DISTRO_COMMAND")
        log_info "Adding new distro '$DISTRO_SELECTED' to all packages"
        add_distro_command
        ;;
    *)
        echo "$COMMAND_NOT_VALID_MESSAGE"
        help
        ;;
esac

########################################################################################################################
### Display log file location
if [[ "${GENESIS_LOG_ENABLED}" == "true" ]]; then
    log_info "Execution completed!"
    log_info "Log file saved at: $LOG_FILE"
fi
