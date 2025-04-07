### 使用方法
> 工作目录默认为执行update的当前目录, 使用帮助 可以执行 ./update.sh -h

## 安装新部署
./update.sh -n 1.0.0                   # New deployment with version 1.0.0

## 更新部署
./update.sh -o 0.10.2 -n 1.0.0         # Update from 0.10.2 to 1.0.0

## 指定工作目录
./update.sh -d ~/dify -o 0.10.2 -n 1.0.0  # Update with specific directory

