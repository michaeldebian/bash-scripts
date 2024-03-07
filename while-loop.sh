#!/usr/bin/env bash

DRIVE=""

while true; do
    if [ -e /dev/drive ]; then
        echo "/dev/drive found!"
        read -p "Press Enter when ready to proceed..."
        # Do something with /dev/drive here
        break  # Break out of the loop once /dev/drive is found
    else
        echo "Waiting for /dev/drive..."
        sleep 1  # Wait for 1 second before checking again
    fi
done
