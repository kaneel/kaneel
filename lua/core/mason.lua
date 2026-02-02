local vim = vim
local lsp_zero = require("lsp-zero")
local lspconfig = vim.lsp.config

require("mason").setup()
require("mason-nvim-dap").setup({
	handlers = {
		function(config)
			-- all sources with no handler get passed here

			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
		codelldb = function(config)
			config.adapters.lldb = {
				type = "executable",
				command = "C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe", -- adjust as needed, must be absolute path
				name = "lldb",
			}
			config.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					args = {},
				},
			}
			config.configurations.zig = config.configurations.cpp
			config.configurations.c = config.configurations.cpp

			require("mason-nvim-dap").default_setup(config)
		end,
	},
})
require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
		clangd = function()
			lspconfig.clangd.setup({
				cmd = { "clangd", "--header-insertion=never" },
				filetypes = { "cc", "c", "cpp", "cxx", "objc", "objcpp" },
			})
		end,
		lua_ls = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "use", "require" },
							workspace = {
								-- Get the language server to recognize the 'vim', 'use' global
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = {
								-- Do not send telemetry data containing a randomized but unique identifier
								enable = false,
							},
						},
					},
				},
			})
		end,
	},
})
