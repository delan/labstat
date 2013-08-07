#!/bin/sh
file="$1"
cat "$file" |
	sort -k 1,1 -k 2r,2 |	# ORDER BY hostname ASC, datetime DESC
	sort -u -k 1,1		# collapse consecutive same hostname into first
