#!/usr/bin/env bash
#
# This is a cron script that checks if it is connected to the Internet by
# pinging an address. If it detect that it is disconnected, it will restart
# the dhcpcd service.
#
# Example crontab entry:
# * * * * * /home/pi/cron/check_eth0.sh >> /var/log/cron/check_eth0.log 2>&1

ping -q -w 10 -c 1 8.8.8.8 > /dev/null 2>&1

# $? is the exit status
if [ $? -ne 0 ]; then
    echo "$(date): Offline"
    systemctl restart dhcpcd.service
fi
