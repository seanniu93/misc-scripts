#!/usr/bin/env bash
#
# This is a cron script for use with Pi-Hole (https://github.com/pi-hole/pi-hole)
# which will reconfigure pihole if the IPv6 address (GUA) changes.
#
# Example crontab entry:
# Every hour: check if IPv6 has changed and reconfigure Pi-Hole
# 0 * * * * /home/pi/cron/check_ipv6.sh >> /dev/null 2>&1

NEW_IPV6_ADDRESS=$(ip -6 address | grep 'scope global' | awk -F " " '{gsub("/[0-9]*",""); print $2}')
CUR_IPV6_ADDRESS=$(grep 'IPV6_ADDRESS' /etc/pihole/setupVars.conf| awk -F "=" '{gsub("/[0-9]*",""); print $2}')

echo "New IPv6 Address: ${NEW_IPV6_ADDRESS}"
echo "Cur IPv6 Address: ${CUR_IPV6_ADDRESS}"

if [ "${NEW_IPV6_ADDRESS}" != "${CUR_IPV6_ADDRESS}" ]; then
	echo "IPv6 changed"
	sed -i.setupVars.bak "/IPV6_ADDRESS/d;" "/etc/pihole/setupVars.conf"
	echo "IPV6_ADDRESS=${NEW_IPV6_ADDRESS}" >> "/etc/pihole/setupVars.conf"
	pihole -g
else
	echo "IPv6 did not change"
fi
