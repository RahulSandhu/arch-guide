#!/bin/bash

# Define the target directory based on your request
TARGET_DIR="${HOME}/desktop/arch-guide/src/"

# Create the directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Save Native (Arch Repo) packages that were explicitly installed
pacman -Qenq > "$TARGET_DIR/native-pkgs.txt"

# Save Foreign (AUR/Local) packages that were explicitly installed
pacman -Qmeq > "$TARGET_DIR/foreign-pkgs.txt"

# Send notification 
/usr/bin/notify-send "System" "Packages updated in $TARGET_DIR" --icon=system-run
