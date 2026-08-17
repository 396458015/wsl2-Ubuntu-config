# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ============================================================
# Bash 基础设置
# ============================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Automatically update terminal size
shopt -s checkwinsize

# Lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ============================================================
# Debian / Ubuntu 默认 Prompt 设置
# ============================================================

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color)
        color_prompt=yes
        ;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Set terminal title
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
esac

# ============================================================
# 颜色支持
# ============================================================

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors \
        && eval "$(dircolors -b ~/.dircolors)" \
        || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ============================================================
# Alias
# ============================================================

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# 路径
alias p='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias h='cd ~'
alias root='cd /'

# Bash
alias ba='nvim ~/.bashrc'
alias rl='source ~/.bashrc'

# Neovim
alias v='nvim'
alias vim='nvim'

# Git / Lazygit
alias gg='lazygit'

# Fastfetch
alias ff='fastfetch --logo Ubuntu'

# Shell
alias q='exit'

# 删除 Windows Zone.Identifier 文件
alias delete_zone_files='find . -name "*:Zone.Identifier" -type f -delete'

# Long-running command alert
alias alert='notify-send --urgency=low \
-i "$([ $? = 0 ] && echo terminal || echo error)" \
"$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Optional aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ============================================================
# Bash Completion
# ============================================================

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ============================================================
# Cargo / Rust
# ============================================================

. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# ============================================================
# NVM / Node.js
# 用于管理和切换不同版本的 Node.js，并启用 Bash 命令自动补全
# ============================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================================
# WSL2 Clash 代理
# 动态获取 Windows 主机 IP
# ============================================================

export WSL_HOST=$(awk '/nameserver/ {print $2; exit}' /etc/resolv.conf)
export http_proxy="http://${WSL_HOST}:7890"
export https_proxy="http://${WSL_HOST}:7890"
export all_proxy="http://${WSL_HOST}:7890"
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$https_proxy"
export ALL_PROXY="$all_proxy"

# ============================================================
# Matplotlib
# 避免在 ~/.config 下创建 matplotlib 目录
# ============================================================

export MPLCONFIGDIR="$HOME/.cache/matplotlib"

# ============================================================
# Yazi
# ============================================================

function y() {
    local tmp
    local cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"

    if cwd="$(cat -- "$tmp")" \
        && [ -n "$cwd" ] \
        && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi

    rm -f -- "$tmp"
}

# Alt+F 打开 Yazi
bind -x '"\ef": y'

# ============================================================
# Starship
# 放在最后初始化 Prompt
# ============================================================

eval "$(starship init bash)"


