#!/bin/sh
for i in "$@"; do
	ssh -o StrictHostKeyChecking=no "$i" 'sh -s' < ./mac.sh
done
