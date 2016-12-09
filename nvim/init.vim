call plug#begin('~/.vim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-fugitive'
" Git plugin
Plug 'motemen/git-vim'
" Git commands
Plug 'junegunn/gv.vim'
" Git log viewer
Plug 'vim-scripts/EasyGrep'
" Grep plugin
Plug 'klen/python-mode'
Plug 'mbbill/undotree'
" Plugin 'goldfeld/vim-seek'
Plug 'justinmk/vim-sneak'
" Adds s/S navigation
Plug 'altercation/vim-colors-solarized'
" Solarized color scheme
Plug 'airblade/vim-gitgutter'
" Shows git changes in gutter column
Plug 'jistr/vim-nerdtree-tabs'
" same Nerdtree in all tabs
Plug 'tmux-plugins/vim-tmux-focus-events'
" Allows pasting in terminal w/o set paste
Plug 'kshenoy/vim-signature'
" Show marks in gutter
Plug 'mhinz/vim-startify'
" Custom start page
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

:syntax on
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set showmatch
set synmaxcol=150               " Show syntax colors only for 150 chars in line
set autoread
let g:is_posix=1
set nu
set rnu
set nobackup
set ruler " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)%{fugitive#statusline()} " a ruler on steroids
set showcmd " show partial commands in status line and
set scrolloff=3 " minimum lines to keep above and below cursor
set wildmode=list:longest,full

set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors
set background=dark
" let base16colorspace=256  " Access colors present in 256 colorspace"
" colorscheme zenburn
" colorscheme wombat
colorscheme solarized
set cursorline                  " hilight cursor line
set cursorcolumn                " and column

set colorcolumn=79,120
highlight ColorColumn ctermbg=17
highlight ExtraWhitespace ctermbg=red guibg=red

" No folding
set nofoldenable
set foldmethod=manual

let mapleader = "\<Space>"
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

command Q q
command W w
command Qa qa
cnoreabbrev X x

" Options for Pylint-mode
" let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0232,E1120,R0903,R0904,R0913,R0914,W0622'
let g:PyLintCWindow = 1
" let g:PyLintSigns = 1
let g:PyLintOnWrite = 1
let g:pymode = 1
let g:pymode_options_max_line_length = 79
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 0
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_config = "$HOME/.pylintrc"
let g:pymode_lint_onfly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pylint']
" Disable showing Python docs on K
let g:pymode_doc = 0
let g:pymode_folding = 0
" No Rope
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1

let NERDTreeIgnore = ['\.pyc$', '\.class$']

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
"
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

nnoremap <leader>y :tabprev<CR>
nnoremap <leader>u :tabfirst<CR>
nnoremap <leader>i :tablast<CR>
nnoremap <leader>o :tabnext<CR>

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

