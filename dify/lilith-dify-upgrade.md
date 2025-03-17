
0. 登陆到云服务器
```sh

```

1. 下载最新的版本
```sh
cd ~/dify

VER=1.0.0
wget https://github.com/langgenius/dify/archive/refs/tags/$VER.tar.gz

tar xf $VER.tar.gz

cd dify-$VER/docker
cp .env.example  .env
```