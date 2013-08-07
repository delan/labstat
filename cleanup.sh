#!/bin/sh
file="$1"
cat "$file" |
	sort -k 2,2 -k 4r,4 |	# ORDER BY hostname ASC, datetime DESC
	sort -u -k 2,2		# collapse consecutive same hostname into first
