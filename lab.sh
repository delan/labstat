#!/bin/sh
lab=$1
last=$2
for i in `seq $last`; do
	host=`printf '%02d' $i`
	ssh -o StrictHostKeyChecking=no lab$lab-$host ./mac.sh
done
