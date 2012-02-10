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
" Comments lines on pressing \\\ (3 times \)
Bundle 'klen/python-mode'               
" Provides pylint, flake8, python key binding, etc.
Bundle 'tpope/vim-fugitive'             
" Git plugin
Bundle 'vim-scripts/EasyGrep'           
" Grep plugin
Bundle 'scrooloose/nerdtree'            
" Filesystem manipulation
Bundle 'talek/obvious-resize'           
" Resize split windows with Ctrl+move keys
Bundle 'ervandew/supertab'              
" Dropdown suggestions on TAB key press
Bundle 'vim-scripts/mru.vim'            
" Most recently used files
Bundle 'rson/vim-conque'                
" Shell within VIM buffer
Bundle 'kien/ctrlp.vim'                 
" Find files on Ctrl+P press
Bundle 'Lokaltog/vim-powerline.git'     
" Better status line
Bundle 'tpope/vim-unimpaired'           
" Navigate quickfix list with ]q and ]Q
 
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
  " set gfn=Liberation\ Mono\ Bold\ 10
  set gfn=Consolas\ 10
  set lines=999
  set columns=999
  winpos 1 1
  set guioptions-=T " remove the toolbar
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
endif

"colorscheme zenburn
colorscheme wombat
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
" highlight Pmenu guibg=RoyalBlue

filetype on
set nu
set nobackup

set ruler " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)%{fugitive#statusline()} " a ruler on steroids
set showcmd " show partial commands in status line and
set laststatus=2 " Always show the statusline

set backspace=indent,eol,start

set incsearch " find as you type search
set hlsearch " highlight search terms

set scrolloff=3 " minimum lines to keep above and below cursor

function! CleverTab()
  if pumvisible()
    return "\<C-N>"
  endif
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  elseif exists('&omnifunc') && &omnifunc != ''
    return "\<C-X>\<C-O>"
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
" let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
" let g:PyLintCWindow = 1
" let g:PyLintSigns = 1
"let g:PyLintOnWrite = 1
let NERDTreeIgnore = ['\.pyc$', '\.class$']
autocmd BufWritePre *.py normal m`:%s/\s\+$//e`
autocmd FileType python setlocal omnifunc=pysmell#Complete

map <F2> :NERDTreeToggle<CR>
map <F8> :Gst<CR>

" CtrlP settings
set wildignore+=*.sw*,*.pyc,*.class
let g:ctrlp_by_filename = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_dotfiles = 1

function! s:Shell()
  execute 'ConqueTermSplit zsh'
endfunction
command! Shell call s:Shell()
" let g:ConqueTerm_Color = 2
let g:ConqueTerm_TERM = 'xterm-256color'
let g:ConqueTerm_ToggleKey = '<F12>'
" let g:ConqueTerm_FastMode = 1
"
let g:EasyGrepRecursive = 1                         "'Recursive mode'for EasyGrep

" This command will open all grep results in quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" This command is to avoid bug in pylint-mode 0.5.6
let g:pymode_lint_message = 0
