[[ -n "$SSH_CLIENT" && -z "$TMUX" ]] && whence tmux >/dev/null &&
	{ tmux attach || tmux new-session }

FPATH="$HOME/.zshcomp:$FPATH"
PROMPT='%m:%~%(?,,%F{red})%#%f '

bindkey -e

setopt \
       cbases \
       noclobber \
       extendedglob

autoload -Uz compinit
compinit

info() { command info "$@" | $PAGER; }
ls() { command ls -hlF $@; }
pl() { print -rl -- $@; }
compdef pl=print
sa() { ssh-add ~/.ssh/id_*~*.pub; }
v() { vim $@; }
compdef v=vim
x() { (( $+DISPLAY )) && return 1; (cd && xinit >|~/.xlog 2>&1 &) && clear && lock -np }

unalias run-help
unalias which-command

alias -s mp{3,4}=mplayer
alias -s ogg=mplayer
alias -s pdf='(){ mupdf -- "$@" >& /dev/null &| exit }'

# map :h to opening vim's help in fullscreen
function :h { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }
function quote-:h { [[ $BUFFER = :h\ * ]] && BUFFER=":h ${(q)BUFFER:3}" }
zle -N zle-line-finish quote-:h

dfm() {
	command git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
}
compdef dfm=git

sgit() {
	local d
	local -a success failure

	for d in */.git(:h); do
		print -P -- "%F{cyan}=== $d ===%f"
		if git -C $d "$@"; then
			print -P -- $d '%F{green}success%f'
			success+=($d)
		else
			print -P -- $d '%F{red}failure%f'
			failure+=($d)
		fi
	done

	(( $#success )) && print -P '%F{green}success%f:' $success
	(( $#failure )) && print -P '%F{red}failure%f:' $failure
}
compdef sgit=git
