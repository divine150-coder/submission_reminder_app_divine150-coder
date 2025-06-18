#!/bin/bash
echo "Enter a new assignment"
read -r new_assignment

CONFIG_FILE=$(echo submission_reminder_*/config/config.env)
sed -i 's/^ASSIGNMENT=.*/ASSIGNMENT="'"$new_assignment"'"/' "$CONFIG_FILE"

echo "Starting submission reminder app..."
bash submission_reminder_*/startup.sh

