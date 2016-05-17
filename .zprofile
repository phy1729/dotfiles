export CVSROOT=anoncvs@anoncvs.obsd.esc7.net:/cvs
export EDITOR=vim
export LANG=en_US.UTF-8
export LESS=-XFcir
export PAGER=less
path+=(~/bin ~/.cabal/bin)

[[ -z $SSH_CLIENT && $OSTYPE != darwin* ]] && eval "$(ssh-agent -s)"
