#!/bin/bash

# Variable to hold the PID of the Hiddify process
HIDDIFY_PID=

# File to store the current configuration
CURRENT_CONFIG_FILE="/tmp/hiddify_current.conf"
# File to store the new configuration for comparison
NEW_CONFIG_FILE="/tmp/hiddify_new.conf"

# Function for gracefully shutting down the application when the container stops
cleanup() {
    echo "Shutting down..."
    if [ ! -z "$HIDDIFY_PID" ]; then
        kill "$HIDDIFY_PID"
        wait "$HIDDIFY_PID" 2>/dev/null
    fi
    rm -f "$CURRENT_CONFIG_FILE" "$NEW_CONFIG_FILE"
    exit 0
}

trap cleanup SIGTERM SIGINT

# --- Subscription Link Settings ---
DEFAULT_SUB="http://router.freehost.io/github/mix.txt"
BACKUP_SUBS=(
    "https://raw.githubusercontent.com/PacketCipher/TVC/refs/heads/main/subscriptions/xray/normal/mix"
    "https://raw.githubusercontent.com/tvccccc/TVCCCC/refs/heads/main/subscriptions/xray/normal/mix"
    # "https://example.com/your-new-link.txt" # Add your new link here in the future
)

# --- Function to find and download a working subscription link ---
get_working_sub() {
    # First, try the default link
    if curl --silent --fail --max-time 15 "$DEFAULT_SUB" -o "$1"; then
        echo "Successfully downloaded default subscription."
        return 0
    fi

    # If it fails, try the backup links
    echo "Default link failed. Trying backups..."
    for sub in "${BACKUP_SUBS[@]}"; do
        if curl --silent --fail --max-time 15 "$sub" -o "$1"; then
            echo "Successfully downloaded backup subscription: $sub"
            return 0
        fi
    done

    echo "Error: All subscription links are inaccessible." >&2
    return 1
}

# --- Main Application Loop ---
while true; do
    echo "Fetching latest subscription..."
    if ! get_working_sub "$NEW_CONFIG_FILE"; then
        echo "Could not fetch any subscription. Retrying in 10 minutes."
        sleep 10m
        continue
    fi

    # Check if Hiddify is running and if the new config differs from the old one
    if [ -f "$CURRENT_CONFIG_FILE" ] && cmp -s "$CURRENT_CONFIG_FILE" "$NEW_CONFIG_FILE"; then
        echo "Subscription content has not changed. No restart needed."
    else
        echo "New subscription content detected or first run. Restarting HiddifyCli."
        
        # If the previous process is running, stop it
        if [ ! -z "$HIDDIFY_PID" ]; then
            echo "Stopping old HiddifyCli process (PID: $HIDDIFY_PID)..."
            kill "$HIDDIFY_PID"
            wait "$HIDDIFY_PID" 2>/dev/null
        fi

        # Copy the new config as the current config
        cp "$NEW_CONFIG_FILE" "$CURRENT_CONFIG_FILE"

        # Run Hiddify with the local config file
        echo "Starting HiddifyCli with the updated local config file..."
        ./HiddifyCli run -c "$CURRENT_CONFIG_FILE" &
        HIDDIFY_PID=$!
        echo "HiddifyCli started with new PID: $HIDDIFY_PID"
    fi
    
    # Wait for 12 hours and then repeat the loop
    echo "Next check in 12 hours..."
    sleep 12h
done