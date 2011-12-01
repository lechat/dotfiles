filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-commentary'
Bundle 'klen/pylint-mode'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/EasyGrep'
Bundle 'scrooloose/nerdtree'
Bundle 'talek/obvious-resize'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/mru.vim'
Bundle 'rson/vim-conque'
Bundle 'avidal/flake8.vim'
 
filetype plugin indent on

:syntax on
set nocompatible
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set showmatch

set wildmenu
set wildmode=list:longest,full

if has('gui_running')
  set gfn=Liberation\ Mono\ Bold\ 10
  set lines=999
  set columns=999
  winpos 1 1
  set guioptions-=T " remove the toolbar
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
endif

colorscheme zenburn

filetype on
set nu
set nobackup

set ruler " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)%{fugitive#statusline()} " a ruler on steroids
set showcmd " show partial commands in status line and

set backspace=indent,eol,start

set incsearch " find as you type search
set hlsearch " highlight search terms

set scrolloff=3 " minimum lines to keep above and below cursor

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

noremap <silent> <C-Up> :ObviousResizeUp<CR> 
noremap <silent> <C-Down> :ObviousResizeDown<CR> 
noremap <silent> <C-Left> :ObviousResizeLeft<CR> 
noremap <silent> <C-Right> :ObviousResizeRight<CR> 

" Options for Pylint-mode
let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
let g:PyLintCWindow = 1
let g:PyLintSigns = 1
let g:PyLintOnWrite = 1
let NERDTreeIgnore = ['\.pyc$', '\.class$']
autocmd BufWritePre *.py normal m`:%s/\s\+$//e`

map <F2> :NERDTreeToggle<CR>
map <F8> :Gst<CR>
