if [ $SSH_CLIENT ]; then
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
		alias ls='ls -AehlFGWO'
		function brewup { brew update; brew upgrade; }
		function note { . ~/bin/scd; vim notes.tex; }
		;;
	Linux)
		alias ls='ls -AhlF --color'
		function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }
		function playdir { mplayer -shuffle -playlist <(find -L "$(pwd)" -type f); }
		;;
	OpenBSD)
		alias ls='ls -AhlF'
		export PKG_PATH=http://mirror.esc7.net/pub/OpenBSD/$(uname -r)/packages/$(uname -p)/
		;;
esac


function u { git --work-tree=$HOME/.dotfiles --git-dir=$HOME/.dotfiles/.git pull && ~/bin/dfm install }
function cvtun { ssh -N phy1729@phalanx -L 22$(printf "%02d" $1):192.168.42.$1:$2; }
function cvrdc { ssh -fNML 122$(printf "%02d" $1):192.168.42.$1:3389 -S ~/.cvrdc:$1 phy1729@n.collegiumv.org; rdesktop -u phy1729 -d collegiumv.org -p - -f 127.0.0.1:122$(printf "%02d" $1); ssh -S ~/.cvrdc:$1 -O exit localhost; }
# map :h to opening vim's help in fullscreen
alias :h='noglob :h-helper'
function :h-helper () { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function :BI () { vim -u NONE +'silent! source ~/.vimrc' +BundleInstall! +qa; }
