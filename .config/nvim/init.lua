local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()  -- Enable the new bytecode loader for faster startup

-- Basic settings
vim.opt.compatible = false          -- Disable Vi compatibility mode for modern Vim features
vim.opt.encoding = "utf-8"          -- Set file encoding to UTF-8 for wide character support
vim.opt.filetype = "on"             -- Enable filetype detection for syntax and plugins
vim.opt.syntax = "on"               -- Enable syntax highlighting
vim.opt.softtabstop = 4             -- Number of spaces a tab counts for during editing
vim.opt.shiftwidth = 4              -- Number of spaces for each indentation level
vim.opt.tabstop = 4                 -- Number of spaces a tab character represents
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.autoindent = true           -- Copy indent from current line when starting a new line
vim.opt.showmatch = true            -- Highlight matching parentheses/brackets
vim.opt.autoread = true             -- Automatically reload files changed outside of Vim
vim.opt.fillchars:append("vert:│")  -- Use vertical bar as split separator character
vim.g.is_posix = 1                  -- Treat shell scripts as POSIX-compliant for better highlighting
vim.g.mapleader = " "               -- Set leader key to space for custom keybindings
vim.opt.wildmenu = true             -- Enable enhanced command-line completion menu
vim.opt.wildmode = {"list:longest", "full"} -- Configure wildmenu: list matches, then complete longest common string
vim.opt.ttyfast = true              -- Optimize for fast terminal connections
vim.opt.lazyredraw = true           -- Delay redraws during macros/scripts for performance
vim.opt.synmaxcol = 150             -- Limit syntax highlighting to 150 columns to avoid slowdown
vim.g.loaded_ruby_provider = 0      -- Disable Ruby provider to reduce startup time
vim.g.loaded_node_provider = 0      -- Disable Node.js provider to reduce startup time
vim.g.loaded_perl_provider = 0      -- Disable Perl provider to reduce startup time
vim.g.do_legacy_filetype = 1        -- Enable legacy filetype detection for compatibility
vim.g.python3_host_prog = "/bin/python3" -- Specify Python 3 executable for Neovim
vim.opt.termguicolors = true        -- Enable 24-bit RGB colors in the terminal
vim.opt.incsearch = true            -- Show search matches as you type
vim.opt.hlsearch = true             -- Highlight all search matches
vim.opt.scrolloff = 3               -- Keep 3 lines visible above/below cursor when scrolling
vim.opt.foldenable = false          -- Disable folding by default
--vim.opt.colorcolumn = "79,90,120"   -- Highlight columns 79, 90, and 120 for line length guidance
vim.opt.mouse = ""                  -- Explicitly disable mouse support
vim.opt.number = true               -- Show line numbers

-- settings as of 2025-05-15
vim.opt.regexpengine = 1         -- Use the old regexp engine
vim.g.matchparen_timeout = 20    -- Reduce timeout for matching parentheses
vim.g.matchparen_insert_timeout = 20
vim.opt.redrawtime = 1500        -- Maximum time spent trying to highlight syntax

-- Ensure NVM's PATH is available to Neovim
vim.env.PATH = vim.env.PATH .. ":/home/aleksey/.config/nvm/versions/node/v22.2.0/bin"

-- Define the Fullpath function in Vimscript (for lualine component)
vim.cmd([[
  function! Fullpath() abort
    let path = expand('%:p')
    if path == ''
      return '[No File]'
    endif
    return path
  endfunction
]])

