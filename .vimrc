filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:
"
" original repos on github
" Plugin 'tpope/vim-commentary'
" Comments lines on pressing \\\ (3 times \)
Plugin 'scrooloose/nerdcommenter'
" Comments by <leader>cc
Plugin 'klen/python-mode'
Plugin 'nvie/vim-flake8'
" Provides pylint, flake8, python key binding, etc.
Plugin 'tpope/vim-fugitive'
" Git plugin
Plugin 'motemen/git-vim'
" Git commands
Plugin 'vim-scripts/EasyGrep'
" Grep plugin
Plugin 'scrooloose/nerdtree'
" Filesystem manipulation
" Plugin 'talek/obvious-resize'
" Resize split windows with Ctrl+move keys - doesn't work
" Plugin 'ervandew/supertab'
" Dropdown suggestions on TAB key press
" Plugin 'vim-scripts/mru.vim'
" Most recently used files
" Plugin 'basepi/vim-conque'
" Shell within VIM buffer
" Plugin 'kien/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'
" Find files on Ctrl+P press
"Plugin 'Lokaltog/vim-powerline.git'
Plugin 'itchyny/lightline.vim'
" Better status line
Plugin 'tpope/vim-unimpaired'
" --  Navigate quickfix list with ]q and ]Q
" Plugin 'majutsushi/tagbar'
" Show tags in source file
" -- Plugin 'kien/tabman.vim'
" work with tabs from keyboard - <leader>mf <leader>mt
Plugin 'altercation/vim-colors-solarized'
" Solarized color scheme
" Plugin 'VOoM'
" Outline plugin for asciidoc, etc.
" Plugin 'mileszs/ack.vim'
" Helper to use ack command from inside vim
Plugin 'Raimondi/delimitMate'
" Autoclose ",brackets
Plugin 'mbbill/undotree'
" Plugin 'goldfeld/vim-seek'
Plugin 'justinmk/vim-sneak'
" Adds s/S navigation
" Mutiline s/S navigation
" Plugin 'Valloric/YouCompleteMe'
" -- Plugin 'scrooloose/syntastic'
" Syntax checks
Plugin 'airblade/vim-gitgutter'
" Shows git changes in gutter column
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
Plugin 'dannyob/quickfixstatus'
" Show errors in last line
Plugin 'idanarye/vim-merginal'
" View git branches
Plugin 'tmux-plugins/vim-tmux-focus-events'
" Allows pasting in terminal w/o set paste
Plugin 'fatih/vim-go'
" Golang in vim
Plugin 'jnurmine/Zenburn'
" Coloscheme
Plugin 'Shougo/neocomplete.vim'
" Code completion
" --Plugin 'tacahiroy/ctrlp-funky'
" CtrlP for functions
Plugin 'kshenoy/vim-signature'
" Show marks in gutter
Plugin 'mhinz/vim-startify'
" Custom start page
Plugin 'rust-lang/rust.vim'

filetype plugin indent on

:syntax on
set nocompatible
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set showmatch
set synmaxcol=150               " Show syntax colors only for 150 chars in line

let mapleader = "\<Space>"

set wildmenu
set wildmode=list:longest,full

if !match(substitute(system('uname -a'), "\n", "", ""), "arm")
    set cursorline                  " hilight cursor line
    set cursorcolumn                " and column
endif

set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors

" Attempting to speedup raspberry
set re=1
set ttyfast
set lazyredraw

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
" set rnu
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

noremap <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
noremap <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
noremap <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
noremap <silent> <C-Right> :<C-U>ObviousResizeRight<CR>

" Options for Pylint-mode
" let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
let g:PyLintCWindow = 1
" let g:PyLintSigns = 1
let g:PyLintOnWrite = 1
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
autocmd BufWritePre *.js call TrimWhiteSpace()
autocmd BufWritePre *.yaml call TrimWhiteSpace()
autocmd BufWritePost *.py call Flake8()

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

"'Recursive mode'for EasyGrep
let g:EasyGrepRecursive = 1

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
nnoremap <leader>gm :Merginal<CR>

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
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

call unite#custom#source('file,file/new,buffer,file_rec/async', 'matchers', 'matcher_fuzzy')
"nnoremap <silent> <leader><space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
nnoremap <silent> <leader><space>f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> <leader><space>y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> <leader><space>l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> <leader><space>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> <leader><space>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> <leader><space>m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> <leader><space>s :<C-u>Unite -quick-match buffer<cr>

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

let g:indentLine_char = '·'
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?" ".fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" Syntastic
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0

" Disable preview window on completion
set completeopt-=preview
"
" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_add_preview_to_completeopt = 0

" Neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Format Rust code on save
let g:rustfmt_autosave = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>

" NERDCommenter
" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
