local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.filetype = "on"
vim.opt.syntax = "on"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.showmatch = true
vim.opt.autoread = true
vim.opt.fillchars:append("vert:│")
vim.g.is_posix = 1
vim.g.mapleader = " "
vim.opt.wildmenu = true
vim.opt.wildmode = {"list:longest", "full"}
vim.opt.re = 1
vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 150
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.do_legacy_filetype = 1
vim.g.python3_host_prog = "/bin/python3"
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 3
vim.opt.foldenable = false
vim.opt.colorcolumn = "79,90,120"

-- Ensure NVM's PATH is available to Neovim
vim.env.PATH = vim.env.PATH .. ":/home/aleksey/.config/nvm/versions/node/v22.2.0/bin"

-- Plugin setup with lazy.nvim
require("lazy").setup({
  { "neovim/nvim-lspconfig",
    dependencies = {
      { "ms-jpq/coq_nvim", branch = "coq",
        init = function()
          vim.g.coq_settings = {
            auto_start = true,
            limits = { completion_auto_timeout = 0.1 },
            clients = {
              lsp = { enabled = true },
              buffers = { enabled = true }
            },
            keymap = {
              recommended = true,
              manual_complete = "<C-Space>"
            },
            -- Moved display.icons to config to ensure proper initialization
          }
        end,
        config = function()
          local lspconfig = require("lspconfig")
          lspconfig.pyright.setup({
            cmd = {"pyright-langserver", "--stdio"},
            on_attach = function(client, bufnr)
              print("Pyright LSP attached to buffer " .. bufnr)
            end,
            on_init = function(client)
              if not vim.fn.executable("pyright-langserver") then
                vim.notify("Pyright not found. Install with 'npm install -g pyright'", vim.log.levels.ERROR)
              else
                vim.notify("Pyright found at " .. vim.fn.exepath("pyright-langserver"), vim.log.levels.INFO)
              end
            end,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true
                }
              }
            }
          })
          -- Configure display.icons after lspkind is set up
          vim.g.coq_settings = vim.tbl_extend("force", vim.g.coq_settings or {}, {
            display = {
              icons = {
                mode = "short",  -- Use "short" for icons only (removes text labels)
                spacing = 1  -- Space between icon and label
              }
            }
          })
        end,
      },
      { "ms-jpq/coq.thirdparty", branch = "3p", event = "InsertEnter" },
      { "onsails/lspkind.nvim",
        config = function()
          require("lspkind").init({
            preset = "codicons",
            symbol_map = {
              Text = "",
              Method = "",
              Function = "",
              Constructor = "",
              Field = "",
              Variable = "",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "",
              Value = "",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "",
              Operator = "",
              TypeParameter = ""
            }
          })
        end,
      },
    },
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = "BufReadPost" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-neotest/nvim-nio", lazy = true },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  { "NeogitOrg/neogit", cmd = "Neogit", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim"} },
  { "itchyny/lightline.vim", event = "VimEnter",
    init = function()
      vim.g.lightline = {
        colorscheme = "Tomorrow_Night_Blue",
        active = { left = {{"mode"}, {"filename"}}, right = {{"lineinfo"}} }
      }
    end,
  },
  { "majutsushi/tagbar", cmd = "TagbarToggle" },
  { "Raimondi/delimitMate", event = "InsertEnter" },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "justinmk/vim-sneak", event = "BufReadPost" },
  { "lewis6991/gitsigns.nvim", event = "BufReadPost" },
  { "fatih/vim-go", ft = "go",
    init = function()
      vim.g.go_fmt_command = "goimports"
      vim.g.go_highlight_types = 1
      vim.g.go_list_type = "quickfix"
      vim.g.go_auto_type_info = 1
    end,
  },
  { "mhinz/vim-startify", enabled = false },
  { "Rigellute/shades-of-purple.vim", event = "VimEnter",
    config = function() vim.cmd("colorscheme shades_of_purple") end,
  },
  { "nvim-neo-tree/neo-tree.nvim", cmd = "Neotree",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"},
  },
  { "mfussenegger/nvim-dap", event = "VeryLazy",
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
  { "rcarriga/nvim-dap-ui", event = "VeryLazy", dependencies = {"mfussenegger/nvim-dap"},
    config = function() require("dapui").setup() end,
  },
  { "nvim-telescope/telescope.nvim", cmd = "Telescope", dependencies = {"nvim-lua/plenary.nvim"}},
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"python", "lua", "go", "javascript"},
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true }
      })
    end,
  },
  { "folke/which-key.nvim", event = "VeryLazy",
    config = function()
      require("which-key").setup({
        notify = false
      })
    end,
  },
  { "github/copilot.vim", event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = { python = true, lua = true, go = true }
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })
    end,
  },
})

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "html"},
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
    vim.keymap.set({"n", "i"}, "<C-S>", ":w<CR>")
    -- DAP mappings
    vim.keymap.set("n", "<F5>", function() require('dap').continue() end)
    vim.keymap.set("n", "<F10>", function() require('dap').step_over() end)
    vim.keymap.set("n", "<F11>", function() require('dap').step_into() end)
    vim.keymap.set("n", "<F12>", function() require('dap').step_out() end)
    vim.keymap.set("n", "<Leader>b", function() require('dap').toggle_breakpoint() end)
    vim.keymap.set("n", "<F4>", function() require('dapui').toggle() end)
    -- Telescope mappings
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
  end,
})

-- Commands
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.keymap.set("", "X", "x", { noremap = true })
