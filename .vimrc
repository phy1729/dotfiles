set nocompatible
set history=1000
set undolevels=1000
set title
set lazyredraw
set hidden

set backupdir=~/tmp,/tmp,/var/tmp,$HOME/Local\ Settings/Temp
if v:version >702
	set undofile
	set undodir=~/.vim/undodir
	if ! isdirectory(expand("~/.vim/undodir"))
		call mkdir(expand("~/.vim/undodir"),"p",0700)
	end
end

" Don't beep
set visualbell
set noerrorbells

" Get out of insert mode faster
set notimeout
set ttimeout
set ttimeoutlen=50

set backspace=2
set encoding=utf-8
set nomodeline		" For security
set autoread

set wildmenu
set wildmode=longest:full,full
set wildignore=*.swp,*.aux,*.pdf
if exists("+wildignorecase")
	set wildignorecase
endif
set showcmd

" Searching make it smart, incremental, and hilight
set ignorecase
set smartcase
set incsearch
set hlsearch
set magic

set number
set scrolloff=4
set linebreak
set formatoptions=rol1	" Make comments and word wrapping work properly
if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j	" Make joining work properly
end

nnoremap <leader>t :w \| !pdflatex '%'<cr>
nnoremap <leader>o :! xdg-open '%:r.pdf' > /dev/null &<cr><cr>
nnoremap <leader>p :setlocal paste!<cr>

" Spelling
nnoremap <leader>ss :setlocal spell! spelllang=en_us<cr>:syntax sync fromstart<cr>

" For the all to often :Q typo
com! -bang Q q<bang>
" Fullscreen help
com! -narg=1 -complete=help H h <args> <bar> only
" Be consistent
nnoremap Y y$
" I want my tab complete
nnoremap Q gQ

"Center screen after searching
map N Nzz
map n nzz

" Diff mappings stolen from https://gist.github.com/qstrahl/6310563#file-diff-mappings-vim
nno do :<C-U>exe 'diffget' v:count ? get(filter(tabpagebuflist(), 'getbufvar(bufname(v:val), "&diff")'), v:count) : '' '<Bar> diffupdate'<CR>
nno dp :<C-U>exe 'diffput' v:count ? get(filter(tabpagebuflist(), 'getbufvar(bufname(v:val), "&diff")'), v:count) : '' '<Bar> diffupdate'<CR>
nnoremap du :<C-U>diffupdate<CR>
nnoremap dm :if &diff<Bar>diffoff<Bar>else<Bar>diffthis<Bar>endif<CR>
nnoremap dq :<C-U>diffoff!<CR>

set background=dark
set autoindent
syntax on

if has("autocmd")
	" Jump to last-known-position when editing files
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	autocmd FileType gitcommit 0

	" Credit: tpope
	" Deletes swapfiles for unmodified buffers
	autocmd CursorHold,BufWritePost,BufReadPost,BufLeave * if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

	" Makes .sh and .pl files executable
	if has ("unix")
		autocmd BufWritePost *.sh silent !chmod +x %
		autocmd BufWritePost *.pl silent !chmod +x %
	endif

	autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
endif


"Vundle
if isdirectory(expand("~/.vim/bundle/vundle"))
	" Standard Vundle stuff
	filetype off
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	Bundle 'gmarik/vundle'

	" Airline
	Bundle 'bling/vim-airline'
	set laststatus=2
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '◀'

	" Colorscheme
	Bundle 'altercation/vim-colors-solarized'
	let g:solarized_termcolors=256
	colorscheme solarized
	highlight Comment ctermfg=brown

	" Unix nicities
	Bundle 'tpope/vim-eunuch'

	" Bundle 'ShowMarks'

	Bundle 'michaeljsmith/vim-indent-object'

	Bundle 'paradigm/TextObjectify'

	Bundle 'mbbill/undotree'
	nnoremap <leader>u :UndotreeToggle<cr>

	Bundle 'godlygeek/tabular'
	nnoremap <leader>Tm :Tabularize /&<cr>
	vnoremap <leader>Tm :Tabularize /&<cr>
	nnoremap <leader>TM :Tabularize /\v(\&\|\\\\)<cr>
	vnoremap <leader>TM :Tabularize /\v(\&\|\\\\)<cr>
	nnoremap <leader>T# :Tabularize /#<cr>
	vnoremap <leader>T# :Tabularize /#<cr>
	nnoremap <leader>T, :Tabularize /,<cr>
	vnoremap <leader>T, :Tabularize /,<cr>

	Bundle 'mattn/webapi-vim'
	Bundle 'mattn/gist-vim'
	let g:gist_clip_command = 'pbcopy'
	let g:gist_post_private = 1

	Bundle 'dahu/LearnVim'

	Bundle 'iptables'
	autocmd BufReadPost *.rules se ft=iptables

	Bundle 'christoomey/vim-tmux-navigator'
else
	colorscheme desert
endif
filetype plugin indent on
" end Vundle

" Credit: http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
