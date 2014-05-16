if [ -r ~/.bashrc ]; then . ~/.bashrc; fi

export PATH=$PATH:~/bin
export EDITOR=vim

if [ $(uname -s) = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

set completion-ignore-case On

export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend
