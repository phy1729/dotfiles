set nocompatible
set history=1000
set undolevels=1000
set title
set lazyredraw
set hidden

set backupdir=~/tmp,/var/tmp,$HOME/Local\ Settings/Temp 

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
set wildignore=*.swp
set showcmd

" Searching make it smart, incremental, and hilight
set ignorecase
set smartcase
set incsearch
set hlsearch
set magic		" Make Regex *magic*

set number
set scrolloff=4
set linebreak
set formatoptions=rol1	" Make comments and word wrapping work properly
if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j	" Make joining work properly
end
set whichwrap+=<,>	" Let left and right wrap from line to line

nnoremap <leader>t :w \| !pdflatex '%'<cr>
nnoremap <leader>p :setlocal paste!<cr>

" Spelling
nnoremap <leader>ss :setlocal spell! spelllang=en_us<cr>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap Y y$	" Be consistant
nnoremap Q gQ	" I want my tab complete

"Center screen after searching
map N Nzz
map n nzz

set background=dark
set autoindent
set smartindent
syntax on

if has("autocmd")
	" Jump to last-known-position when editing files
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	" Credit: tpope
	" Deletes swapfiles for unmodified buffers
	autocmd CursorHold,BufWritePost,BufReadPost,BufLeave * if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

	" Makes .sh and .pl files executable
	if has ("unix")
		autocmd BufWritePost    *.sh      silent !chmod +x %
		autocmd BufWritePost    *.pl      silent !chmod +x %
	endif
endif


"Vundle
if executable("git")
	" Standard Vundle stuff
	filetype off
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	Bundle 'gmarik/vundle'

	" Powerline
	Bundle 'Lokaltog/vim-powerline'
	set laststatus=2
	let g:Powerline_symbols = 'unicode'

	" Colorscheme
	Bundle 'altercation/vim-colors-solarized'
	let g:solarized_termcolors=256
	colorscheme solarized
	highlight Comment ctermfg=brown

	" SkyBison
	Bundle 'paradigm/SkyBison'
	nnoremap <leader>:b 2:<c-u>call SkyBison("b ")<cr>
	nnoremap <leader>:t 2:<c-u>call SkyBison("tag ")<cr>
	nnoremap <leader>:h 2:<c-u>call SkyBison("h ")<cr>
	nnoremap <leader>:e :<c-u>call SkyBison("e ")<cr>

	" Unix nicities
	Bundle 'tpope/vim-eunuch'

	" Bundle 'ShowMarks'
	
	Bundle 'michaeljsmith/vim-indent-object'

	Bundle 'mbbill/undotree'
	nnoremap <leader>u :UndotreeToggle<cr>

	Bundle 'godlygeek/tabular'
	nnoremap <leader>Tm :Tabularize /&<cr>
	vnoremap <leader>Tm :Tabularize /&<cr>
	nnoremap <leader>TM :Tabularize /\v(\&\|\\\\)<cr>
	vnoremap <leader>TM :Tabularize /\v(\&\|\\\\)<cr>
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
