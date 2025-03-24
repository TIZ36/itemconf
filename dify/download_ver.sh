#!/bin/bash

# get the first argument
# if no argument is provided, use the default value

WOR_DIR=${1:-~/dify}
VER=${2:-1.0.0}

echo "Select Dify version: $VER"
echo "Working directory: $WOR_DIR"
cd $WOR_DIR

# if dir dify-VER exists, just return
if [ -d "dify-$VER" ]; then
  echo "Dify version $VER already exists"
else
  wget https://github.com/langgenius/dify/archive/refs/tags/$VER.tar.gz
  tar xf $VER.tar.gz
fi


# echo and run the command
echo "cd ./dify-$VER/docker && cp .env.example  .env"
cd ./dify-$VER/docker && cp .env.example .env

# cp custom.env to .env
echo "cp env_weuse .env"
cp $WOR_DIR/env $WOR_DIR/dify-$VER/docker/.env