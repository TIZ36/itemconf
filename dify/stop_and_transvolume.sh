#!/bin/bash

VER1=${1:-0.10.2}
VER2=${2:-0.11.0}

./stop.sh  ## cd current/docker && sudo docker compose -f docker-compose.yaml down

V1=dify-$VER1
V2=dify-$VER2

# cp   $V1/docker/*.sh  $V2/docker/  ## 一些启停脚本

## 以前版本的数据信息，务必拷贝，不然就是一个全新的环境了
sudo cp -rf $V1/docker/volumes/* $V2/docker/volumes/  