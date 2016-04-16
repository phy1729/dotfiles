[ -n "$SSH_CLIENT" -a -z "$TMUX" ] && whence tmux >/dev/null &&
	{ tmux attach || tmux new-session }

DIRSTACKSIZE=8
FPATH="$HOME/.zshcomp:$FPATH"
HISTFILE=~/.histfile
HISTSIZE=1000
PROMPT="%n@%m:%~%(?,,%F{red})%#%f "
SAVEHIST=100000

bindkey -e

setopt appendhistory \
       automenu \
       autopushd \
       beep \
       cbases \
       correctall \
       extendedglob \
       histignorespace \
       ignoreeof \
       noclobber \
       nomatch \
       pushdminus \
       pushdsilent \
       pushdtohome

autoload -Uz compinit
compinit
compctl -g '*.tex' +  vim
fignore=( .aux .pdf )

alias c='ssh c'
alias cvsup='sudo cvs -q up -Pd'
alias v='vim'

alias -s pdf='(){ mupdf "$@" >& /dev/null &| exit }'
alias -s tex='vim'
alias -s txt='vim'

case "$(uname -s)" in
	Darwin) alias ls='ls -ehlFGWO' ;;
	Linux) alias ls='ls -hlF --color' ;;
	OpenBSD) alias ls='ls -hlF' ;;
esac


# map :h to opening vim's help in fullscreen
function :h { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function quote-:h { [[ $BUFFER = :h\ * ]] && BUFFER=":h ${(q)BUFFER:3}" }
zle -N zle-line-finish quote-:h

function :PU () { vim -u NONE +'silent! source ~/.vimrc' +PlugUpdate +qa; }
function getsets { rm -rf "$HOME"/,sets && mkdir "$HOME"/,sets && for i in base comp game man xbase xfont xserv xshare; do ftp -o "$HOME/,sets/${i}58.tgz" http://mirror.esc7.net/pub/OpenBSD/snapshots/amd64/"${i}58.tgz" >/dev/null 2>&1 & done && for i in bsd bsd.mp bsd.rd INSTALL.amd64 SHA256.sig; do ftp -o "$HOME/,sets/$i" "http://mirror.esc7.net/pub/OpenBSD/snapshots/amd64/$i" >/dev/null 2>&1 & done }
function hgrep { repeat "$1"; do read -r; print -r "$REPLY"; done; grep "${@:2}"; }
function info { command info "$@" | "$PAGER"; }
function u { (cd "$HOME"/.dotfiles && git pull && git submodule update && ~/bin/dfm install) }
function x { (cd && startx >|~/.xlog 2>&1 &) && clear && lock -np }
