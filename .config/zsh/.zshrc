# .zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# autoloads
autoload -Uz compinit

# Use XDG dirs for completion and history files
# only set these when XDG runtime is provided
# see https://specifications.freedesktop.org/basedir-spec/0.8/
# "fallback" here is disabling related functions
if [ ! -z ${XDG_RUNTIME_DIR} ]
then
    XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
    XDG_STATE_HOME=${XDG_STATE_HOME:-${HOME}/.local/state}
    XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}

    [ -d ${XDG_DATA_HOME}/zsh ] || mkdir -p ${XDG_DATA_HOME}/zsh
    [ -d ${XDG_CACHE_HOME}/zsh ] || mkdir -p ${XDG_CACHE_HOME}/zsh

    HISTFILE=${XDG_DATA_HOME}/zsh/history
    zstyle ':completion:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache
    compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION
fi

HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

PS1="%(1j:%F{yellow}[%j]%f:)%(?::%F{red}(%?%)%f)%m:%F{blue}%~%f%F{green}%#%f "

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export GPG_TTY=$(tty)
