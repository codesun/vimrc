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
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'def-lkb/vimbufsync'
Plugin 'scrooloose/nerdtree'

" Vundle manager end
" required!
call vundle#end()

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

" Configuration for tagbar
nmap <F12> :TagbarToggle<CR>

syntax on
filetype plugin indent on

" coquille key binding
au FileType coq call coquille#FNMapping()

" disable the toolbar on the window widget
set guioptions-=T
set guifont=Inconsolata\ Medium\ 10

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

"##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######

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

