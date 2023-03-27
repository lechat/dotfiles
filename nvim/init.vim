set nocompatible
filetype off

set encoding=utf-8
scriptencoding utf-8

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc

call plug#begin()
" My Plugs here:
"
" original repos on github
" Plug 'tpope/vim-commentary'
" Comments lines on pressing \\\ (3 times \)
" Plug 'scrooloose/nerdcommenter'
" Comments by <leader>cc
Plug 'python-mode/python-mode'
"Plug 'nvie/vim-flake8'
" Provides pylint, flake8, python key binding, etc.
Plug 'vim-syntastic/syntastic'
" Syntax checks
Plug 'tpope/vim-fugitive'
" Git plugin
" Plug 'motemen/git-vim'
" Git commands
Plug 'dkprice/vim-easygrep'
" Grep plugin
Plug 'scrooloose/nerdtree'
" Filesystem manipulation
Plug 'ctrlpvim/ctrlp.vim'
" Find files on Ctrl+P press
"Plug 'Lokaltog/vim-powerline.git'
Plug 'itchyny/lightline.vim'
" Better status line
"Plug 'tpope/vim-unimpaired'
" --  Navigate quickfix list with ]q and ]Q
Plug 'majutsushi/tagbar'
" Show tags in source file
" -- Plug 'kien/tabman.vim'
" work with tabs from keyboard - <leader>mf <leader>mt
Plug 'altercation/vim-colors-solarized'
" Solarized color scheme
" Plug 'dracula/vim'
" Dracula color scheme
" Plug 'tomasr/molokai'
" Molokai colorscheme
" Plug 'VOoM'
" Outline plugin for asciidoc, etc.
" Plug 'mileszs/ack.vim'
" Helper to use ack command from inside vim
Plug 'Raimondi/delimitMate'
" Autoclose ",brackets
Plug 'mbbill/undotree'
" Plug 'goldfeld/vim-seek'
Plug 'justinmk/vim-sneak'
" Adds s/S navigation
" Mutiline s/S navigation
" Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
" Shows git changes in gutter column
Plug 'jistr/vim-nerdtree-tabs'
" same Nerdtree in all tabs
" Plug 'Shougo/vimproc.vim'
" async execution, required for Unite
" Plug 'Shougo/unite.vim'
" united search
"Plug 'gregsexton/gitv'
Plug 'junegunn/gv.vim'
" Git log viewer
Plug 'Yggdroot/indentLine'
" Show vertical lines at indentation level
"Plug 'dannyob/quickfixstatus'
" Show errors in last line
Plug 'idanarye/vim-merginal'
" View git branches
Plug 'tmux-plugins/vim-tmux-focus-events'
" Allows pasting in terminal w/o set paste
Plug 'fatih/vim-go'
" Golang in vim
Plug 'jnurmine/Zenburn'
" Coloscheme
" --Plug 'tacahiroy/ctrlp-funky'
" CtrlP for functions
Plug 'kshenoy/vim-signature'
" Show marks in gutter
Plug 'mhinz/vim-startify'
"Plug 'SirVer/ultisnips'
" Snippets
"Plug 'ervandew/supertab'
" expand everything by tab
" Plug 'rust-lang/rust.vim'
" Rust language support
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
" Autogenerate tags
Plug 'pangloss/vim-javascript'
Plug 'dracula/vim'
Plug 'tpope/vim-dispatch'
Plug 'lmintmate/blue-mood-vim'
Plug 'dylanaraps/wal.vim'
Plug 'liuchengxu/space-vim-dark'
" Bazel support
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
" Colorcheme
Plug 'Rigellute/shades-of-purple.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Completion plugin
Plug 'sainnhe/gruvbox-material'
" Colorscheme
Plug 'github/copilot.vim'
" Copilot plugin
Plug 'prabirshrestha/async.vim'
Plug 'stackline/vim-asynctags'
" Asynctags
call plug#end()
" Turn off features that I don't use
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
" Disable LUA filetype processing
let g:do_legacy_filetype = 1

let g:python3_host_prog = '/bin/python3'
filetype plugin indent on

:syntax on
set nocompatible
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set showmatch
set autoread
set fillchars+=vert:\|
let g:is_posix=1

let mapleader = "\<Space>"

set wildmenu
set wildmode=list:longest,full

" Attempting to speedup raspberry
set re=1
set ttyfast
set lazyredraw
"set synmaxcol=150               " Show syntax colors only for 150 chars in line

" let g:Powerline_colorscheme="default_mod.vim"
" let g:Powerline_symbols="unicode"
" let g:Powerline_stl_path_style="relative"

" Remove mouse support from nvim. Can't find a way for selection/clipboard to
" behave
set mouse=

" Colors
set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors
set background=light
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"let base16colorspace=256  " Access colors present in 256 colorspace"

" colorscheme zenburn
" colorscheme wombat
" colorscheme solarized
" colorscheme dracula
" colorscheme lunaperche
" colorscheme blue-mood
" colorscheme zenburn
" colorscheme skeletor
" colorscheme dracula
colorscheme molokai
" colorscheme dracula
" colorscheme space-vim-dark
" colorscheme shades_of_purple
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_ui_contrast = 'high'
let g:lightline = {'colorscheme' : 'gruvbox_material'}
colorscheme gruvbox-material
"
" let g:rehash256 = 1     " Molokai specific setting"

" Tabstops for different filetype
autocmd FileType javascript,html setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4

"
" Use deoplete.
"let g:deoplete#enable_logging("DEBUG", "/tmp/deoplete.log")
let g:deoplete#enable_at_startup = 1

