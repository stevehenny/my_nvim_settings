return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
      },
    },
  },

  -- Mason Plugin for Managing LSP Installations and Tools
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    opts = {
      ensure_installed = {
        "clang-format", -- clang-format tool
        "debugpy", -- debugpy tool
      },
    },
  },

  -- Mason LSP Config to Automatically Install LSP Servers
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "clangd" }, -- Ensure clangd is installed
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup {
        cmd = { "clangd", "--compile-commands-dir=/path/to/your/project" },
        filetypes = { "cpp", "c", "cuda" },
        settings = {
          clangd = {
            fallbackFlags = {
              "-std=c++17",
              "--cuda-host-only",
            },
          },
        },
      }
    end,
  },
}
