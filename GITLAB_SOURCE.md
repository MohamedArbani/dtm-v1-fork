# GitLab Source Repository

This repository is a fork/mirror of the GitLab project:

**Source:** https://gitlab.com/Defi-Token-Manager26/v1.git

## About This Fork

This GitHub repository maintains a copy of the Defi Token Manager v1 project originally hosted on GitLab.

## Syncing with GitLab Source

To sync this repository with the GitLab source:

1. Add the GitLab repository as a remote:
   ```bash
   git remote add gitlab https://gitlab.com/Defi-Token-Manager26/v1.git
   ```

2. Fetch from GitLab:
   ```bash
   git fetch gitlab
   ```

3. Merge or rebase the changes:
   ```bash
   git merge gitlab/main
   # or
   git merge gitlab/master
   ```

4. Push to GitHub:
   ```bash
   git push origin main
   ```

## Automated Sync

For automated syncing, you can use the `sync-from-gitlab.sh` script provided in this repository.

## Manual Clone Process

If starting fresh, you can clone the GitLab repository and push to GitHub:

```bash
# Clone from GitLab
git clone https://gitlab.com/Defi-Token-Manager26/v1.git dtm-v1

# Change to the directory
cd dtm-v1

# Add GitHub as a remote
git remote add github https://github.com/MohamedArbani/dtm-v1-fork.git

# Push to GitHub
git push github --all
git push github --tags
```
