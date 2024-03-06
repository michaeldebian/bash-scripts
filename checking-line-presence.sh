#!/usr/bin/env bash

# Define the lines to be inserted
line1="<setting name=\"option1\" value=\"true\" />"
line2="<setting name=\"option2\" value=\"false\" />"
line3="<setting name=\"option3\" value=\"true\" />"

# Define the file path of the XML file
xml_file="path/to/your/xml/file.xml"

# Check if the lines are already present in the XML file
if grep -q "port 8900" "$xml_file"; then
    # Check if the lines to be inserted are already present
    if grep -Fxq "$line1" "$xml_file" && grep -Fxq "$line2" "$xml_file" && grep -Fxq "$line3" "$xml_file"; then
        echo "Lines are already present in the XML file."
    else
        # Insert the lines after the occurrence of "port 8900"
        sed -i "/port 8900/a $line1\n$line2\n$line3" "$xml_file"
        echo "Lines inserted successfully."
    fi
else
    echo "The pattern 'port 8900' not found in the XML file."
fi

