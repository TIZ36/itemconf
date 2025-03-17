#!/bin/bash

# get the first argument
# if no argument is provided, use the default value
WOR_DIR=${1:-~/dify}
VER=${2:-1.0.0}

cd $WOR_DIR/dify-$VER/docker

echo "pull dify image from dify-$VER/docker/docker-compose.yaml"

for i in `grep langgenius docker-compose.yaml | awk '{print $2}' | uniq`
do
  echo "docker pull $i"
  sudo docker pull $i
done
cd -