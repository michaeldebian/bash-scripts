#!/usr/bin/env bash

read -p "Do you need to install Microsoft drivers for MSSQL? (y/n): " response

case "$response" in
    [yY][eE][sS]|[yY])
        echo "Installing Microsoft drivers for MSSQL..."
        ./db/mssql-install.sh
        ;;
    *)
        echo "No action taken. Exiting."
        ;;
esac