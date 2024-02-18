#!/bin/bash

> /dev/shm/list_images.tmp


for node in $(ls nodes);
do
  for image in $(ls nodes/$node);
  do
    filename="nodes/$node/$image"

    size=$(cat $filename | jq -r '. | .status.size')
    MB=$(echo "scale=20;$size / 1000000" | bc)
    rounded=$(printf '%.0f' $MB)

    created=$(cat $filename | jq -r '. | .info.imageSpec.created')
    date_created=$(echo $created | xargs date '+%Y-%m-%dT%H:%M:%S' -d)

    echo -e "$node\t$image\t$rounded MB\t$date_created" >> /dev/shm/list_images.tmp

  done

done

sort -t$'\t' -k1,1 -k4,4r /dev/shm/list_images.tmp
rm -f /dev/shm/list_images.tmp
