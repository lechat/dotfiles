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
    "neovim/nvim-lspconfig",
    "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "sindrets/diffview.nvim",
    {
        "NeogitOrg/neogit",
        -- branch = "commentChar",
        -- dev = true, 
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
        },
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
    -- "kshenoy/vim-signature",
    "chentoast/marks.nvim",
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
    "pocco81/dap-buddy.nvim",
    "mfussenegger/nvim-dap-python",
    {
        "rcarriga/nvim-dap-ui"
    },
    {
      "theHamsta/nvim-dap-virtual-text"
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                plugins = {
                    registers = false
                }
            }
        end,
    },
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "jbyuki/one-small-step-for-vimkind",
}, {
    dev = {
      path = "~/src"
    }
})
local set = vim.opt
local cmd = vim.cmd
local let = vim.g
local lett = vim.o
local map = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

vim.diagnostic.config({virtual_text=true})
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
set.fillchars = { vert = '│' }
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

local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

autocmd('FileType', {
    pattern = 'python',
    command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4',
})
autocmd({ "BufWritePost" }, {
    pattern = '*.py',
    callback = function()
        local fn = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !black -q -l 79 " .. fn)
        vim.cmd(":silent !isort --profile black --float-to-top -q " .. fn)
        vim.cmd(":silent !docformatter --in-place --wrap-summaries 79 --wrap-descriptions 79 " .. fn)
    end,
    group = autocmd_group
})
autocmd('FileType', {
    pattern = {'javascript', 'html', 'bash'},
    command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2',
    group = autocmd_group
})

-- All plugin configurations
--
require("mason").setup()
require("neodev").setup({
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = { "nvim-dap-ui" }, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- for your Neovim config directory, the config.library settings will be used as is
  -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
  -- for any other directory, config.library.enabled will be set to false
  override = function(root_dir, options) end,
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = true,
  -- much faster, but needs a recent built of lua-language-server
  -- needs lua-language-server >= 3.6.0
  pathStrict = true,
})
require('coc')
require("dapui").setup(
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "right",
        size = 40
      }, {
        elements = { {
            id = "repl",
            size = 0.5
          }, {
            id = "console",
            size = 0.5
          } },
        position = "bottom",
        size = 10
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
)
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

require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },
    autoinstall = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require("nvim-dap-virtual-text").setup()

-- document existing key chains
require('which-key').register {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
require("neogit").setup {
  disable_insert_on_commit = true,
  graph_style = "unicode",
  disable_editor_help = false,
  sections = {
    stashes = {
      folded = false,
      hidden = false
    }
  }
}
require("marks").setup {
}
local dap = require("dap")
dap.configurations = {
  python = {
      {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                  return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                  return cwd .. "/.venv/bin/python"
              else
                  return "/usr/bin/python"
              end
          end,
      },
  },
  lua = { 
    { 
      type = 'nlua', 
      request = 'attach',
      name = "Attach to running Neovim instance",
    }
  }
}
dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end
-- End of setup section

-- Key mappings
--
-- DAP
vim.keymap.set("n", "<F4>", function() require('dapui').toggle() end)
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


vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")
vim.keymap.set("n", "<leader>z", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader>t", ":TagbarToggle<CR>")
vim.keymap.set("n", "<leader>y", ":tabprev<CR>")
vim.keymap.set("n", "<leader>u", ":tabfirst<CR>")
vim.keymap.set("n", "<leader>i", ":tablast<CR>")
vim.keymap.set("n", "<leader>o", ":tabnext<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- vim.keymap.set("n", "<C-Up>", ":<C-U>ObviousResizeUp<CR>")
-- vim.keymap.set("n", "<C-Down>", ":<C-U>ObviousResizeDown<CR>")
-- vim.keymap.set("n", "<C-Left>", ":<C-U>ObviousResizeLeft<CR>")
-- vim.keymap.set("n", "<C-Right>", ":<C-U>ObviousResizeRight<CR>")
-- vim: set ts=2 sw=2 tw=0 et :
