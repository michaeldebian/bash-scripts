#!/usr/bin/env bash

# Assuming variables.txt is the file where these variables are stored
while [ "$RHEL_VERSION" -ne "$MSSQL_VERSION" ]; do
    echo "Values do not match. Waiting for correction..."
    sleep 3

echo "Values corrected. Continuing with the script..."