#!/bin/bash

# Sync script for mirroring GitLab repository to GitHub
# Source: https://gitlab.com/Defi-Token-Manager26/v1.git

set -e

GITLAB_REPO="https://gitlab.com/Defi-Token-Manager26/v1.git"
GITLAB_REMOTE="gitlab"

echo "=== GitLab to GitHub Sync Script ==="
echo ""

# Check if gitlab remote exists
if git remote | grep -q "^${GITLAB_REMOTE}$"; then
    echo "✓ GitLab remote already exists"
else
    echo "Adding GitLab remote..."
    git remote add "${GITLAB_REMOTE}" "${GITLAB_REPO}"
fi

# Fetch from GitLab
echo "Fetching from GitLab..."
git fetch "${GITLAB_REMOTE}"

# Get the default branch name from GitLab
GITLAB_BRANCH=$(git remote show "${GITLAB_REMOTE}" | grep "HEAD branch" | cut -d' ' -f5)

if [ -z "$GITLAB_BRANCH" ]; then
    echo "Warning: Could not determine GitLab default branch, trying 'main' and 'master'..."
    if git ls-remote --heads "${GITLAB_REMOTE}" main | grep -q main; then
        GITLAB_BRANCH="main"
    elif git ls-remote --heads "${GITLAB_REMOTE}" master | grep -q master; then
        GITLAB_BRANCH="master"
    else
        echo "Error: Could not determine default branch"
        exit 1
    fi
fi

echo "GitLab default branch: ${GITLAB_BRANCH}"

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

# Merge GitLab changes
echo "Merging changes from gitlab/${GITLAB_BRANCH}..."
# Use --allow-unrelated-histories for initial merge
if git merge-base HEAD "${GITLAB_REMOTE}/${GITLAB_BRANCH}" &>/dev/null; then
    git merge "${GITLAB_REMOTE}/${GITLAB_BRANCH}" --no-edit
else
    echo "Performing initial merge with unrelated histories..."
    git merge "${GITLAB_REMOTE}/${GITLAB_BRANCH}" --allow-unrelated-histories --no-edit
fi

# Push to GitHub
echo "Pushing to GitHub..."
git push origin "${CURRENT_BRANCH}"

echo ""
echo "✓ Sync complete!"
echo ""
echo "GitLab branch '${GITLAB_BRANCH}' has been merged into '${CURRENT_BRANCH}' and pushed to GitHub."
