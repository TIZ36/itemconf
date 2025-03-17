## 安装erlang和elixir

### MACOS

```shell
## macos 安装kerl
curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod a+x kerl
sudo mv kerl /usr/local/bin
cd ~ && KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-kernel-poll --without-javac  --without-odbc" 
kerl list release # 选一个合适的发布版本
kerl build 24.0.2 # build 一个版本

sudo mkdir -p /opt/erl-26.2.5
sudo kerl install 26.2.5 /opt/erl-26.2.5/
source /opt/erl-26.2.5/activate

## macos 安装kiex
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/kiex | bash -s install_kiex
cd  ~/.kiex/
./bin/kiex list known
./bin/kiex install 1.16.3

source $HOME/.kiex/elixirs/elixir-1.16.3.env

iex -v
```

### Linux(这里记录的是ecs，远程机器，所以有用户切换啥的)

`erlang`
```shell
passwd root
cd /home/im && chmod +x kerl && mv kerl /usr/local/bin

passwd im
cd ~ && KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-kernel-poll --without-javac  --without-odbc" kerl build 24.0.2
su root
mkdir -p /opt/erl-24.0.2

# 这一步挺关键的，如果你是再用户下载，然后又要装到/OPT ，需要这个
chown -R im /opt/erl-24.0.2
exit

cd /home/im/.kerl/builds
/usr/local/bin/kerl install 24.0.2 /opt/erl-24.0.2/

source /opt/erl-24.0.2/activate

#### 多台机器部署  #####
su root
tar czf erl-24.0.2.tar.gz erl-24.0.2/
## 推送刀gitlab hotdog ##

cd ~ && git clone ssh://git@git.boh.com:2222/BaoOnHead/hotdog.git
cd /home/im/hotdog/erlang-24/

passwd root
mkdir -p /opt
cd /home/im/hotdog/erlang-24/ && cp erl-24.0.2.tar.gz /opt 
cd /opt && tar xzf erl-24.0.2.tar.gz
source /opt/erl-24.0.2/activate
```

`elixir`
```shell
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/kiex | bash -s install_kiex
cd  ~/.kiex/ && ./bin/kiex install 1.12.1

source $HOME/.kiex/elixirs/elixir-1.12.1.env


echo source /opt/erl-24.0.2/activate >> ~/.bashrc
echo "source $HOME/.kiex/elixirs/elixir-1.12.1.env" >> ~/.bashrc
iex -v
```