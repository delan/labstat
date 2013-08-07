#!/bin/sh
for i in "$@"; do
	ssh -o StrictHostKeyChecking=no "$i" ./mac.sh
done
