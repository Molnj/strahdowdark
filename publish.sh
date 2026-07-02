#!/bin/bash

VAULT_DIR="/home/mate/Documents/60_ttrpg/61_active-campaigns/strahdowdark/public_quartz/"
QUARTZ_DIR="./content/"

mkdir -p "$QUARTZ_DIR"

echo "1. Pulling latest changes from GitHub..."
git pull origin main --rebase

echo "2. Syncing collaborator changes back to Obsidian Vault..."
# We do this FIRST so we don't accidentally overwrite their new stuff.
# We don't use --delete here, so we don't accidentally delete your local drafts.
rsync -av "$QUARTZ_DIR" "$VAULT_DIR"

echo "3. Syncing your local changes to Quartz..."
# Now we sync your Vault into Quartz. 
# --delete ensures if you deleted a file in Obsidian, it deletes in Quartz.
rsync -av --delete "$VAULT_DIR" "$QUARTZ_DIR"

echo "4. Pushing to GitHub..."
git add -A
git commit -m "Obsidian vault sync" || echo "No changes to commit."
git push origin main

echo "Sync complete!"
