export CVSROOT=anoncvs@anoncvs2.usa.openbsd.org:/cvs
export EDITOR=vim
export LANG=en_US.UTF-8
export LESS=-XFcir
export PAGER=less
path+=(~/bin)

[[ -z $SSH_CLIENT && $OSTYPE != darwin* ]] && eval "$(ssh-agent -s)"
