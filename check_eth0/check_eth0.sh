#!/usr/bin/env bash

# This is a cron script that checks if it is connected to the Internet by
# pinging an address. If it detect that it is disconnected, it will restart
# the dhcpcd service.

ping -q -w 10 -c 1 8.8.8.8 > /dev/null 2>&1

# $? is the exit status
if [ $? -ne 0 ]; then
    echo "$(date): Offline"
    systemctl restart dhcpcd.service
fi

