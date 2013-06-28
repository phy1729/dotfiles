#if which tmux 2>&1 >/dev/null; then
#	test -z "$TMUX" && (tmux attach || tmux new-session)
#fi
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit

setopt correctall histignorespace ignoreeof noclobber automenu
compctl -g '*.tex' +  vim
fignore=( .aux .log .pdf )
setopt autopushd pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=8

export PROMPT="%n@%m:%~%# "

alias v='vim'
alias c='ssh c'
alias n='ssh n'

case $(uname -s) in
	Darwin)
		alias ls='ls -AehlFGWO'
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


function u { cd ~/.dotfiles; git pull; cd - 1>/dev/null; ~/bin/dfm }
function irc { ssh c.collegiumv.org -t tmux attach -d; }
function cvtun { ssh -N phy1729@n.collegiumv.org -L 22$(printf "%02d" $1):192.168.42.$1:$2; }
function cvssh { ssh -At phy1729@n.collegiumv.org ssh $1 }
function cvrdc { ssh -fNML 22$(printf "%02d" $1):192.168.42.$1:3389 -S ~/.cvrdc:$1 phy1729@n.collegiumv.org; rdesktop -u phy1729 -d collegiumv.org -p - -f 127.0.0.1:22$(printf "%02d" $1); ssh -S ~/.cvrdc:$1 -O exit localhost; }
function ssh-copy-id { cat ~/.ssh/id_dsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'; }
# map :h to opening vim's help in fullscreen
function :h () { vim +"h $1" +only; }
function :BI () { vim -u NONE +'silent! source ~/.vimrc' +BundleInstall! +qa; }
