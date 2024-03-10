#!/usr/bin/env bash

# Define paths
conf_file="/etc/httpd/conf.d/jk_rewrite"

# Check if jk_rewrite file exists
if [ -f "$conf_file" ]; then
    echo "File jk_rewrite has been found."

    # Backup the file with timestamp
    timestamp=$(date +%Y-%m-%d_%H-%M)
    backup_file="$conf_file_backup_$timestamp"
    cp "$conf_file" "$backup_file"
    echo "File jk_rewrite has been backed up as $backup_file."
else
    echo "File jk_rewrite has not been found."
fi
