#!/bin/bash

echo "Enter a new assignment:"
read -r new_assignment

TARGET_DIR=$(ls -d submission_reminder_* | tail -n1)
CONFIG_FILE="$TARGET_DIR/config/config.env"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: Cannot find config.env in $TARGET_DIR"; exit 1
fi

sed -i 's/^ASSIGNMENT=.*/ASSIGNMENT="'"$new_assignment"'"/' "$CONFIG_FILE"

echo "Starting submission reminder app..."
bash "$TARGET_DIR/startup.sh"

