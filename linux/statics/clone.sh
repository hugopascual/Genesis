#!/bin/bash

##
# @Description
# Clone a GitHub repo in the proper dir config its locally username and email
# @Params
# $1 Username to sign commits
# $2 Email to sign commits
# $3 Organization or user who ows the repo
# $4 Repository name
##
clone_repo() {
    username="$1"
    email="$2"
    organization="$3"
    repo_name="$4"

	repos_dir="$HOME/devops/repos"
	organization_repos_dir="$repos_dir/$organization"
    repo_to_clone_dir="$organization_repos_dir/$repo_name"

    if [ ! -d "$organization_repos_dir"  ]; then
        mkdir "$organization_repos_dir"
    fi
    git clone "https://github.com/$organization/$repo_name" "$repo_to_clone_dir"

    cd "$repo_to_clone_dir" && git config user.name "$username"
    cd "$repo_to_clone_dir" && git config user.email "$email"
}

for repo in $4; do
    echo "$repo"
    clone_repo "$1" "$2" "$3" "$repo"
done
