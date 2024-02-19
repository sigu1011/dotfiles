#-------#
# basic #
#-------#

# vimキーバインド
bindkey -v

# ノーマルモードへの移行を'jj'に変更
bindkey -M viins 'jj' vi-cmd-mode

# グロブ展開をしない
setopt nonomatch

export TERM=xterm-256color
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

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
# golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/goprojects
export PATH=$PATH:$GOPATH/bin
# cargo
#. "$HOME/.cargo/env"

# keychain
/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/`hostname`-sh

# anyenv
eval "$(anyenv init -)"

# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

#---------#
# history #
#---------#

# メモリ上に保存される件数(検索できる件数)
HISTSIZE=10000

# ファイルに保存される件数
SAVEHIST=100000

# ヒストリーファイル
HISTFILE=~/.zsh_history

# rootは履歴を残さないようにする
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

# 履歴を複数のシェルで共有する
setopt histignorealldups sharehistory

# 直前と同じコマンドの場合は履歴に追加しない
setopt histignoredups

# 重複するコマンドは古い履歴から削除する
setopt histignorealldups

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
bindkey '^o' peco-cdr

# pecoでコンテナを選択し、bashで接続する
alias deb='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

#--------------#
# autocomplete #
#--------------#

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# コマンドラインの引数でも補完を有効にする
setopt magic_equal_subst

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd

# auto_pushdで重複するディレクトリは記録しない
setopt pushd_ignore_dups

#-------#
# color #
#-------#

autoload colors
colors

# プロンプト
PROMPT="%{${fg[green]}%}%n@%m %{${fg[yellow]}%}%~ %{${fg[red]}%}%# %{${reset_color}%}"
# プロンプト指定(コマンドの続き)
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
# プロンプト指定(訂正機能)
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# vi modeをプロンプトに表示する
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{208}%F{black}<-%k%f%K{208}%F{white} % NORMAL %k%f%K{black}%F{208}->%k%f" 
    VIM_INSERT="%K{075}%F{black}<-%k%f%K{075}%F{white} % INSERT %k%f%K{black}%F{075}->%k%f"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# 補完候補もLS_COLORSに合わせて色を付与
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#-------#
# zinit #
#-------#

# Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# End of Zinit's installer chunk

#---------------#
# zinit plugins #
#---------------#

# To load Oh My Zsh plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit light chrissicool/zsh-256color

# Auto-complete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zstyle ':completion:*' menu select

