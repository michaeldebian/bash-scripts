#!/usr/bin/env bash

#!/bin/bash

# Define the Apache configuration file and SSL configuration file
apache_conf_file="/etc/apache2/apache2.conf"  # Change this path as per your Apache configuration file
ssl_conf_file="/etc/ssl/ssl.conf"

# Define the replacement strings for ErrorDocument and TraceEnable
error_500="ErrorDocument 500 \"ooops there was a problem with this page\""
error_404="ErrorDocument 404 \"The page you are looking for is not here\""
error_401="ErrorDocument 401 \"you do not have permission to view this page\""
trace_enable="TraceEnable off"

# Define the lines to be added to the Apache configuration file
lines_to_add=(
    "# Line 1: Example line 1"
    "# Line 2: Example line 2"
    "# Line 3: Example line 3"
    "# Line 4: Example line 4"
    "# Line 5: Example line 5"
    "# Line 6: Example line 6"
)

# Replace ErrorDocument lines
sed -i -e "s|^ErrorDocument 500.*|$error_500|" \
       -e "s|^ErrorDocument 404.*|$error_404|" \
       -e "s|^ErrorDocument 401.*|$error_401|" \
       "$apache_conf_file"

# Check if TraceEnable is on, and replace with off if necessary
trace_status=$(grep -c "^TraceEnable on" "$apache_conf_file")
if [ $trace_status -gt 0 ]; then
    sed -i -e "s|^TraceEnable on.*|$trace_enable|" "$apache_conf_file"
fi

# Check if lines already exist in the Apache configuration file and echo if not
for line in "${lines_to_add[@]}"; do
    grep -qF "$line" "$apache_conf_file" || echo "$line" >> "$apache_conf_file"
done

# Check if a string containing max-age=63072000 is present in SSL configuration file
if ! grep -q "max-age=63072000" "$ssl_conf_file"; then
    echo "Header always set Strict-Transport-Security \"max-age=63072000\"" >> "$ssl_conf_file"
fi

# Output success message
echo "Replacement and addition completed successfully."
