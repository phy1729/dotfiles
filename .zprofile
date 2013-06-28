export TERMINAL=xterm
export PATH=$PATH:~/bin

if [ $(uname -s) = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi
