# ~/.bashrc

[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ "$USER" = "root" ]; then
    PS1="\[\033[31m\]\h\[\033[36m\]: \[\033[32m\]\w \[\033[36m\]\$ \[\033[0m\]"
else
    PS1="\[\033[34m\]\u\[\033[36m\]@\[\033[34m\]\h\[\033[36m\]: \[\033[32m\]\w \[\033[36m\]\$ \[\033[0m\]"
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

