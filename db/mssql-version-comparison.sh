#!/usr/bin/env bash

# Assign values to RHEL_VERSION and MSSQL_VERSION (replace these with actual values)
RHEL_VERSION=8
MSSQL_VERSION=2019

# Compare the versions
if [ "$RHEL_VERSION" -eq "$MSSQL_VERSION" ]; then
    echo "RHEL version $RHEL_VERSION is equal to MSSQL version $MSSQL_VERSION"
elif [ "$RHEL_VERSION" -gt "$MSSQL_VERSION" ]; then
    echo "RHEL version $RHEL_VERSION is greater than MSSQL version $MSSQL_VERSION"
else
    echo "RHEL version $RHEL_VERSION is less than MSSQL version $MSSQL_VERSION"
fi