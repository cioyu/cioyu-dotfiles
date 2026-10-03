#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd'
alias ll='lsd -lS'
alias lt='lsd --tree --depth 2'
alias grep='grep --color=auto'
alias cat='bat -n'
alias fastfetch='~/.config/fastfetch/neko-fetch.sh'
alias print='notify-send'
#PS1='[\u@\h \W]\$ '
PS1='[\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\] \[\e[1;36m\]\w\[\e[0m\]]\$ '

if [ "$TERM" = "xterm-kitty" ]; then
    fastfetch
fi

export EDITOR="vim"
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy="socks5://127.0.0.1:7890"

enable -f /usr/lib/bash/libflyline.so flyline

export PATH="$PATH:/home/cioyu/Projects/shell"
# uv
export PATH="/home/cioyu/.local/bin:$PATH"
. "$HOME/.cargo/env"
