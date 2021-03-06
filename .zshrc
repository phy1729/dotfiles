[ -n "$SSH_CLIENT" -a -z "$TMUX" ] && whence tmux >/dev/null &&
	{ tmux attach || tmux new-session }

FPATH="$HOME/.zshcomp:$FPATH"
HISTFILE=~/.histfile
HISTSIZE=1000
PROMPT="%m:%~%(?,,%F{red})%#%f "
SAVEHIST=100000

bindkey -e

setopt \
       cbases \
       noclobber \
       extendedglob \
       histignorealldups \
       histignorespace

autoload -Uz compinit
compinit

alias c='mosh c'
alias cvsup='cvs -q up -Pd'
alias ls='ls -hlF'
alias pl='print -rl --'
alias v=vim

alias -s mp{3,4}=mplayer
alias -s ogg=mplayer
alias -s pdf='(){ mupdf "$@" >& /dev/null &| exit }'


# map :h to opening vim's help in fullscreen
function :h { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function quote-:h { [[ $BUFFER = :h\ * ]] && BUFFER=":h ${(q)BUFFER:3}" }
zle -N zle-line-finish quote-:h

function :PU { vim -u NONE +'silent! source ~/.vimrc' +PlugUpdate +qa; }
function getsets {
	rm -rf $HOME/,sets
	mkdir $HOME/,sets
	local i
	for i in {base,comp,game,man,xbase,xfont,xserv,xshare}59.tgz bsd bsd.mp bsd.rd INSTALL.amd64 pxeboot SHA256.sig; do
		ftp -o $HOME/,sets/$i http://mirror.esc7.net/pub/OpenBSD/snapshots/amd64/$i >/dev/null 2>&1 &
	done
}

function hgrep { repeat $1; do read -r; print -r -- $REPLY; done; grep "${@:2}"; }
function info { command info "$@" | $PAGER; }
function u { dfm pull && dfm submodule update && dfm install; }
function x { (cd && startx >|~/.xlog 2>&1 &) && clear && lock -np }
