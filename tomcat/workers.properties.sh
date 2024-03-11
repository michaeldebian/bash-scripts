#!/usr/bin/env bash

# Define paths
conf_dir="/etc/httpd/conf.d"
workers_file="$conf_dir/workers.properties"
backup_dir="/etc/httpd/conf.d/backup"

# Check if workers.properties file exists
if [ -e "$workers_file" ]; then
    echo "File workers.properties has been found."

    # Create backup directory if it doesn't exist
    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    # Backup the old file with today's date
    backup_file="$backup_dir/workers_$(date +%Y-%m-%d_%H-%M).properties"
    cp "$workers_file" "$backup_file"

    # Copy the new file over
    cp "workers.properties" "$workers_file"
    echo "File workers.properties has been updated."
else
    # Copy the new file over
    cp "workers.properties" "$workers_file"
    echo "File workers.properties has been copied."
fi