-- Plugin setup with lazy.nvim
require("lazy").setup({
  { "neovim/nvim-lspconfig", -- Language Server Protocol support for code intelligence
    dependencies = {
      { "hrsh7th/nvim-cmp", -- Autocompletion plugin
        config = function()
          local cmp = require("cmp")
          cmp.setup({
            snippet = {
              expand = function(args)
                -- No-op: We're not using snippets
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<Tab>"] = cmp.mapping.select_next_item(),
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "buffer" },
            }),
            formatting = {
              format = require("lspkind").cmp_format({
                mode = "symbol_text", -- Use both symbol and text in completion menu
                preset = "codicons",  -- Use codicons for icons
                maxwidth = 50,        -- Adjust the width of the completion menu
                ellipsis_char = "…",  -- Use ellipsis for long text
              }),
            },
          })
        end,
      },
      { "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
      { "hrsh7th/cmp-buffer" },   -- Buffer source for nvim-cmp
      { "onsails/lspkind.nvim" }, -- Icons for completion menu
      { "williamboman/mason.nvim", -- Manage LSP servers, DAP servers, linters, and formatters
        build = ":MasonUpdate",
        config = function()
          require("mason").setup()
        end,
      },
      { "jay-babu/mason-nvim-dap.nvim", -- Bridge between mason.nvim and nvim-dap for debugging
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        config = function()
          require("mason-nvim-dap").setup({
            ensure_installed = { "python" },
            automatic_setup = true,
            handlers = {},
          })
        end,
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Python LSP with basedpyright
      lspconfig.basedpyright.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          print("BasedPyright LSP attached to buffer " .. bufnr)
        end,
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
            typeCheckingMode = "basic",
            reportMissingTypeStubs = "none",
            reportCallIssue = "none"
          }
        }
      })
      
      -- Ruff LSP for Python linting/formatting
      lspconfig.ruff.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          print("Ruff LSP attached to buffer " .. bufnr)
          -- Disable hover in favor of basedpyright
          client.server_capabilities.hoverProvider = false
        end,
      })
      
      -- Terraform LSP
      lspconfig.terraformls.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          print("Terraform LSP attached to buffer " .. bufnr)
        end,
        filetypes = { "terraform", "tf", "terraform-vars" },
      })
    end,
  },
  { "nvim-lua/plenary.nvim", lazy = true }, -- Utility functions library for Neovim plugins
  { "nvim-neotest/nvim-nio", lazy = true }, -- Async I/O library for Neovim plugins
  { "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  }, -- Git diff viewer with side-by-side comparison
  { "NeogitOrg/neogit",
    cmd = "Neogit", -- Git integration with a Magit-like interface
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope.nvim", lazy = true },
      { "sindrets/diffview.nvim", lazy = true },
      config = function()
        require("neogit").setup({
          disable_signs = false, -- Enable signs in the gutter
          disable_context_highlighting = false, -- Enable context highlighting
          disable_commit_confirmation = true, -- Disable commit confirmation prompt
          integrations = {
            diffview = true, -- Integrate with diffview.nvim
            telescope = true, -- Integrate with telescope.nvim
          },
          sections = {
            untracked = { folded = true, hidden = false }, -- Fold untracked files by default
            unstaged = { folded = false, hidden = false },   -- Fold unstaged changes by default
            staged = { folded = false, hidden = false },      -- Fold staged changes by default
            stashes = { folded = true, hidden = false },     -- Fold stashes by default
            unpulled = { folded = true },    -- Fold unpulled changes by default
            unmerged = { folded = false, hidden = false },    -- Fold unmerged changes by default
            recent = { folded = false, hidden = false },       -- Fold recent commits by default
          },
        })
      end,
    },
  },
  { "nvim-lualine/lualine.nvim", -- Statusline plugin with customizable sections
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "OceanicNext",
          icons_enabled = true,
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics"},
          lualine_c = { { "filename", file_status=true, path=3, padding = { left = 1, right = 1 } } },
          --lualine_c = { 
          --  { 
          --    function() 
          --      return vim.bo.modified and "[+]" or "" 
          --    end,
          --    color = { fg = "#FF5555" },
          --  },
          --},
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 
            "filename",
            { 
              function() 
                return vim.bo.modified and "[+]" or "" 
              end,
              color = { fg = "#FF5555" },
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  { "chentoast/marks.nvim", -- Enhanced mark management and visualization
    event = "BufReadPost",
    config = function()
      require("marks").setup({
        default_mappings = true,
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 150,
      })
    end,
  },
  { "majutsushi/tagbar", cmd = "TagbarToggle" }, -- Display tags (functions, variables) in a sidebar
  { "Raimondi/delimitMate", event = "InsertEnter" }, -- Auto-close brackets, quotes, etc.
  { "mbbill/undotree", cmd = "UndotreeToggle" }, -- Visualize undo history as a tree
  { "justinmk/vim-sneak", event = "BufReadPost" }, -- Enhanced motion with two-character search
  { "lewis6991/gitsigns.nvim", event = "BufReadPost" }, -- Git signs (added/changed/deleted) in the gutter
  { "fatih/vim-go", ft = "go", -- Go development plugin with formatting and highlighting
    init = function()
      vim.g.go_fmt_command = "goimports"
      vim.g.go_highlight_types = 1
      vim.g.go_list_type = "quickfix"
      vim.g.go_auto_type_info = 1
    end,
  },
  { "goolord/alpha-nvim", -- Dashboard/start screen for Neovim
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local theta = require("alpha.themes.theta")
      local dashboard = require("alpha.themes.dashboard")
      theta.header.val = {}
      local mru_section = {
        type = "group",
        val = function()
          local oldfiles = vim.v.oldfiles or {}
          local buttons = {}
          local counter = 0
          for _, file in ipairs(oldfiles) do
            if counter >= 10 then break end
            if vim.fn.filereadable(file) == 1 then
              local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(vim.fn.fnamemodify(file, ":e"))
              local filename = vim.fn.fnamemodify(file, ":t")
              local path = vim.fn.fnamemodify(file, ":h")
              local button = {
                type = "button",
                val = (icon or " ") .. " " .. filename .. " (" .. path .. ")",
                on_press = function()
                  vim.cmd(":e " .. file)
                end,
                opts = {
                  position = "left",
                  hl = nil,
                  shrink_margin = false,
                },
              }
              table.insert(buttons, button)
              counter = counter + 1
            end
          end
          return {
            { type = "text", val = "Recent Files", opts = { hl = "SpecialComment", position = "left" } },
            { type = "padding", val = 1 },
            { type = "group", val = buttons, opts = { spacing = 0, position = "left" } },
          }
        end,
        opts = { shrink_margin = false, position = "left" },
      }
      local buttons_section = {
        type = "group",
        val = {
          { type = "text", val = "Quick Actions", opts = { hl = "SpecialComment", position = "left" } },
          { type = "padding", val = 1 },
          { type = "group",
            val = {
              { type = "button", val = "Neovim Config", on_press = function() vim.cmd(":edit ~/.config/nvim/init.lua") end, opts = { position = "left", hl = nil } },
              { type = "button", val = "New File", on_press = function() vim.cmd(":ene <BAR> startinsert") end, opts = { position = "left", hl = nil } },
              { type = "button", val = "Quit", on_press = function() vim.cmd(":qa") end, opts = { position = "left", hl = nil } },
            },
            opts = { spacing = 0, position = "left", align = "left" },
          },
        },
        opts = { position = "left" },
      }
      local footer_section = {
        type = "text",
        val = "Loaded " .. require("lazy").stats().count .. " plugins",
        opts = { hl = "Comment", position = "left" },
      }
      theta.config.layout = {
        { type = "padding", val = 2 },
        mru_section,
        { type = "padding", val = 2 },
        buttons_section,
        { type = "padding", val = 1 },
        footer_section,
      }
      alpha.setup(theta.config)
    end,
  },
  { "Rigellute/shades-of-purple.vim", -- Shades of Purple colorscheme
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd("colorscheme shades_of_purple")
      vim.cmd([[
        hi MatchParen cterm=underline,reverse ctermfg=NONE gui=underline,bold guibg=NONE guifg=NONE
      ]])
    end,
  },
  { "folke/tokyonight.nvim", -- Tokyo Night colorscheme with multiple styles
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
    },
  },
  { "catppuccin/nvim", name = "catppuccin", -- Catppuccin colorscheme with flavor options
    lazy = true,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      term_colors = true,
    },
  },
  { "LunarVim/bigfile.nvim", -- Optimize handling of large files
    lazy = true,
    enabled = false,
  },
  { "sainnhe/gruvbox-material", -- Gruvbox Material colorscheme with soft/hard variants
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  { "mfussenegger/nvim-dap-python", -- Python debugging support for nvim-dap
    ft = "python",
    config = function()
      require("dap-python").setup("/usr/bin/python")
    end,
  },
  { "theHamsta/nvim-dap-virtual-text", -- Show debug variables as virtual text
    event = "VeryLazy",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  { "navarasu/onedark.nvim", -- One Dark colorscheme with customizable styles
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "dark",
      })
      vim.cmd("colorscheme onedark")
    end,
  },
  { "liuchengxu/space-vim-dark", -- Space Vim Dark colorscheme
    lazy = true,
    config = function()
      vim.cmd("colorscheme space-vim-dark")
    end,
  },
  { "altercation/vim-colors-solarized", -- Solarized colorscheme with light/dark modes
    lazy = true,
    config = function()
      vim.g.solarized_termcolors = 256
      vim.cmd("colorscheme solarized")
    end,
  },
  { "jnurmine/Zenburn", -- Zenburn colorscheme with a warm, low-contrast look
    lazy = true,
    config = function()
      vim.cmd("colorscheme zenburn")
    end,
  },
  { "nvim-neo-tree/neo-tree.nvim", cmd = "Neotree", -- File explorer with tree-style navigation
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"},
  },
  { "mfussenegger/nvim-dap", event = "VeryLazy", -- Debug Adapter Protocol client for debugging
    config = function()
      local dap = require("dap")
      dap.configurations = {
        python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then return cwd .. "/.venv/bin/python"
              else return "/usr/bin/python" end
            end,
          },
        },
        lua = {
          { type = "nlua", request = "attach", name = "Attach to running Neovim instance" }
        }
      }
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
    end,
  },
  { "rcarriga/nvim-dap-ui", event = "VeryLazy", -- UI for nvim-dap with variable inspection
    dependencies = {"mfussenegger/nvim-dap"},
    config = function() require("dapui").setup() end,
  },
  { "nvim-telescope/telescope.nvim", cmd = "Telescope", -- Fuzzy finder for files, buffers, and more
    dependencies = {"nvim-lua/plenary.nvim"}
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", -- Syntax highlighting and parsing with Treesitter
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"python", "lua", "go", "javascript", "terraform" },
        highlight = { enable = true },    -- Enable syntax highlighting
        incremental_selection = { enable = true },
        textobjects = { enable = true }   -- Enable text objects for easier code manipulation
      })
    end,
  },
  { "folke/which-key.nvim", event = "VeryLazy", -- Display keybinding hints in a popup
    config = function()
      require("which-key").setup({
        notify = false
      })
      -- Register group descriptions
      require("which-key").register({
        ["<leader>p"] = { name = "Python" },
      })
    end,
  },
  { "github/copilot.vim", event = "InsertEnter", -- GitHub Copilot for AI-powered code suggestions
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = { python = true, lua = true, go = true, terraform = true }
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })
      vim.keymap.set("i", "<C-Right>", 'copilot#AcceptWord()', { expr = true, silent = true, replace_keycodes = false })
    end,
  },
})

