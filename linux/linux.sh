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
linux_path="$(dirname "$full_path_to_script")"
# Proper import of utilities
import_from_dir "$linux_path/utilities"


### Check commands input
command_not_valid_message="Command not valid"
command_value_not_valid_message="Value for command not valid"
installation_command=false
update_command=false
command_value="$2"

case $1 in
    "install")
        installation_command=true
        ;;
    "update")
        update_command=true
        ;;
    *)
        echo "$command_not_valid_message"
        help_message
        ;;
esac

if [ $installation_command == true ];then
    if [[ ! " ${INSTALL_COMMAND_TYPES[*]} " =~ [[:space:]]${command_value}[[:space:]] ]]; then
        echo "$command_value_not_valid_message"
        help_message
    fi
fi


### Import distro functions
# Getting the distribution to act on
distro_selected="None"
select_distribution
# Proper import
distro_dir="$linux_path/$distro_selected"
import_from_dir "$distro_dir"

if [ "$installation_command" == true ]; then
    case $command_value in
        "dekstop")
            desktop_setup
            ;;
        "server")
            server_setup
            ;;
        *)
            echo "$command_not_valid_message"
            help_message
            ;;
    esac
elif [ "$update_command" == true ]; then
    update
else
    echo "$command_value_not_valid_message"
    help_message
fi
