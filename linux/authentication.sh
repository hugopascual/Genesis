#!/bin/bash

# Load configuration file
source "$1"

# GitHub Cli
gh auth login -h $GITHUB_USERNAME --with-token $GITHUB_TOKEN
# Clone repositories
for user in "${!GIT_REPOS_USERS[@]}"; do
    for email in ${GIT_REPOS_USERS[$user]}; do
        for org in ${GIT_REPOS_EMAILS[$email]}; do
            repo_names_list="${GIT_REPOS_ORGS[$org]}"
            echo "Cloning repositories: $repo_names_list from organization: $org for user: $user with email: $email"
            #./clone.sh $user $email $org $repo_names_list
        done
    done
done
