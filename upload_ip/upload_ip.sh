#!/usr/bin/env bash

# This is a cron script that uploads the public IP address of the host to
# Dropbox.
#
# DEPENDENCIES:
#   - https://github.com/andreafabrizi/Dropbox-Uploader

set -euo pipefail

# Only run script we can connect to IP service
ping -q -w 10 -c 1 v4.ifconfig.co > /dev/null 2>&1
if [ $? -ne 0 ]; then
    exit 1
fi

HISTORY_FILE="$(dirname $(readlink -f $0))/history.txt"
CURRENT_IP_FILE="$(dirname $(readlink -f $0))/current_ip.txt"

if [ ! -f $CURRENT_IP_FILE ]; then
    touch $CURRENT_IP_FILE
fi

MY_IP=$(curl -s v4.ifconfig.co)
LAST_IP=$(<$CURRENT_IP_FILE)

echo "My IP is: $MY_IP"
if [ "$MY_IP" != "$LAST_IP" ]; then
    echo "IP changed"
    echo "$(date): IP changed to $MY_IP" >> $HISTORY_FILE
    echo "$MY_IP" > $CURRENT_IP_FILE
    if type "$HOME/bin/dropbox_uploader.sh" > /dev/null; then
        echo "Uploading files to dropbox"
        "$HOME/bin/dropbox_uploader.sh" upload $CURRENT_IP_FILE .
        "$HOME/bin/dropbox_uploader.sh" upload $HISTORY_FILE .
    fi
else
    echo "IP did not change"
fi
