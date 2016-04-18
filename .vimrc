set autoindent
set background=dark
set backspace=2
set backupdir=~/tmp,/tmp,/var/tmp
set encoding=utf-8
set formatoptions=1jqort
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set nomodeline
set number
set ruler
set scrolloff=4
set showcmd
set smartcase
set notimeout
set ttimeout
set ttimeoutlen=50
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set visualbell
set wildignore=*.swp
set wildignorecase
set wildmenu
set wildmode=longest:full,full

if !isdirectory(expand("~/.vim/undodir"))
	call mkdir(expand("~/.vim/undodir"),"p",0700)
end

nnoremap <leader>s :setlocal spell! spelllang=en_us<cr>

nnoremap dm :<C-u>set diff!<CR>
nnoremap dq :<C-U>diffoff!<CR>
nnoremap du :<C-U>diffupdate<CR>

" Center screen after searching
nnoremap N Nzz
nnoremap n nzz

nnoremap Q gQ
nnoremap Y y$

command! -bang Q q<bang>

" Jump to last-known-position when editing files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd FileType gitcommit 0

" Credit: tpope
" Deletes swapfiles for unmodified buffers
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave * if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

autocmd Filetype gitcommit,mail set cc=72
autocmd Filetype ldif set cc=79
autocmd Filetype sh autocmd BufWritePost * silent !chmod +x %

"Plug
if filereadable(expand("~/.vim/autoload/plug.vim"))
	call plug#begin('~/.vim/plugged')

	Plug 'robertmeta/nofrils'

	Plug 'tpope/vim-eunuch'

	Plug 'michaeljsmith/vim-indent-object'

	Plug 'paradigm/TextObjectify'

	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	nnoremap <leader>u :UndotreeToggle<cr>

	Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
	noremap <leader>T# :Tabularize /#<cr>
	noremap <leader>T, :Tabularize /,<cr>

	Plug 'mattn/webapi-vim'
	Plug 'mattn/gist-vim'
	let g:gist_post_private = 1
	if executable('pbcopy')
		let g:gist_clip_command = 'pbcopy'
	endif

	Plug 'iptables', { 'for': 'iptables' }
	autocmd BufReadPost *.rules se ft=iptables

	Plug 'chase/vim-ansible-yaml'

	call plug#end()
	colorscheme nofrils-dark
else
	colorscheme desert
endif
filetype plugin indent on

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
