if [ -r ~/.bashrc ]; then . ~/.bashrc; fi

export EDITOR=vim
export CLICOLOR=TRUE

export PATH=/usr/local/bin:$PATH:/usr/local/sbin:~/bin

set completion-ignore-case On

export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

export HOSTFILE=$HOME/.hosts    # Put a list of remote hosts in ~/.hosts
