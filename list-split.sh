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

# Initialize column counter
column=1

# Loop through the file and list items in two columns
while IFS= read -r item; do
    if [ "$column" -eq 1 ]; then
        printf "%-5s %-25s" "$line_number)" "$item"
        column=2
    else
        printf "%-5s %-25s\n" "$line_number)" "$item"
        column=1
        ((line_number++))
    fi
done < "$file"

# If the number of lines is odd, add a newline at the end
if [ $((num_lines % 2)) -eq 1 ]; then
    echo ""
fi