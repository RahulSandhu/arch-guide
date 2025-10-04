#!/bin/bash

# Define the target directory based on your request
TARGET_DIR="${HOME}/desktop/arch-guide/src/"

# Create the directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Save Native (Arch Repo) packages that were explicitly installed
pacman -Qenq > "$TARGET_DIR/native-pkgs.txt"

# Save Foreign (AUR/Local) packages that were explicitly installed
pacman -Qmeq > "$TARGET_DIR/foreign-pkgs.txt"

# Git push changes
git add . > /dev/null 2>&1
COMMIT_MESSAGE="updated at $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MESSAGE" > /dev/null 2>&1
git push > /dev/null 2>&1