-- Autocommands
vim.defer_fn(function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {"javascript", "html", "ts"},
    callback = function()
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
      -- Indentation (PEP 8 standard)
      vim.opt_local.tabstop = 4          -- Width of a tab character
      vim.opt_local.softtabstop = 4      -- Number of spaces a tab counts for during editing
      vim.opt_local.shiftwidth = 4       -- Number of spaces for each indentation level
      vim.opt_local.expandtab = true     -- Convert tabs to spaces

      -- Search path for imports
      vim.opt_local.path:append("**")    -- Search in all subdirectories

      -- Python-specific settings
      vim.b.python_highlight_all = 1     -- Enable all Python syntax highlighting features

      -- For LSP
      -- vim.b.coc_root_patterns = {".git", ".env", "pyproject.toml", "setup.py"}

      -- Format with Ruff
      vim.keymap.set("n", "<leader>pf", function()
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "ruff"
          end,
          async = true
        })
      end, { buffer = true, desc = "Format Python with Ruff"})

      -- Organize imports with Ruff
      vim.keymap.set("n", "<leader>pi", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end, { buffer = true, desc = "Organize Python imports"})

      -- Fix all auto-fixable issues
      vim.keymap.set("n", "<leader>px", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.fixAll" } },
          apply = true,
        })
      end, { buffer = true, desc = "Fix all Python issues" })
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function() vim.keymap.set("n", "<leader>gi", "<Plug>(go-install)", { buffer = true }) end,
  })
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.sh", "*.py", "*.js", "*.yaml", "*.html", "*.groovy"},
    callback = function() vim.cmd("%s/\\s\\+$//e") end,
  })
  vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "*grep*",
    command = "cwindow",
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
      vim.opt_local.tabstop = 2       -- Number of spaces a tab character represents
      vim.opt_local.shiftwidth = 2    -- Number of spaces for each indentation level
      vim.opt_local.softtabstop = 2   -- Number of spaces a tab counts for during editing
      vim.opt_local.expandtab = true  -- Convert tabs to spaces
    end,
  })

