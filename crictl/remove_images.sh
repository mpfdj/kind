#!/bin/bash

for node in $(ls nodes);
do
  for image in $(ls nodes/$node);
  do
    echo "Removing image $node $image"
    docker exec -it $node crictl rmi $image
  done
done