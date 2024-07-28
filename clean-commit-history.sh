#!/bin/bash

# Check if repository URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <repository_url>"
  exit 1
fi

# Variables
REPO_URL=$1
CLONE_DIR=$(basename "$REPO_URL" .git)
NEW_BRANCH="new-branch"
MAIN_BRANCH="main" # Change this to 'master' if needed

# Clone the repository
git clone "$REPO_URL"
cd "$CLONE_DIR" || exit

# Create a new orphan branch
git checkout --orphan "$NEW_BRANCH"

# Add all files to the new branch
git add -A

# Commit the changes
git commit -m "Initial commit with no history"

# Delete the old main branch
git branch -D "$MAIN_BRANCH"

# Rename the new branch to main
git branch -m "$MAIN_BRANCH"

# Force push the changes
git push -f origin "$MAIN_BRANCH"

# Optionally delete the remote branch if needed
# Uncomment the line below to delete the remote old branch
# git push origin --delete <old-branch-name>

echo "Commit history has been removed and new initial commit has been pushed to $MAIN_BRANCH branch."
