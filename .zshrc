[ -n "$SSH_CLIENT" -a -z "$TMUX" ] && whence tmux >/dev/null &&
	{ tmux attach || tmux new-session }

FPATH="$HOME/.zshcomp:$FPATH"
PROMPT="%m:%~%(?,,%F{red})%#%f "

bindkey -e

setopt \
       cbases \
       noclobber \
       extendedglob

autoload -Uz compinit
compinit

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

function info { command info "$@" | $PAGER; }
function x { (cd && startx >|~/.xlog 2>&1 &) && clear && lock -np }
