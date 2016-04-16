export CVSROOT=anoncvs@anoncvs.obsd.esc7.net:/cvs
export EDITOR=vim
export LESS=-XFcir
export PAGER=less
path+=(~/bin)

if [ "$(uname -s)" = 'Darwin' ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:"$PATH"
fi

[ -z "$SSH_CLIENT" ] && eval "$(ssh-agent -s)"
