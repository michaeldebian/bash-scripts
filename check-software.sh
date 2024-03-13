#!/usr/bin/env bash

# Function to check command existence
check_command_existence() {
    command="$1"
    if ! command -v "$command" &> /dev/null; then
        echo "Error: $command is not installed."
        exit 1
    fi
}

# Check if required software is installed
check_command_existence "wkhtmltopdf"
check_command_existence "gs"
check_command_existence "convert"

# Function to check command output
check_command() {
    command="$1"
    expected_output="$2"
    echo "Checking $command..."
    if eval "$command" | grep -q "$expected_output"; then
        echo "Success: $command output matches '$expected_output'"
    else
        echo "Error: $command output does not match '$expected_output'"
    fi
}

# Check wkhtmltopdf version
check_command "wkhtmltopdf -V" "wkhtmltopdf"

# Check Ghostscript version
check_command "gs -v" "Ghostscript"

# Check ImageMagick version
check_command "convert -version" "ImageMagick"
