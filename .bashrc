if [ -n "$SSH_CLIENT" ]; then
	if which tmux 2>&1 >/dev/null; then
		test -z "$TMUX" && (tmux attach || tmux new-session)
	fi
fi

# set -o vi
set -o noclobber

alias v='vim'
alias c='ssh c'
alias n='ssh n'

case $(uname -s) in
	Darwin)
		alias ls='ls -ehlFGWO'
		function brewup { brew update; brew upgrade; }
		;;
	Linux)
		alias ls='ls -hlF --color'
		;;
	OpenBSD)
		alias ls='ls -hlF'
		export PKG_PATH=http://mirror.esc7.net/pub/OpenBSD/$(uname -r)/packages/$(uname -p)/
		;;
esac


function u { git --work-tree=$HOME/.dotfiles --git-dir=$HOME/.dotfiles/.git pull && ~/bin/dfm install; }
# map :h to opening vim's help in fullscreen
alias :h='noglob :h-helper'
function :h-helper () { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function :BI () { vim -u NONE +'silent! source ~/.vimrc' +BundleInstall! +qa; }
