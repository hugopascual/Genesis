#!/bin/bash

# Load configuration file
# shellcheck disable=SC1090
source "$1"

# GitHub Cli
echo "Use this token $GITHUB_TOKEN"
gh auth login -h github.com -p https 

# Clone repositories
for user in "${!GIT_REPOS_USERS[@]}"; do
    for email in ${GIT_REPOS_USERS[$user]}; do
        for org in ${GIT_REPOS_EMAILS[$email]}; do
            repo_names_list="${GIT_REPOS_ORGS[$org]}"
            echo "Cloning repositories: $repo_names_list from organization: $org for user: $user with email: $email"
            ./clone.sh "$user" "$email" "$org" "$repo_names_list"
        done
    done
done
