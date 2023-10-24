local vim = vim
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
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
