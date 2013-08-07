#!/bin/sh
# Direct command invocation over ssh doesn't set PATH properly. In particular,
# /sbin/ isn't guaranteed to be included until you run through login scripts.
# This means that e.g. `ssh lab219-01 ifconfig` might not find the command.
# Thus, for now at least, we hardcode the path to ifconfig.
prog=/sbin/ifconfig
hostname | tr -d '\n'
# Probe for the availability of ifconfig and/or the permission to execute.
$prog > /dev/null 2>&1
if [ $? == 0 ]; then
	# Output the first ethernet NIC's MAC address.
	printf ' '
	$prog -a | grep '^e' | sed -r 's/.+HWaddr//' | head -n 1 | tr -d '\n'
	# Output the first ethernet NIC's IPv4 address.
	printf ' '
	$prog -a | grep -A 1 '^e' | grep inet | sed -r 's/.+inet addr:/ /' |
		sed -r 's/  Bcast.+//' | head -n 1 | tr -d '\n'
	# Output the current date and time in ISO 8601 format.
	printf ' '
	date -u +%FT%TZ | tr -d '\n'
fi
echo
