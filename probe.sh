#!/bin/sh
f=$(mktemp)
touch "$f"
echo 'Looking for working lab machines. You can hit ^C at any time.'
echo
trap 'break 4' 2
for a in $(  seq  134  134  ); do
for b in $(  seq  7    7    ); do
for c in $(  seq  44   47   ); do
for d in $(  seq  1    254  ); do
	printf '%s' "$a.$b.$c.$d:"
	ping -c 1 -W 1 -w 1 "$a.$b.$c.$d" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		printf '%s' ' ping'
		ssh \
			-o 'ConnectTimeout=1' \
			-o 'ConnectionAttempts=1' \
			-o 'StrictHostKeyChecking no' \
			-o 'PreferredAuthentications=publickey' \
			"$a.$b.$c.$d" true > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			printf '%s' ' ssh'
			echo "$a.$b.$c.$d" >> "$f"
		fi
	else
		printf '%s' ' down'
	fi
	echo
done; done; done; done
echo
echo
echo 'Working nodes found:'
echo
cat "$f"
