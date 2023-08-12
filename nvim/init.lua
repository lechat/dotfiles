vim.cmd('source ~/dotfiles/nvim/init.vim')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "python-mode/python-mode",
--    "vim-syntastic/syntastic",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
        },
        config = true
    },
    "dkprice/vim-easygrep",
    "scrooloose/nerdtree",
    "itchyny/lightline.vim",
    "majutsushi/tagbar",
    "Raimondi/delimitMate",
    "mbbill/undotree",
    "justinmk/vim-sneak",
    "airblade/vim-gitgutter",
    "junegunn/gv.vim",
    "Yggdroot/indentLine",
    --"idanarye/vim-merginal",
    "tmux-plugins/vim-tmux-focus-events",
    "fatih/vim-go",
    -- Color schemes
    "jnurmine/Zenburn",
    "dracula/vim",
    "navarasu/onedark.nvim",
    "altercation/vim-colors-solarized",
    "lmintmate/blue-mood-vim",
    "Rigellute/shades-of-purple.vim",
    "liuchengxu/space-vim-dark",
    "sainnhe/gruvbox-material",
    -- 
    "kshenoy/vim-signature",
    "mhinz/vim-startify",
    "pangloss/vim-javascript",
    "tpope/vim-dispatch",
    "dylanaraps/wal.vim",
    "google/vim-maktaba",
    {"neoclide/coc.nvim", branch = "release"},
    "github/copilot.vim",
    "prabirshrestha/async.vim",
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        }
    },
    "stackline/vim-asynctags",
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    }
})
local set = vim.opt
local cmd = vim.cmd
local let = vim.g
local lett = vim.o
local map = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

--set.nocompatible = true
set.encoding = 'utf-8'
--set.scriptencoding = 'utf-8'
set.runtimepath:append('~/.vim')
set.runtimepath:append('~/.vim/after')
set.softtabstop = 4
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.autoindent = true
set.showmatch = true
set.autoread = true
set.fillchars = { vert = '|' }
set.wildmode = { 'longest', 'list', 'full' }
set.wildmenu = true
set.re = 1
set.ttyfast = true
set.lazyredraw = true
set.mouse = ''
--set.t_Co = '256'
set.background = 'dark'
set.termguicolors = true
set.nu = true
set.updatetime = 100
set.signcolumn = 'yes'
--set.nobackup = true
set.ruler = true
set.showcmd = true
set.laststatus = 2
set.backspace = 'indent,eol,start'
set.incsearch = true
set.hlsearch = true
set.scrolloff = 3
set.foldenable = false
set.foldmethod = 'manual'
set.wildignore = '*.sw*,*.pyc,*.class'
set.grepprg = 'grep'
set.autowrite = true
set.backup = false
set.writebackup = false
set.signcolumn = 'yes'
--map('n', '<Space>', '', {})
--vim.g.mapleader = ' '

let.loaded_ruby_provider = 0
let.loaded_node_provider = 0
let.loaded_perl_provider = 0

let.python3_host_prog = '/bin/python3'

let.is_posix = 1
let.vim_json_conceal = 0

let.easytags_async = 1
let.easytags_python_enabled = 1
let.easytags_autoresume = 1

let.PylintCWindow = 1
let.PylintOnWrite = 1
let.PylintOnOpen = 0

let.EasyGrepRecursive = 1
let.EasyGrepCommand = 1
let.EasyGrepFilesToExclude = ".git,*.tar*,*.zip,tags"

--let.gruvbox_material_foreground = 'original'
--let.gruvbox_material_background = 'hard'
--let.gruvbox_material_better_performance = 1
--let.gruvbox_material_ui_contrast = 'high'
--let.lightline = {colorscheme= 'gruvbox_material'}

--let.pymode_debug = 1
let.pymode = 1
let.pymode_python = 'python3'
let.pymode_python_version = '3.10.6'
let.pymode_options_max_line_length = 79
let.pymode_indent = 1
let.pymode_motion = 1
let.pymode_virtualenv = 1
let.pymode_run = 0
let.pymode_breakpoint = 1
let.pymode_breakpoint_bind = '<leader>b'
let.pymode_lint = 1
let.pymode_lint_on_write = 1
let.pymode_lint_options_pylint = "$HOME/.pylintrc"
let.pymode_lint_onfly = 0
let.pymode_lint_message = 1
let.pymode_lint_checkers = {'pyflakes', 'pycodestyle', 'pep8'}
let.pymode_lint_ignore = {"C901"}
let.pymode_lint_options_mccabe = { complexity = 12 }
-- Disable showing Python docs on K
let.pymode_doc = 0
let.pymode_folding = 0

let.pymode_rope = 0
let.pymode_rope_completion = 0
let.pymode_rope_complete_on_dot = 0

let.pymode_syntax = 1
let.pymode_syntax_slow_sync = 1
let.pymode_syntax_all = 1
let.pymode_breakpoint_cmd = 'import pudb; pu.db'

let.go_fmt_command = "goimports"
let.go_highlight_types = 1
let.go_list_type = "quickfix"
let.go_auto_type_info = 1
let.go_version_warning = 0

let.indentLine_char = '·'

let.startify_change_to_dir = 0
let.startify_change_to_vcs_root = 1
let.startify_change_to_dir = 0

autocmd('FileType', {
    pattern = 'python',
    command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4'
})
autocmd('FileType', {
    pattern = {'javascript', 'html'},
    command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2'
})

require('coc')
--
-- Onedark colorscheme config
require('onedark').setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = "<leader>od", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require('onedark').load()
--cmd('colorscheme onedark')
