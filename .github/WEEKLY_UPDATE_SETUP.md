# Weekly Flake Update CI Setup Guide

This workflow automatically updates your flake.lock file weekly, builds all systems, and uploads results to Cachix for fast deployments.

## What the workflow does

1. **Runs every Sunday at midnight UTC** (configurable)
2. **Updates flake.lock** with latest versions of all inputs
3. **Builds all configurations:**
   - eranpc NixOS system
   - eranlaptop NixOS system
   - eranpc Home Manager config
   - eranlaptop Home Manager config
4. **Uploads builds to Cachix** automatically
5. **Creates a branch** named `weekly-update/YYYY-MM-DD` with the updated flake.lock
6. **You can checkout the branch** and get fast builds thanks to the cache!

## Setup Instructions

### 1. Create a Cachix cache (one-time setup)

If you don't already have a Cachix cache for your personal builds:

```bash
# Install cachix if you haven't
nix-env -iA cachix -f https://cachix.org/api/v1/install

# Login to Cachix (creates account if needed)
cachix authtoken <YOUR_TOKEN>

# Create your cache (e.g., "eranknafo2001" or "dotfiles")
cachix create <cache-name>

# Generate an auth token for GitHub Actions
cachix generate-keypair <cache-name>
```

Visit https://app.cachix.org to manage your caches and get your auth token.

### 2. Configure GitHub repository secrets

Add these secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** and add:

   - **Name:** `CACHIX_CACHE_NAME`
     **Value:** Your cache name (e.g., `eranknafo2001`)

   - **Name:** `CACHIX_AUTH_TOKEN`
     **Value:** Your Cachix auth token (from step 1)

### 3. Update your system configuration to use your cache

Add your personal cache to `modules/system/common.nix`:

```nix
nix.settings = {
  substituters = [
    "https://hyprland.cachix.org"
    "https://nix-community.cachix.org"
    "https://<your-cache-name>.cachix.org"  # Add this line
  ];
  trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "<your-cache-name>.cachix.org-1:..."  # Add your cache's public key
  ];
};
```

Get your cache's public key from:
```bash
cachix use <your-cache-name>
# It will show the public key
```

### 4. Enable GitHub Actions

Push this branch and the workflow will be ready to run!

```bash
git add .github/
git commit -m "Add weekly flake update CI workflow"
git push origin claude/weekly-flake-ci-cache-Q8BR1
```

### 5. Test the workflow manually (optional)

Before waiting for Sunday, test it manually:

1. Go to your repository on GitHub
2. Click **Actions** tab
3. Select **Weekly Flake Update and Cache**
4. Click **Run workflow** → **Run workflow**

## Using the weekly updates

When the workflow runs, it creates a branch like `weekly-update/2026-01-12`. To upgrade:

```bash
# Fetch the latest update branch
git fetch origin

# Checkout the weekly update branch
git checkout weekly-update/2026-01-12

# Rebuild your system (FAST because it's cached!)
sudo nixos-rebuild switch --flake .#eranpc
# or
sudo nixos-rebuild switch --flake .#eranlaptop

# Rebuild home-manager
home-manager switch --flake .#eranpc
# or
home-manager switch --flake .#eranlaptop
```

The builds will be **lightning fast** because everything was already built and cached by the CI!

## Customization

### Change the schedule

Edit `.github/workflows/weekly-flake-update.yml`:

```yaml
on:
  schedule:
    # Run every day at 2 AM UTC
    - cron: '0 2 * * *'

    # Or every Monday and Thursday at 6 AM UTC
    - cron: '0 6 * * 1,4'
```

Cron syntax: `minute hour day-of-month month day-of-week`

### Auto-merge to main

If you want to automatically merge updates to main (risky!), add this step at the end:

```yaml
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v5
        with:
          branch: ${{ env.BRANCH_NAME }}
          title: "Weekly flake update $(date +%Y-%m-%d)"
          body: |
            Automated weekly update of flake.lock
            All systems built and cached successfully.
```

## Troubleshooting

### Workflow fails with "permission denied"

Make sure the workflow has write permissions. Check `.github/workflows/weekly-flake-update.yml` has:
```yaml
permissions:
  contents: write
```

### Builds fail with "cache not found"

The workflow will still work! It just means Cachix couldn't upload (maybe auth token issue). Check your secrets are set correctly.

### No branch is created

Check the workflow logs. If flake.lock didn't change (no updates available), no branch is created.

## Benefits

✅ **Always have a tested configuration** - CI builds before you deploy
✅ **Lightning-fast upgrades** - Everything pre-built and cached
✅ **Safe updates** - Test the branch before merging to main
✅ **Automatic updates** - Set it and forget it
✅ **Rollback friendly** - Old branches stay around if you need to rollback

Enjoy your automated Nix workflow!
