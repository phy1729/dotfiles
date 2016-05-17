export CVSROOT=anoncvs@anoncvs.obsd.esc7.net:/cvs
export EDITOR=vim
export LANG=en_US.UTF-8
export LESS=-XFcir
export PAGER=less
path+=(~/bin ~/.cabal/bin)

if [ "$(uname -s)" = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:"$PATH"
fi

[ -z "$SSH_CLIENT" ] && eval "$(ssh-agent -s)"
