#!/bin/bash

##
# @Description
# Add a new distribution key to all package JSON files with a basic command.
#
# Environment Variables:
#   DISTRO_SELECTED: New distribution key to add (e.g. fedora)
#   OPTION_SELECTED: Base command template (supports {package} placeholder)
##
add_distro_command() {
    local new_distro="$DISTRO_SELECTED"
    local base_command="$OPTION_SELECTED"
    local package_files=("$PACKAGES_PATH"/*.json)
    local total_files=0
    local updated_files=0
    local skipped_files=0
    local failed_files=0

    if [[ ! "$new_distro" =~ ^[a-z0-9._-]+$ ]]; then
        log_info "Error: Invalid distro key '$new_distro'. Use lowercase letters, numbers, dot, underscore or dash."
        return 1
    fi

    if [[ -z "$base_command" ]]; then
        log_info "Error: Base command is required."
        return 1
    fi

    if ! command -v jq &> /dev/null; then
        log_info "Error: jq is required to update package JSON files."
        return 1
    fi

    if [[ ! -e "${package_files[0]}" ]]; then
        log_info "Error: No package JSON files found in $PACKAGES_PATH"
        return 1
    fi

    log_info "Adding distro '$new_distro' using base command template: $base_command"

    for package_file in "${package_files[@]}"; do
        local package_name
        package_name="$(basename "$package_file" .json)"
        ((total_files++))

        if jq -e --arg distro "$new_distro" 'has($distro)' "$package_file" > /dev/null; then
            log_info "Skip: '$package_name' already has '$new_distro'"
            ((skipped_files++))
            continue
        fi

        local package_command="$base_command"
        if [[ "$package_command" == *"{package}"* ]]; then
            package_command="${package_command//\{package\}/$package_name}"
        else
            package_command="$package_command $package_name"
        fi

        local tmp_file="${package_file}.tmp"
        if jq --arg distro "$new_distro" --arg cmd "$package_command" \
            '. + {($distro): [$cmd]}' "$package_file" > "$tmp_file"; then
            mv "$tmp_file" "$package_file"
            log_info "Updated: '$package_name'"
            ((updated_files++))
        else
            log_info "Error: Failed to update '$package_name'"
            rm -f "$tmp_file"
            ((failed_files++))
        fi
    done

    log_info "Add distro summary:"
    log_info "  Total package files: $total_files"
    log_info "  Updated: $updated_files"
    log_info "  Skipped: $skipped_files"
    log_info "  Failed: $failed_files"

    if [[ $failed_files -gt 0 ]]; then
        return 1
    fi

    return 0
}
