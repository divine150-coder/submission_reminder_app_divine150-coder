#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Start the reminder application
echo "Starting submission reminder app..."
"$SCRIPT_DIR/app/reminder.sh"
