#!/usr/bin/env bash

# Assuming variables.txt is the file where these variables are stored
while [ "$RHEL_VERSION" != "correct" ] || [ "$MSSQL_VERSION" != "correct" ]; do
    echo "Values not correct. Waiting for variables.txt to be corrected..."
    sleep 3

    # Re-read the variables from variables.txt
    source variables.txt
done

echo "Values corrected. Continuing with the script..."