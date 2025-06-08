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
		"mfussenegger/nvim-dap",
		event = "VeryLazy", -- Load on startup or adjust as needed (e.g., "BufReadPre")
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
		},
		keys = {
			{ "<leader>db", desc = "DAP: Toggle Breakpoint" },
			{ "<leader>dc", desc = "DAP: Continue/Start" },
			{ "<leader>do", desc = "DAP: Step Over" },
			{ "<leader>di", desc = "DAP: Step Into" },
			{ "<leader>dO", desc = "DAP: Step Out" },
			{ "<leader>dq", desc = "DAP: Terminate" },
			{ "<leader>du", desc = "DAP: Toggle UI" },
			{ "<leader>d?", desc = "DAP: Evaluate var under cursor" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")

			dapui.setup({})
			require("nvim-dap-virtual-text").setup({ enabled = true })

			local python_path = os.getenv("VIRTUAL_ENV") and (os.getenv("VIRTUAL_ENV") .. "/bin/python") or "python"
			dap_python.setup(python_path)

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file with argument options",
					program = "${file}",
					args = function()
						local predefined_args = {
							{ name = "No arguments", args = {} },
							{
								name = "Run with user='test' and mode='dev'",
								args = { "--user", "test", "--mode", "dev" },
							},
							{ name = "Run with verbose flag", args = { "--verbose" } },
							{ name = "Enter custom arguments...", custom = true },
						}

						local choice_lines = { "Choose command-line arguments:" }
						for i, preset in ipairs(predefined_args) do
							table.insert(choice_lines, string.format("%d: %s", i, preset.name))
						end

						local choice_index = vim.fn.inputlist(choice_lines)
						if choice_index <= 0 or choice_index > #predefined_args then
							vim.notify("DAP launch cancelled.", vim.log.levels.WARN)
							return {}
						end

						local selected = predefined_args[choice_index]
						if selected.custom then
							local custom_input = vim.fn.input("Enter arguments: ")
							return vim.split(custom_input, " ")
						else
							return selected.args
						end
					end,
					env = {
						PYTHONPATH = function()
							local current = os.getenv("PYTHONPATH") or ""
							local root = vim.fn.getcwd()
							return current ~= "" and (root .. ":" .. current) or root
						end,
					},
					cwd = "${workspaceFolder}",
				},
			}

			-- Signs
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticSignError",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "",
				texthl = "DiagnosticSignError",
			})
			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Open UI on start
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			local opts = { noremap = true, silent = true }

			-- Keymaps
			vim.keymap.set(
				"n",
				"<leader>db",
				dap.toggle_breakpoint,
				vim.tbl_extend("force", opts, { desc = "DAP: Toggle Breakpoint" })
			)
			vim.keymap.set(
				"n",
				"<leader>dc",
				dap.continue,
				vim.tbl_extend("force", opts, { desc = "DAP: Continue/Start" })
			)
			vim.keymap.set("n", "<leader>do", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP: Step Over" }))
			vim.keymap.set("n", "<leader>di", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP: Step Into" }))
			vim.keymap.set("n", "<leader>dO", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP: Step Out" }))
			vim.keymap.set("n", "<leader>dq", dap.terminate, vim.tbl_extend("force", opts, { desc = "DAP: Terminate" }))
			vim.keymap.set("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "DAP: Toggle UI" }))
			vim.keymap.set("n", "<leader>d?", function()
				dapui.eval(nil, { enter = true })
			end, vim.tbl_extend("force", opts, { desc = "DAP: Evaluate var under cursor" }))
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
