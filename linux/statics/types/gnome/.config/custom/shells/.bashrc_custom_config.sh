# User setup aliases
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

# Discover other operating systems in GRUB once, then restore the original GRUB defaults.
discover_grub() {
	local grub_default="/etc/default/grub"
	local backup_file

	if [[ ! -f "$grub_default" ]]; then
		echo "GRUB defaults file not found: $grub_default"
		return 1
	fi

	if ! command -v os-prober >/dev/null 2>&1; then
		echo "os-prober is not installed. Install it first and retry."
		return 1
	fi

	backup_file="$(mktemp)" || return 1
	sudo cp "$grub_default" "$backup_file" || {
		rm -f "$backup_file"
		return 1
	}

	if grep -q '^GRUB_DISABLE_OS_PROBER=' "$grub_default"; then
		sudo sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' "$grub_default"
	else
		echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a "$grub_default" >/dev/null
	fi

	if command -v update-grub >/dev/null 2>&1; then
		sudo update-grub
	elif command -v grub-mkconfig >/dev/null 2>&1; then
		sudo grub-mkconfig -o /boot/grub/grub.cfg
	else
		echo "No GRUB regeneration command found (update-grub or grub-mkconfig)."
		sudo cp "$backup_file" "$grub_default"
		rm -f "$backup_file"
		return 1
	fi

	sudo cp "$backup_file" "$grub_default"
	rm -f "$backup_file"
	echo "OS discovery completed and /etc/default/grub restored."
}
sync_repo() {
    local repo="$1"
    local message="$2"

    cd "$repo" || return

    git fetch &&
    git pull &&
    git add . &&
    git commit -m "$message" &&
    git push

    cd "$HOME"
}

pullallrepos() {
    local repos_root="$HOME/devops/repos"
    local org_dir
    local repo_dir

    if [[ ! -d "$repos_root" ]]; then
        echo "Directory not found: $repos_root"
        return 1
    fi

    for org_dir in "$repos_root"/*; do
        [[ -d "$org_dir" ]] || continue

        for repo_dir in "$org_dir"/*; do
            [[ -d "$repo_dir/.git" ]] || continue

            (
                cd "$repo_dir" || exit 1
                echo "Updating $(basename "$org_dir")/$(basename "$repo_dir")"
                git pull || echo "Failed to update $repo_dir"
            )
        done
    done
}
