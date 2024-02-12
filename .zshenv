# zprof によるプロファイリング結果が出力
#zmodload zsh/zprof && zprof

# LANG
# export LANGUAGE=ja_JP.UTF-8
# export LC_ALL=ja_JP.UTF-8
# export LC_CTYPE=ja_JP.UTF-8
# export LANG=ja_JP.UTF-8

#--------#
# export #
#--------#

# snap
export PATH=$PATH:/snap/bin

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# pipx for awsume
export PATH="$PATH:$HOME/.local/bin"

# AWSume alias to source the AWSume script
alias awsume="source \$(pyenv which awsume)"

# Auto-Complete function for AWSume
fpath=(~/.awsume/zsh-autocomplete/ $fpath)

# TERM
export TERM=xterm-256color

# golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/goprojects
export PATH=$PATH:$GOPATH/bin

# cargo
#. "$HOME/.cargo/env"

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

#-------#
# alias #
#-------#

# global alias
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'

# cp, rm, mkdir add '-i' or '-p'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# vim
alias vi='vim'

# ls alias
case "${OSTYPE}" in
darwin*)
  # Mac
  alias l='ls -lGtr'
  alias la='ls -lGa'
  alias ll='ls -lG'
  alias lst='ls -lGtr'
  ;;
linux*)
  # Linux
  alias l='ls -ltr --color=auto'
  alias la='ls -la --color=auto'
  alias ll='ls -l --color=auto'
  alias lst='ls -ltr --color=auto'
  ;;
esac

# source
alias so='source'

# source zsh
alias sourcez="source ~/.zshrc"

# history
alias h='fc -lt '%F %T' 1'

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

# echo PATH
alias path='echo $PATH'

# xsel
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

#----------#
# function #
#----------#

# make and change directory
mkcd() {
  mkdir $1;
  cd $1;
}

# check process status
cps () {
    ps aux | grep -E "PID|$1" | grep -v grep
}

# copy to clipboard
clip() {
  if [[ -n "$1" ]]; then
    cat "$1" | pbcopy
  else
    pbcopy
  fi
}

# ctrl+rで過去のコマンドを選択する
peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ctrl+fで移動したディレクトリを選択する
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi

peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^f' peco-cdr

# pecoでコンテナを選択し、bashで接続する
alias deb='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

