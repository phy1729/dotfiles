# set -o vi
set -o noclobber

alias odd='od -c -t x1'
alias v='vim'
alias c='ssh c'

case $(uname -s) in
	Darwin)
		alias ls='ls -AehlFWO'
		function brewup { brew update; brew upgrade; }
		function note { . ~/bin/scd; vim notes.tex; }
		function irc { ssh c.collegiumv.org -t tmux attach -d; }
		;;
	Linux)
		alias ls='ls -AhlF --color'
		function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }
		function playdir { mplayer -shuffle -playlist <(find -L "$(pwd)" -type f); }
		;;
	OpenBSD)
		alias ls='ls -AhlF'
		export PKG_PATH=ftp://filedump.se.rit.edu/pub/OpenBSD/$(uname -r)/packages/$(uname -p)/
		;;
esac


function u { cd ~/.dotfiles; git pull; cd - 1>/dev/null; }
function cvtun { ssh -N phy1729@n.collegiumv.org -L 22`printf "%02d" $1`:192.168.42.$1:$2; }
function ssh-copy-id { cat ~/.ssh/id_dsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'; }
# map :h to opening vim's help in fullscreen
function :h () { vim +"h $1" +only; }
function :BI () { vim -u NONE +'silent! source ~/.vimrc' +BundleInstall! +qa; }
