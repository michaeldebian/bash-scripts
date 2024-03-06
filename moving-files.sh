#!/usr/bin/env bash

# Source directories
source_dirs=(
    "/path/to/source_directory1"
    "/path/to/source_directory2"
    "/path/to/source_directory3"
    "/path/to/source_directory4"
    "/path/to/source_directory5"
)

# Target directories
target_dirs=(
    "/path/to/target_directory1"
    "/path/to/target_directory2"
    "/path/to/target_directory3"
    "/path/to/target_directory4"
    "/path/to/target_directory5"
)

# Iterate over each source and target directory pair
for ((i=0; i<${#source_dirs[@]}; i++)); do
    source_dir="${source_dirs[$i]}"
    target_dir="${target_dirs[$i]}"
    
    # Check if source directory exists
    if [ ! -d "$source_dir" ]; then
        echo "Source directory '$source_dir' does not exist."
        continue
    fi

    # Check if target directory exists, if not, create it
    if [ ! -d "$target_dir" ]; then
        echo "Target directory '$target_dir' does not exist. Creating..."
        mkdir -p "$target_dir"
        echo "Target directory '$target_dir' created."
    fi

    # Move files from source directory to target directory
    echo "Moving files from '$source_dir' to '$target_dir'..."
    for file in "$source_dir"/*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            target_file="$target_dir/$filename"
            if [ -f "$target_file" ]; then
                # If target file already exists, create backup with timestamp
                timestamp=$(date +%m%d%Y)
                backup_file="$target_dir/${filename}.${timestamp}"
                echo "Backing up existing file '$target_file' to '$backup_file'..."
                mv "$target_file" "$backup_file"
            fi
            echo "Moving file '$filename' to '$target_dir'..."
            mv "$file" "$target_dir"
        fi
    done

    echo "Files moved from '$source_dir' to '$target_dir' successfully."
done