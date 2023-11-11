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
--    "python-mode/python-mode",
--    "vim-syntastic/syntastic",
    "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
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
    "itchyny/lightline.vim",
    "majutsushi/tagbar",
    "Raimondi/delimitMate",
    "mbbill/undotree",
    "justinmk/vim-sneak",
--    "airblade/vim-gitgutter",
    "lewis6991/gitsigns.nvim",
    "junegunn/gv.vim",
--    "Yggdroot/indentLine",
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
    "dylanaraps/wal.vim",
    -- 
    "kshenoy/vim-signature",
    "mhinz/vim-startify",
    "pangloss/vim-javascript",
    -- "tpope/vim-dispatch",
    --"google/vim-maktaba",
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
    --"stackline/vim-asynctags",
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    "pedrohdz/vim-yaml-folds",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
    },
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
cmd('colorscheme shades_of_purple')
require("ibl").setup()

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- DAP
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = '[S]earch [T]reesitter' })

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
