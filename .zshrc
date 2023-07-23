#####################################################################
# basic
#####################################################################

# vimキーバインド
bindkey -v

# ノーマルモードへの移行を'jj'に変更
bindkey -M viins 'jj' vi-cmd-mode

# anyenv
eval "$(anyenv init -)"

# pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# グロブ展開をしない
setopt nonomatch

#####################################################################
# history
#####################################################################

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

#####################################################################
# autocomplete
#####################################################################
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
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

#####################################################################
# color
#####################################################################
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

#####################################################################
# zplug
#####################################################################

# zplug PATH
export ZPLUG_HOME=${HOME}/.zplug
source ${ZPLUG_HOME}/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme (https://github.com/sindresorhus/pure#zplug)
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "sindresorhus/pure", from:"github", use:"pure.zsh", as:"theme"

# Syntax highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# history
zplug "zsh-users/zsh-history-substring-search"

# autocomplete
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zstyle ':completion:*' menu select

# git Supports oh-my-zsh plugins and the like
zplug "plugins/git", from:"oh-my-zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

