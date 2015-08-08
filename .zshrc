if [ -n "$SSH_CLIENT" ]; then
	if which tmux 2>&1 >/dev/null; then
		test -z "$TMUX" && (tmux attach || tmux new-session)
	fi
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit

setopt correctall histignorespace ignoreeof noclobber automenu cbases
compctl -g '*.tex' +  vim
fignore=( .aux .pdf )
setopt autopushd pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=8

PROMPT="%n@%m:%~%(?,,%F{red})%#%f "

alias v='vim'
alias c='ssh c'
alias n='ssh n'
alias cvsup='sudo cvs -q up -Pd'

alias -s pdf='(){ mupdf "$@" >& /dev/null &| exit }'
alias -s tex='vim'
alias -s txt='vim'

case $(uname -s) in
	Darwin)
		alias ls='ls -ehlFGWO'
		function brewup { brew update; brew upgrade; }
		function note { . ~/bin/scd; vim notes.tex; }
		;;
	Linux)
		alias ls='ls -hlF --color'
		function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }
		function playdir { mplayer -shuffle -playlist <(find -L "$(pwd)" -type f); }
		;;
	OpenBSD)
		alias ls='ls -hlF'
		export PKG_PATH=http://mirror.esc7.net/pub/OpenBSD/snapshots/packages/$(uname -p)/
		;;
esac


function u { (cd $HOME/.dotfiles && git pull && git submodule update && ~/bin/dfm install) }
function x { (cd && startx >|~/.xlog 2>&1 &) && clear && lock -np }
function cvtun { ssh -N phy1729@phalanx -L 22$(printf "%02d" $1):192.168.42.$1:$2; }
function cvrdc { ssh -fNML 122$(printf "%02d" $1):192.168.42.$1:3389 -S ~/.cvrdc:$1 phy1729@n.collegiumv.org; rdesktop -u phy1729 -d collegiumv.org -p - -f 127.0.0.1:122$(printf "%02d" $1); ssh -S ~/.cvrdc:$1 -O exit localhost; }
function getsets { rm -rf $HOME/,sets && mkdir $HOME/,sets && for i in base comp game man xbase xfont xserv xshare; do ftp -o "$HOME/,sets/${i}57.tgz" http://mirror.esc7.net/pub/OpenBSD/snapshots/amd64/"${i}57.tgz" >/dev/null 2>&1 &; done && for i in bsd bsd.mp bsd.rd INSTALL.amd64 SHA256.sig; do ftp -o "$HOME/,sets/$i" "http://mirror.esc7.net/pub/OpenBSD/snapshots/amd64/$i" >/dev/null 2>&1 &; done }
# map :h to opening vim's help in fullscreen
alias :h='noglob :h-helper'
function :h-helper () { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function :PU () { vim -u NONE +'silent! source ~/.vimrc' +PlugUpdate +qa; }
function hgrep { repeat $1; do read -r; print -r $REPLY; done; grep "${@:2}"; }
