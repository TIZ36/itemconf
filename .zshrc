# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/lilithgame/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lambda"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias k9s-tva-qa="k9s --kubeconfig=$HOME/.kube/config-tva-qa"
alias k9s-tsh-qa="k9s --kubeconfig=$HOME/.kube/config-tsh-qa"
alias k9s-tsh-prod="k9s --kubeconfig=$HOME/.kube/config-tsh-prod"
alias k9s-tva-prod="k9s --kubeconfig=$HOME/.kube/config-tva-prod"
alias k9s-tsg-prod="k9s --kubeconfig=$HOME/.kube/config-tsg-prod"
alias k9s-yangzhou-gpu="k9s --kubeconfig=$HOME/.kube/config"

alias kubectlm="minikube kubectl --"


# 便捷启动
alias code_zsh="cd ~/ && code ~/.zshrc"
alias code_dev="cd /Users/lilithgame/schuck/workspace/dev_dir/main_workline/im-erlang && code ."
alias code_fix="cd  /Users/lilithgame/schuck/workspace/fix_dir/im-erlang && code ."
alias code_immt="cd  /Users/lilithgame/schuck/workspace/immt && code ."
alias code_nds="cd  /Users/lilithgame/schuck/workspace/nds && code ."


#im-erlang
alias code_release54="cd /Users/lilithgame/schuck/workspace/dev/release_54/im-erlang && git pull && code ."
alias code_release56="cd /Users/lilithgame/schuck/workspace/dev/release_56/im-erlang && git pull && code ."


alias docker_run_im_local_redis="docker run --name myredis -p 6379:6379 -v /Users/lilithgame/schuck/workspace/im_local/redis/data:/data -v /Users/lilithgame/schuck/workspace/im_local/redis/conf/redis.conf:/etc/redis/redis.conf -d redis redis-server /etc/redis/redis.conf"
alias start_node_center="sh  ~/schuck/workspace/node_center/start.sh"
export PATH="$HOME:$PATH"

# 设置java home
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

export PATH="/opt/homebrew/Cellar/libuv:$PATH"
export LIBUV_ROOT_DIR="/opt/homebrew/Cellar/libuv/1.44.1"
# 设置使用python3.9
alias python=python3.11
# set adb
export PATH="$HOME/dev_tools/platform_tools:$PATH"

# 注意替换成自己的堡垒机用户名(确保用户名正确)
export IM_AUTO_USER=zhangtian
# 跳板机选择:
# old: 表示使用旧版跳板机(旧版连接数有上限，比较稳定)
# new: 表示使用新版跳板机(新版连接数无上限，略卡)
# v3: 最新10.1.4.14（推荐)
export IM_JUMPER_VERSION=v3
# 引用对应的登陆文件，文件可以放在任意位置
source ~/to_im_env/login_server
source ~/.ssh

alias codei="/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code"
alias code="//Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias idea="/Users/lilithgame/Applications/JetBrains\ Toolbox/IntelliJ\ IDEA\ Ultimate.app/Contents/MacOS/jetbrains-toolbox-launcher"


function reload_zsh() {
    source ~/.zshrc
}

function mysql_start() {
    mysql.server start
}
function mysql_stop() {
    mysql.server stop
}

function start_cassandra() {
    /opt/homebrew/opt/cassandra/bin/cassandra -f
}

function new_elixir_proj {
    cd ~/schuck/learning/elixir && mix new $1 && cd $1 && code .
}

function conf {
    result=$(curl https://conf.lilithgame.com/api/im/env\?access_type\=$1) && echo $result | jq .
}
function confmd5 {
    result=$(curl https://conf.lilithgame.com/api/im/env\?env_id\=$1) && echo $result | jq .
}

export CARGO_NET_GIT_FETCH_WITH_CLI=true
source /Users/lilithgame/.cargo/env
export PATH='/usr/local/go/bin:/Users/lilithgame/dev_tools/platform_tools:/opt/homebrew/Cellar/libuv:/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/bin:/Users/lilithgame:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/lilithgame/.cargo/bin'

# set erlang
source /Users/lilithgame/erlang/25.0/activate
source $HOME/.kiex/elixirs/elixir-1.15.2.env
# config go path
# export GOROOT=$HOME/go
# export GOPATH=$HOME/gopath
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export GOROOT=/usr/local/go
export GOPATH=$HOME/go/deps
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


export PATH=$PATH:~/Downloads/cmd_tool
export PATH="$PATH:/Users/lilithgame/go/deps/bin"

go env -w GO111MODULE="on"
go env -w GOPROXY=https://goproxy.cn
go env -w GOPRIVATE=gitlab.lilithgame.com


export IM_ERLANG_HOME=/Users/lilithgame/schuck/workspace/dev/im-erlang
function codeim {
    code $IM_ERLANG_HOME
}

export HOTDOG_HOME=/Users/lilithgame/schuck/workspace/hotdog
function code_hotdog {
    code $HOTDOG_HOME
}
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export SECRET_WEB_ENV=prod

alias pip=pip3.9

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lilithgame/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lilithgame/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lilithgame/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lilithgame/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
