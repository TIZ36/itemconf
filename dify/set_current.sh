#!/bin/bash

CURRENT_VER=${1:-1.0.0}

echo "Set current Dify version: $CURRENT_VER"

# if current and current_dify ln is exists, remove it and link to new version
if [ -L "current" ]; then
  rm current
fi

if [ -L "current_dify" ]; then
  rm current_dify
fi

# if dify-VER not exists, err and just return
if [ ! -d "dify-$CURRENT_VER" ]; then
  echo "Dify version $CURRENT_VER not exists"
  exit 1
fi

ln -s dify-$CURRENT_VER current
ln -s dify-$CURRENT_VER/docker current_dify
