#!/bin/sh
lab=$1
last=$2
for i in `seq $last`; do
	host="lab$lab-`printf '%02d' $i`"
	./remote.sh "$host"
done
