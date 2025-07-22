#!/bin/bash

# Management script for the services

# Function to display usage
usage() {
    echo "Usage: $0 {build|up|down}"
    exit 1
}

# Check for the correct number of arguments
if [ "$#" -ne 1 ]; then
    usage
fi

# Get the command
COMMAND=$1

# Execute the command
case "$COMMAND" in
    build)
        echo "Building the services..."
        sudo docker compose build
        ;;
    up)
        echo "Bringing up the services..."
        sudo docker compose up -d
        ;;
    down)
        echo "Taking down the services..."
        sudo docker compose down
        ;;
    *)
        usage
        ;;
esac

exit 0