end, 100)

-- functions
local functions = require('custom.functions')

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "html", "ts"},
  callback = function() vim.opt_local.tabstop = 2 vim.opt_local.shiftwidth = 2 end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.opt_local.tabstop = 4 vim.opt_local.shiftwidth = 4 vim.b.coc_root_patterns = {".git", ".env"} end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function() vim.keymap.set("n", "<leader>gi", "<Plug>(go-install)", { buffer = true }) end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.sh", "*.py", "*.js", "*.yaml", "*.html", "*.groovy"},
  callback = function() vim.cmd("%s/\\s\\+$//e") end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    vim.lsp.start_client(require("lspconfig").pyright)
  end,
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  command = "cwindow",
})

-- Key mappings
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
    vim.keymap.set("n", "<leader>x", ":ccl<CR>")
    vim.keymap.set("n", "<leader>z", ":Neotree toggle<CR>")
    vim.keymap.set("n", "<leader>t", ":TagbarToggle<CR>")
    vim.keymap.set("n", "<leader>y", ":tabprev<CR>")
    vim.keymap.set("n", "<leader>u", ":tabfirst<CR>")
    vim.keymap.set("n", "<leader>i", ":tablast<CR>")
    vim.keymap.set("n", "<leader>o", ":tabnext<CR>")
    vim.keymap.set("n", "<leader>w", ":w<CR>")
    vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
    vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
    vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
    vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
    vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic message' })
    vim.keymap.set({"n", "i"}, "<C-S>", ":w<CR>")
    vim.keymap.set("n", "<M-w>", "<C-W>", { noremap = true, silent = true })  -- Map Alt-W to do the same as Ctrl-W, much easier to access
    -- DAP mappings
    vim.keymap.set("n", "<F5>", function() require('dap').continue() end)
    vim.keymap.set("n", "<F10>", function() require('dap').step_over() end)
    vim.keymap.set("n", "<F11>", function() require('dap').step_into() end)
    vim.keymap.set("n", "<F12>", function() require('dap').step_out() end)
    vim.keymap.set("n", "<Leader>b", function() require('dap').toggle_breakpoint() end)
    vim.keymap.set("n", "<F4>", function() require('dapui').toggle() end)
    -- Telescope mappings
    vim.keymap.set('n', 'sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', 'rg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, { buffer = bufnr, desc = "Go to definition" })
  end,
})

-- Commands
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.keymap.set("", "X", "x", { noremap = true })
