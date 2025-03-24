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

## 使用自动化脚本更新 Dify

可以使用 `update.sh` 脚本自动完成更新流程：

```sh
# 使用示例（从0.10.2版本更新到1.0.0版本）
./update.sh -o 0.10.2 -n 1.0.0

# 指定工作目录
./update.sh -d ~/dify -o 0.10.2 -n 1.0.0

# 新部署（不指定旧版本）
./update.sh -n 1.0.0

# 查看帮助信息
./update.sh --help
```

此脚本将自动执行以下步骤：
1. 下载新版本
2. 拉取新版本所需的 Docker 镜像
3. 如果是更新而非新部署：停止当前运行的 Dify 实例并迁移数据卷
4. 设置新版本为当前版本
5. 启动新版本的 Dify 实例（新部署时会询问是否立即启动）