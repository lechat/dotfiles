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
vim.opt.mouse = ""

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
              recommended = true, -- Enable default keybindings
              manual_complete = "<C-Space>",
              pre_select = true, -- Automatically pre-select the first item
            },
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
          vim.g.coq_settings = vim.tbl_extend("force", vim.g.coq_settings or {}, {
            display = {
              icons = {
                mode = "short",
                spacing = 1
              }
            }
          })
        end,
      },
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
      { "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
          require("mason").setup()
        end,
      },
      { "jay-babu/mason-nvim-dap.nvim",
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
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = "BufReadPost" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-neotest/nvim-nio", lazy = true },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  { "NeogitOrg/neogit", cmd = "Neogit", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim"} },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "Fullpath", separator = { left = "" }, padding = 0 } },
          lualine_c = { "modified" },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  { "chentoast/marks.nvim",
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
  { "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local theta = require("alpha.themes.theta")
      local dashboard = require("alpha.themes.dashboard")

      -- Header (mimicking vim-startify's ASCII art with dynamic version)
      local version = vim.version()
      local version_str = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
      theta.header.val = {
        [[             _/      _/                                  _/ ]],
        [[    _/_/    _/    _/_/      _/_/    _/      _/      _/_/_/  _/_/ ]],
        [[   _/  _/  _/  _/_/_/_/  _/    _/  _/      _/  _/  _/    _/    _/ ]],
        [[  _/    _/_/  _/        _/    _/    _/  _/    _/  _/    _/    _/ ]],
        [[ _/      _/    _/_/_/    _/_/        _/      _/  _/    _/    _/ ]] .. version_str,
      }

      -- Recent files (mimicking vim-startify's MRU) - Manual implementation
      local mru_section = {
        type = "group",
        val = function()
          local oldfiles = vim.v.oldfiles or {}
          local buttons = {}
          for i, file in ipairs(oldfiles) do
            if i > 10 then break end -- Limit to 10 files
            if vim.fn.filereadable(file) == 1 then
              local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(vim.fn.fnamemodify(file, ":e"))
              local filename = vim.fn.fnamemodify(file, ":t")
              local path = vim.fn.fnamemodify(file, ":p:h")
              table.insert(buttons, dashboard.button(tostring(i - 1), (icon or " ") .. " " .. filename .. " (" .. path .. ")", ":e " .. file .. " <CR>", { hl = nil }))
            end
          end
          return {
            { type = "text", val = "Recent Files", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            unpack(buttons),
          }
        end,
        opts = { shrink_margin = false, position = "center" },
      }

      -- Bookmarks and quick actions (integrated into buttons)
      theta.buttons.val = {
        { type = "text", val = "Quick Actions", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("i", "Neovim Config", ":edit ~/.config/nvim/init.lua<CR>", { hl = nil }),
        dashboard.button("p", "Project File", ":edit ~/projects/main.py<CR>", { hl = nil }),
        dashboard.button("e", "New File", ":ene <BAR> startinsert <CR>", { hl = nil }),
        dashboard.button("q", "Quit", ":qa <CR>", { hl = nil }),
      }

      -- Footer (custom section since theta.footer might not exist)
      local footer_section = {
        type = "text",
        val = "Loaded " .. require("lazy").stats().count .. " plugins",
        opts = { hl = "Comment", position = "center" },
      }

      -- Layout
      theta.config.layout = {
        { type = "padding", val = 2 },
        theta.header,
        { type = "padding", val = 2 },
        mru_section,
        { type = "padding", val = 2 },
        theta.buttons,
        { type = "padding", val = 1 },
        footer_section,
      }

      -- Apply the configuration
      alpha.setup(theta.config)
    end,
  },
  { "Rigellute/shades-of-purple.vim",
    lazy = false,
    config = function()
      vim.cmd("colorscheme shades_of_purple")
    end,
  },
  { "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
    },
  },
  { "catppuccin/nvim", name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      term_colors = true,
    },
  },
  { "LunarVim/bigfile.nvim",
    lazy = true,
    enabled = false,
  },
  { "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  { "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("/usr/bin/python") -- Adjust path as needed
    end,
  },
  { "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  { "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "dark",
      })
      vim.cmd("colorscheme onedark")
    end,
  },
  { "liuchengxu/space-vim-dark",
    lazy = true,
    config = function()
      vim.cmd("colorscheme space-vim-dark")
    end,
  },
  { "altercation/vim-colors-solarized",
    lazy = true,
    config = function()
      vim.g.solarized_termcolors = 256
      vim.cmd("colorscheme solarized")
    end,
  },
  { "jnurmine/Zenburn",
    lazy = true,
    config = function()
      vim.cmd("colorscheme zenburn")
    end,
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
