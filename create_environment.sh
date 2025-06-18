#!/bin/bash

read -p "Enter your name: " userName
dir="submission_reminder_$userName"
mkdir -p "$dir"
cd $dir
mkdir -p app modules assets config


cat > config/config.env << 'BOF'
#!/bin/bash
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2

BOF

cat > assets/submissions.txt << 'BOF'
#!/bin/bash
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Gihozo, Shell Basics, submitted
Shakillah, Git, submitted
BOF

cat > app/reminder.sh << 'BOF'
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source environment variables and helper functions
source "$SCRIPT_DIR/../config/config.env"
source "$SCRIPT_DIR/../modules/functions.sh"

# Path to the submissions file
submissions_file="$SCRIPT_DIR/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"

BOF

cat > modules/functions.sh << 'BOF'
#!/bin/bash

function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [ "$assignment" == "$ASSIGNMENT" ] && [ "$status" == 'not submitted' ]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}

BOF


cat > startup.sh << 'BOF'
#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Start the reminder application
echo "Starting submission reminder app..."
"$SCRIPT_DIR/app/reminder.sh"
BOF

find . -name "*.sh" -exec chmod +x {} \;
