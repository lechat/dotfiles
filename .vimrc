filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-commentary'
" Comments lines on pressing \\\ (3 times \)
Plugin 'klen/python-mode'
Plugin 'nvie/vim-flake8'
" Provides pylint, flake8, python key binding, etc.
Plugin 'tpope/vim-fugitive'
" Git plugin
Plugin 'vim-scripts/EasyGrep'
" Grep plugin
Plugin 'scrooloose/nerdtree'
" Filesystem manipulation
Plugin 'talek/obvious-resize'
" Resize split windows with Ctrl+move keys
Plugin 'ervandew/supertab'
" Dropdown suggestions on TAB key press
" Plugin 'vim-scripts/mru.vim'
" Most recently used files
" Plugin 'basepi/vim-conque'
" Shell within VIM buffer
Plugin 'kien/ctrlp.vim'
" Find files on Ctrl+P press
"Plugin 'Lokaltog/vim-powerline.git'
Plugin 'itchyny/lightline.vim'
" Better status line
Plugin 'tpope/vim-unimpaired'
" Navigate quickfix list with ]q and ]Q
Plugin 'majutsushi/tagbar'
" Show tags in source file
Plugin 'kien/tabman.vim'
" work with tabs from keyboard - <leader>mf <leader>mt
Plugin 'altercation/vim-colors-solarized'
" Solarized color scheme
" Plugin 'VOoM'
" Outline plugin for asciidoc, etc.
Plugin 'mileszs/ack.vim'
" Helper to use ack command from inside vim
Plugin 'Raimondi/delimitMate'
Plugin 'mbbill/undotree'
" Plugin 'goldfeld/vim-seek'
" Adds s/S navigation
Plugin 'justinmk/vim-sneak'
" Mutiline s/S navigation
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'jistr/vim-nerdtree-tabs'
" same Nerdtree in all tabs
Plugin 'Shougo/vimproc.vim'
" async execution, required for Unite
Plugin 'Shougo/unite.vim'
" united search
Plugin 'gregsexton/gitv'
" Git log viewer
Plugin 'Yggdroot/indentLine'
" Show vertical lines at indentation level
" Plugin 'vim-scripts/ZoomWin'
" Plugin 'thinca/vim-quickrun'
" Plugin 'osyo-manga/shabadou.vim'
" Plugin 'jceb/vim-hier'
Plugin 'dannyob/quickfixstatus'
Plugin 'idanarye/vim-merginal'
" View git branches
Plugin 'motemen/git-vim'
" Golang in vim
Plugin 'fatih/vim-go'

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
" let g:Powerline_symbols="unicode"
" let g:Powerline_stl_path_style="relative"

set background=dark
" let base16colorspace=256  " Access colors present in 256 colorspace"
colorscheme zenburn
" colorscheme wombat


if has('gui_running')
  " set gfn=Liberation\ Mono\ Bold\ 10
  " set guioptions-=m " remove the menubar
  set guioptions-=T " remove the toolbar
  set gfn=Source\ Code\ Pro\ for\ Powerline\ Semi-Bold\ 9
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
set nu
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

" function! CleverTab()
"   if pumvisible()
"     return "\<C-N>"
"   endif
"   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"     return "\<Tab>"
"   elseif exists('&omnifunc') && &omnifunc != ''
"     return "\<C-X>\<C-O>"
"   else
"     return "\<C-N>"
"   endif
" endfunction

" inoremap <Tab> <C-R>=CleverTab()<CR>

noremap <silent> <C-Up> :ObviousResizeUp<CR> 
noremap <silent> <C-Down> :ObviousResizeDown<CR> 
noremap <silent> <C-Left> :ObviousResizeLeft<CR> 
noremap <silent> <C-Right> :ObviousResizeRight<CR> 

" Options for Pylint-mode
" let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
" let g:PyLintCWindow = 1
" let g:PyLintSigns = 1
" let g:PyLintOnWrite = 1
let NERDTreeIgnore = ['\.pyc$', '\.class$']

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
        %s/\s\+$//e
endfunction
autocmd BufWritePre *.py call TrimWhiteSpace()
autocmd BufWritePre *.yaml call TrimWhiteSpace()
autocmd BufWritePost *.py call Flake8()
autocmd FileType python setlocal omnifunc=pysmell#Complete

map <F2> :NERDTreeToggle<CR>

" CtrlP settings
set wildignore+=*.sw*,*.pyc,*.class
" search by filename only
" let g:ctrlp_by_filename = 1
" reverse sort for match window
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_nerdtree_keys = 1
" search in dotfiles
" let g:ctrlp_dotfiles = 1
" ask where to open file
" let g:ctrlp_arg_map = 1

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

let g:pymode = 1
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 0
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
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

let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1

" Fugitive
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>gpl :GitPullRebase<CR>
nnoremap <leader>gps :GitPush<CR>
nnoremap <leader>gbr :Merginal<CR>

nnoremap <leader>x :ccl<CR>
nnoremap <leader>z :NERDTreeMirrorToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>y :tabprev<CR>
nnoremap <leader>u :tabfirst<CR>
nnoremap <leader>i :tablast<CR>
nnoremap <leader>o :tabnext<CR>

" nnoremap <leader>s :Shell<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

noremap <F9> :emenu Git.<TAB>
menu Git.Status :Gstatus<CR>
menu Git.Diff :Gdiff<CR>
menu Git.Commit :Gcommit %<CR>
menu Git.Checkout :Gread<CR>
menu Git.Remove :Gremove<CR>
menu Git.Move :Gmove<CR>
menu Git.Log :Glog<CR>
" menu Git.Blame :Gblame<CR>

nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
imap <c-s> <c-o><c-s>

command Q q
command W w
command Qa qa
cnoreabbrev X x

" inoremap  <Up>     <NOP>
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" noremap   <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>

set colorcolumn=79,120
highlight ColorColumn ctermbg=17
" Unite stuff
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

call unite#custom#source('file,file/new,buffer,file_rec/async', 'matchers', 'matcher_fuzzy')
nnoremap <silent> <leader><space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
nnoremap <silent> <leader><space>f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> <leader><space>y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> <leader><space>l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> <leader><space>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> <leader><space>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> <leader><space>m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> <leader><space>s :<C-u>Unite -quick-match buffer<cr>

let g:indentLine_char = '·'
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?"⭠ ".fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
    \ }

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
