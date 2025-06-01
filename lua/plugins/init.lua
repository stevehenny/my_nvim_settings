return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		event = "BufWritePre",
		opts = require("configs.conform"),
	},
	{ import = "nvchad.blink.lazyspec", lazy = false },

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"python",
				"c",
				"cpp",
			},
		},
	},

	-- Mason Plugin for Managing LSP Installations and Tools
	{
		"williamboman/mason.nvim",
		lazy = false,
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
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "asm_lsp" }, -- Ensure clangd is installed
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("lspconfig").clangd.setup({
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
			})
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
