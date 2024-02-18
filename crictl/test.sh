#!/bin/bash

size=580778291
MB=$(echo "scale=20;$size / 1000000" | bc)
#MB=$(echo "$size / 1000000" | bc)

echo "MB: $MB"

rounded1=$(perl -e "use POSIX; printf '%.0f', $MB")
rounded2=$(perl -e "use POSIX; printf '%d', ceil($MB)")
#rounded3=$(perl -e "use POSIX; use Math::Round qw(...all); printf '%d', round($MB)")

echo "rounded1: $rounded1 MB"
echo "rounded2: $rounded2 MB"
#echo "rounded3: $rounded3 MB"






rounded4=$(python3 -c "print(round($MB))")
echo "rounded4: $rounded4 MB"


# Using bashs' builtin printf here
printf '%.0f MB' $MB


rounded5=$(python3 -c "from math import ceil; print(ceil($MB))")
echo "rounded5: $rounded5"


created="2024-02-17T11:53:12.681712812Z"
date_created=$(echo $created | xargs date '+%Y-%m-%dT%H:%M:%S' -d)
echo "date_created: $date_created"




