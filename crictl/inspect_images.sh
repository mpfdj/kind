#!/bin/bash

image_name="helloworld-api"

rm -rf nodes

nodes=$(kubectl.exe get nodes | awk '{ print $1 }' | grep -v "NAME")

for node in $nodes;
do
  mkdir -p nodes/$node

  images=$(docker exec -it $node crictl images | sort | grep -e import -e $image_name | awk '{ print $3 }')

  for image in $images;
  do
    echo "Inspecting image: $image"
    docker exec -it $node crictl inspecti $image > nodes/$node/$image
  done

done



#images=$(docker exec -it my-k8s-cluster-control-plane crictl images | sort | grep -e import -e helloworld-api | awk '{ print $3 }')
#
#for image in $images;
#do
#  echo "Inspecting image: $image"
##  docker exec -it my-k8s-cluster-control-plane crictl inspecti $image > inspecti/$image
#done

