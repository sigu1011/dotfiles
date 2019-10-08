# zprof によるプロファイリング結果が出力
# zmodload zsh/zprof && zprof

# LANG
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=jp_JP.UTF-8
export LANG=ja_JP.UTF-8

#####################################################################
# export
#####################################################################

# TERM
# export TERM=xterm-256color

# .local
export PATH=$PATH:~/.local/bin

# java
export JAVA_VERSION=jdk-10.0.1
export JAVA_HOME=/usr/local/$JAVA_VERSION
export PATH=$PATH:$JAVA_HOME/bin

# golang
export PATH=$PATH:/usr/local/go/bin
# GOPATH
export GOPATH=$HOME/goprojects
export PATH=$PATH:$GOPATH/bin

# Ruby
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

# Neovim
export XDG_CONGIG_HOME=~/.config

# ls cmd color
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

#####################################################################
# editor
#####################################################################

# defaut editor is vim
export EDITOR=vim
# when not exist vim then start up vi
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi


#####################################################################
# alias
#####################################################################

# global alias
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'

# cp,rm,mkdir add '-i' or '-p'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# ls alias
alias l='ls -ltr --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias lst='ls -ltr --color=auto'

# source
alias so='source'
# source zsh
alias sourcez="source ~/.zshrc"

# history
alias h='fc -lt '%F %T' 1'

# xsel alias
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# nvim alias
alias vi='vim'
alias vim='nvim'

# git status
alias gs="git status"

# git diff
alias gd="git diff"
alias gdc="git diff --cached "

# git add
alias ga="git add "
alias gap="git add -p "

# git commit
alias gc="git commit"
alias gcm="git commit -m"

# git log
alias gl="git log"
alias glogn="git log --oneline --graph -n10"

# Django manage.py
#alias djrun="python manage.py runserver"
#alias djshell="python manage.py shell"

export NVM_DIR="$HOME/.nvm"
source $NVM_DIR/nvm.sh
