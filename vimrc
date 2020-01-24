" Use Vim settings, rather than Vi settings (much better!).
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

" Vundle manager begin
" required!
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'def-lkb/vimbufsync'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'rrethy/vim-illuminate'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'

" Vundle manager end
" required!
call vundle#end()

" Configuration for illuminate
let g:Illuminate_delay=200
let g:Illuminate_highlightUnderCursor=1

" Configuration for neocomplete
let g:neocomplete#enable_at_startup = 1
"
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
"" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Configuration for vim-airline
set laststatus=2
" let g:airline#extensions#tabline#enabled = 1

set mouse=a

" Configuration for tagbar
nmap <F12> :TagbarToggle<CR>

nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

syntax on
filetype plugin indent on

" disable the toolbar on the window widget
set guioptions-=T
set guifont=Inconsolata\ Medium\ 12

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead

set ruler		" show the cursor position all the time
set number      " show the line number
set showcmd		" display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " enable highlight of search

colorscheme candycode

" set the indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
set cindent

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <F10> :NERDTreeToggle<CR>

map <F11> :call Perform()<CR>

func! Perform()
	if &filetype == "c"
		exec "w"
		exec "!gcc % -o %<"
		echo "=============="
		exec "!./%<"
	elseif &filetype == "cpp"
		exec "w"
		exec "!g++ % -o %< -std=c++11"
		echo "=============="
		exec "!./%<"
	elseif &filetype == "lua"
		exec "w"
		echo "=============="
		exec "!luajit %"
	endif
endfunc

" configuration for cscope
if has("cscope")
	set csto=0
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

