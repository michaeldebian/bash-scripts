#!/bin/bash

# Function to check command existence
check_command_existence() {
    command="$1"
    if ! command -v "$command" &> /dev/null; then
        echo "Error: $command is not installed."
        return 1
    fi
}

# Function to check if all required software are installed
check_all_installed() {
    check_command_existence "wkhtmltopdf" &&
    check_command_existence "gs" &&
    check_command_existence "convert"
}

# Prompt user to install missing software and wait until installed
while ! check_all_installed; do
    echo "Please install the following software: wkhtmltopdf, Ghostscript, and ImageMagick."
    read -p "Press Enter to continue after installing, or 'q' to quit: " choice
    if [ "$choice" = "q" ]; then
        echo "Exiting the script."
        exit 1
    fi
done

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
