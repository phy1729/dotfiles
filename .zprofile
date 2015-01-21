export PATH=$PATH:~/bin
export EDITOR=vim
export CVSROOT=anoncvs@anoncvs.obsd.esc7.net:/cvs

if [ $(uname -s) = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

eval $(ssh-agent -s)
