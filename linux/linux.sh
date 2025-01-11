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
    for file in $( find "$directory" -type f -print | sort ); 
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
# Get distribution to act over
distro_selected="None"
select_distribution
# Proper import
distro_dir="$linux_path/$distro_selected"
import_from_dir "$distro_dir/installations"
import_from_dir "$distro_dir/scripts"


if [ $installation_command ]; then
    echo "hacer instalación TODO"
elif [ $update_command ]; then
    echo "hacer la actualización TODO"
fi
