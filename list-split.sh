#!/usr/bin/env bash

file="requirements.txt"
line_number=1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: $file not found."
    exit 1
fi

# Loop through the file and list items with numbers
while IFS= read -r item; do
    echo "$line_number) $item"
    ((line_number++))
done < "$file"

