local plugins = {
   {
    "jay-babu/mason-nvim-dap.nvim",
     event = "VeryLazy",
     dependencies = {
       "williamboman/mason.nvim",
       "mfussenegger/nvim-dap",
     },
     opts = {
       handlers = {},
     },
   },
   {
    "rcarriga/nvim-dap-ui",
     event = "VeryLazy",
     dependencies = {
       "mfussenegger/nvim-dap",
       "nvim-neotest/nvim-nio",
     },
     config = function()
       local dap = require("dap")
       local dapui = require("dapui")
       dapui.setup()
       dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
       end
       dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
       end
       dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
       end
     end
   },
   {
    "mfussenegger/nvim-dap",
     config = function(_, _)
       require("core.utils").load_mappings("dap")
     end
   },
   {
    "mfussenegger/nvim-dap-python",
     ft = "python",
     dependencies = {
       "mfussenegger/nvim-dap",
       "rcarriga/nvim-dap-ui",
     },
     config = function(_, _)
       local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
       require("dap-python").setup(path)
       require("core.utils").load_mappings("dap_python")
     end,
   },
   {
     "jose-elias-alvarez/null-ls.nvim",
      requires = {"nvim-lua/plenary.nvim"},
     event = "VeryLazy",
     config = function()
      return require "custom.configs.null-ls"
     end,
   },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
        "clang-format",
        "clangd",
        "lua-language-server",
        "mypy",
        "ruff",
        "black",
        "pyright",
        "debugpy",
        "asmfmt",
        "asm-lsp",
        "verible",
        "rust-analyzer",
        "cpptools",
        "bacon",
      },
    },

  },

  -- LSPConfig plugin configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"  -- Your custom LSP configurations
    end,
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
  },
  {
     "simrat39/rust-tools.nvim",
     ft = "rust",
     dependencies = "neovim/nvim-lspconfig",
     opts = function ()
       return require "custom.configs.rust-tools"
     end,
     config = function(_, opts)
       require('rust-tools').setup(opts)
     end
   },
   {
     'saecki/crates.nvim',
     ft = {"rust", "toml"},
     config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
     end,
   },
   {
     "hrsh7th/nvim-cmp",
     opts = function()
       local M = require "plugins.configs.cmp"
       table.insert(M.sources, {name = "crates"})
       return M
     end,
   }
}
return plugins
