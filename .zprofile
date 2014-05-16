export PATH=$PATH:~/bin
export EDITOR=vim

if [ $(uname -s) = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi
