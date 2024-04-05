#!/bin/bash

# Define the path to logind.conf
LOGIND_CONF="/etc/systemd/logind.conf"

# Check if the file exists
if [ ! -f "$LOGIND_CONF" ]; then
    echo "logind.conf file not found!"
    exit 1
fi

# Function to toggle settings
toggle_settings() {
    if grep -q 'HandleLidSwitch=suspend' "$LOGIND_CONF"; then
        sed -i -E 's/^(HandleLidSwitch=)(.*)/HandleLidSwitch=lock/' "$LOGIND_CONF"
    elif grep -q 'HandleLidSwitch=lock' "$LOGIND_CONF"; then
        sed -i -E 's/^(HandleLidSwitch=)(.*)/HandleLidSwitch=suspend/' "$LOGIND_CONF"
    fi

    if grep -q 'HandleLidSwitchExternalPower=suspend' "$LOGIND_CONF"; then
        sed -i -E 's/^(HandleLidSwitchExternalPower=)(.*)/HandleLidSwitchExternalPower=lock/' "$LOGIND_CONF"
    elif grep -q 'HandleLidSwitchExternalPower=lock' "$LOGIND_CONF"; then
        sed -i -E 's/^(HandleLidSwitchExternalPower=)(.*)/HandleLidSwitchExternalPower=suspend/' "$LOGIND_CONF"
    fi
}

# Toggle settings
toggle_settings

# Verify changes
echo "logind.conf Updated Successfully!"
# cat "$LOGIND_CONF"