" indentLine plugin hides quotes in json, below line will disable identLine in
" JSON, but quotes will be visible
let g:vim_json_conceal=0

if has('gui_running')
  set guioptions-=T " remove the toolbar
  set gfn=Source\ Code\ Pro\ for\ Powerline\ Semi-Bold\ 11
  set lines=999
  set columns=999
  winpos 1 1
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
  " let g:Powerline_symbols = 'fancy'
  " colorscheme solarized
  "set listchars=tab:Â»Â·,trail:Â·
else
  " colorscheme wombat
  hi CursorLine cterm=NONE ctermbg=8
  " set listchars=tab:Â»Â·,trail:Â·
endif

" highlight Pmenu guibg=RoyalBlue

filetype on
set nu
" set rnu
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
set nobackup

set ruler " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)%{fugitive#statusline()} " a ruler on steroids
set showcmd " show partial commands in status line and
set laststatus=2 " Always show the statusline

set backspace=indent,eol,start

set incsearch " find as you type search
set hlsearch " highlight search terms

set scrolloff=3 " minimum lines to keep above and below cursor

" I hate folding!
set nofoldenable
set foldmethod=manual

" coc.vim - enable completion choice on CR
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#_select_confirm() :
\ coc#expandableOrJumpable() ?
\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\ CheckBackspace() ? "\<TAB>" :
\ coc#refresh()

function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

noremap <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
noremap <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
noremap <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
noremap <silent> <C-Right> :<C-U>ObviousResizeRight<CR>

let g:easytags_async = 1
let g:easytags_autorecurse = 0
let g:easytags_python_enabled = 1

" Options for Pylint-mode
" let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
let g:PyLintCWindow = 1
" let g:PyLintSigns = 1
let g:PyLintOnWrite = 1
let g:PyLintOnOpen = 0
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

autocmd BufWritePre *.sh call TrimWhiteSpace()
autocmd BufWritePre *.py call TrimWhiteSpace()
autocmd BufWritePre *.js call TrimWhiteSpace()
autocmd BufWritePre *.yaml call TrimWhiteSpace()
autocmd BufWritePre *.html call TrimWhiteSpace()
autocmd BufWritePre *.groovy call TrimWhiteSpace()

"autocmd BufWritePost *.py call Flake8()

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
set grepprg=grep
let g:EasyGrepRecursive = 1
let g:EasyGrepCommand = 1
let g:EasyGrepFilesToExclude = ".git"
let g:EasyGrepFilesToExclude=".git,*.tar*,*.zip,tags"

" This command will open all grep results in quickfix window
autocmd QuickFixCmdPost *grep* cwindow

"let g:pymode_debug = 1
let g:pymode = 1
let g:pymode_python = 'python3'
let g:pymode_python_version = '3.10.6'
let g:pymode_options_max_line_length = 79
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 0
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_options_pylint = "$HOME/.pylintrc"
let g:pymode_lint_onfly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pycodestyle', 'pep8']
let g:pymode_lint_ignore = ["C901"]
let g:pymode_lint_options_mccabe = { 'complexity': 12 }
" Disable showing Python docs on K
let g:pymode_doc = 0
let g:pymode_folding = 0

let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_breakpoint_cmd = 'import pudb; pu.db'

" vim-go
set autowrite
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
autocmd FileType go nmap <leader>gi <Plug>(go-install)


" Fugitive
nnoremap <leader>gg :Git<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>gpl :GitPullRebase<CR>
nnoremap <leader>gps :Git push<CR>
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

" set colorcolumn=79,90,120
" highlight ColorColumn ctermbg=17

" Unite stuff
"let g:unite_data_directory='~/.vim/.cache/unite'
"let g:unite_enable_start_insert=0
"let g:unite_source_history_yank_enable=1
"let g:unite_source_rec_max_cache_files=5000
"let g:unite_prompt='Â» '

"call unite#custom#source('file,file/new,buffer,file_rec/async', 'matchers', 'matcher_fuzzy')
"nnoremap <silent> <leader><space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
"nnoremap <silent> <leader><space>f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
"nnoremap <silent> <leader><space>y :<C-u>Unite -buffer-name=yanks history/yank<cr>
"nnoremap <silent> <leader><space>l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
"nnoremap <silent> <leader><space>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
"nnoremap <silent> <leader><space>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
"nnoremap <silent> <leader><space>m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
"nnoremap <silent> <leader><space>s :<C-u>Unite -quick-match buffer<cr>

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
      \ 'colorscheme': 'Tomorrow_Night_Blue',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head(8)
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction


let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Disable preview window on completion
set completeopt-=preview
"
" YouCompleteMe
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_add_preview_to_completeopt = 0

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>""
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" pytest conversion macros
let @e = '^cf(assert f,xi ==Akbj'
let @t = '^cf(assert Akb is Truej'
let @i = '^ct(assert isinstanceA is Truej'
let @r = '^ssect(pytest.raises'
" CtrlP-funky
" nnoremap <Leader>fu :CtrlPFunky<Cr>

" Format Rust code on save
let g:rustfmt_autosave = 1
"nnoremap <Leader>fu :CtrlPFunky<Cr>

" Clap-vim
" nnoremap <Leader>n :Clap<CR>

" NERDCommenter
" Align line-wise comment delimiters flush left instead of following code
" indentation
" let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

augroup ProjectSetup
    au BufRead,BufEnter /home/aleksey/src/AlexaPi/* set noet ci pi sts=0 sw=4 ts=4
augroup END

" DelimitMate
let delimitMate_backspace = 1
let delimitMate_backspace = 1

let g:go_version_warning = 0

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 0

let g:deoplete#enable_at_startup = 1
