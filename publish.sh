#!/bin/bash

VAULT_DIR="/home/mate/Documents/60_ttrpg/61_active-campaigns/strahdowdark/public_quartz/"
QUARTZ_DIR="./content/"

mkdir -p "$QUARTZ_DIR"

# Mirror files
rsync -av --delete "$VAULT_DIR" "$QUARTZ_DIR"

# Native Git sync (bypasses npx quartz sync bugs)
git add -A
git commit -m "Obsidian vault sync" || echo "No changes to commit."
git pull origin main --rebase
git push origin main
