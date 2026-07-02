#!/bin/bash

VAULT_DIR="/home/mate/Documents/60_ttrpg/61_active-campaigns/strahdowdark/public_quartz/"
QUARTZ_DIR="/home/mate/Git/strahdowdark/content/"

mkdir -p "$QUARTZ_DIR"

# 1. Move into the Quartz directory so Git knows what to do
cd "$QUARTZ_ROOT" || { echo "Failed to find Quartz directory."; exit 1; }

echo "1. Pulling latest changes from GitHub..."
git pull origin main --rebase

echo "2. Syncing collaborator changes back to Obsidian Vault..."
# Added -u! Only copies files from Quartz to Vault if they are NEWER.
rsync -avu "$QUARTZ_DIR" "$VAULT_DIR"

echo "3. Syncing your local changes to Quartz..."
# Added -u! Only copies files from Vault to Quartz if they are NEWER.
rsync -avu --delete "$VAULT_DIR" "$QUARTZ_DIR"

echo "4. Pushing to GitHub..."
git add -A
git commit -m "Obsidian vault sync" || echo "No changes to commit."
git push origin main

echo "Sync complete!"
