# .zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# autoloads
autoload -Uz compinit

# Use XDG dirs for completion and history files
[ -d ~/.local/share/zsh ] || mkdir -p ~/.local/share/zsh
HISTFILE=~/.local/share/zsh/history
[ -d ~/.cache/zsh ] || mkdir -p ~/.cache/zsh
zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

alias ls='ls --color=auto'
alias grep='grep --color=auto'
