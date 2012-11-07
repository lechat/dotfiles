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
Bundle 'majutsushi/tagbar'
" Show tags in source file 
Bundle 'kien/tabman.vim' 
" work with tabs from keyboard - <leader>mf <leader>mt
Bundle 'altercation/vim-colors-solarized'
" Solarized color scheme
Bundle 'VOoM'
" Outline plugin for asciidoc, etc.
Bundle 'mileszs/ack.vim'
Bundle 'Raimondi/delimitMate'

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

set cursorline                  " hilight cursor line
set cursorcolumn                " and column

set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors

" let g:Powerline_colorscheme="default_mod.vim"
let g:Powerline_symbols="unicode"
let g:Powerline_stl_path_style="relative"

colorscheme zenburn
" colorscheme wombat

if has('gui_running')
  " set gfn=Liberation\ Mono\ Bold\ 10
  " set guioptions-=m " remove the menubar
  set guioptions-=T " remove the toolbar
  set gfn=Source\ Code\ Pro\ Semi-Bold\ 10
  " set gfn=Consolas\ 10
  " set gfn=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline\ 9
  set lines=999
  set columns=999
  winpos 1 1
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
  " let g:Powerline_symbols = 'fancy'
  " colorscheme solarized
  set listchars=tab:»·,trail:·
else
  " colorscheme wombat
  hi CursorLine cterm=NONE ctermbg=8
endif

" highlight Pmenu guibg=RoyalBlue

filetype on
set rnu
set nobackup

set ruler " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)%{fugitive#statusline()} " a ruler on steroids
set showcmd " show partial commands in status line and
set laststatus=2 " Always show the statusline

set backspace=indent,eol,start

set incsearch " find as you type search
set hlsearch " highlight search terms

set scrolloff=3 " minimum lines to keep above and below cursor

set nofoldenable
set foldmethod=manual

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
" autocmd BufWritePre *.py normal m`:%s/\s\+$//e`
autocmd FileType python setlocal omnifunc=pysmell#Complete

map <F2> :NERDTreeToggle<CR>

" CtrlP settings
set wildignore+=*.sw*,*.pyc,*.class
" search by filename only
" let g:ctrlp_by_filename = 1
" reverse sort for match window
let g:ctrlp_match_window_reversed = 1
" search in dotfiles
" let g:ctrlp_dotfiles = 1
" ask where to open file
" let g:ctrlp_arg_map = 1

function! s:Shell()
  execute 'ConqueTermTab zsh'
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

let g:pymode_lint_config = "$HOME/.pylintrc"
let g:pymode_lint_onfly = 1
let g:pymode_lint_message = 1
let g:pymode_lint_onfly = 0
let g:pymode_lint_checker = "pylint"
let g:pymode_lint_hold = 0
let g:pymode_lint_jump = 0
" Disable showing Python docs on K
let g:pymode_doc = 0
let g:pymode_folding = 0


" Fugitive
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>gpl :Git pull origin master<CR>
nnoremap <leader>gps :Git push origin master<CR>

nnoremap <leader>x :ccl<CR>
nnoremap <leader>z :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>h :tabprev<CR>
nnoremap <leader>j :tabfirst<CR>
nnoremap <leader>k :tablast<CR>
nnoremap <leader>l :tabnext<CR>

nnoremap <leader>s :Shell<CR>
nnoremap <leader>w :w<CR>

noremap <F9> :emenu Git.<TAB>
menu Git.Status :Gstatus<CR>
menu Git.Diff :Gdiff<CR>
menu Git.Commit :Gcommit %<CR>
menu Git.Checkout :Gread<CR>
menu Git.Remove :Gremove<CR>
menu Git.Move :Gmove<CR>
menu Git.Log :Glog<CR>
menu Git.Blame :Gblame<CR>

nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
imap <c-s> <c-o><c-s>

" inoremap  <Up>     <NOP>
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" noremap   <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>
