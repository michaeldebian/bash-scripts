#!/usr/bin/env bash

file="list.txt"
line_number=1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: $file not found."
    exit 1
fi

# Calculate the number of lines in the file
num_lines=$(wc -l < "$file")

# Calculate the number of lines per column
lines_per_column=$(( (num_lines + 1) / 2 ))

# Loop through the file and list items with numbers
while IFS= read -r item; do
    printf "%-5s %s\n" "$line_number)" "$item"
    
    # Check if we need to move to the next column
    if (( line_number == lines_per_column )); then
        echo "--------------------------------------"
    fi
    
    ((line_number++))
done < "$file"

