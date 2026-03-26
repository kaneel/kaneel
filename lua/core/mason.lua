local vim = vim
local lsp_zero = require("lsp-zero")

require("mason").setup()

-- CLI tools for conform.nvim / nvim-lint (install if missing)
vim.defer_fn(function()
	local ok, mr = pcall(require, "mason-registry")
	if not ok or not mr or not mr.get_package then
		return
	end
	for _, name in ipairs({
		"stylua",
		"stylelint",
		"clang-format",
	}) do
		local pkg_ok, pkg = pcall(mr.get_package, name)
		if pkg_ok and pkg and not pkg:is_installed() then
			pkg:install()
		end
	end
end, 1500)
require("mason-nvim-dap").setup({
	handlers = {
		function(config)
			-- all sources with no handler get passed here

			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
		codelldb = function(config)
			if vim.fn.has("win32") == 1 then
				config.adapters.lldb = {
					type = "executable",
					command = "C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe",
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
			end
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})
require("mason-lspconfig").setup({
	-- rust_analyzer is owned by rustaceanvim, not mason-lspconfig auto-enable
	automatic_enable = {
		exclude = { "rust_analyzer" },
	},
	handlers = {
		lsp_zero.default_setup,
		-- typescript-language-server (not vtsls): explicit inlay hints + completions; keeps mason binary.
		ts_ls = function()
			local inlay = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			}
			require("lspconfig").ts_ls.setup(lsp_zero.build_options("ts_ls", {
				settings = {
					typescript = {
						inlayHints = inlay,
						suggest = { completeFunctionCalls = true },
					},
					javascript = {
						inlayHints = inlay,
						suggest = { completeFunctionCalls = true },
					},
				},
			}))
		end,
		clangd = function()
			require("lspconfig").clangd.setup({
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
				filetypes = { "c", "cpp", "cc", "cxx", "objc", "objcpp" },
			})
		end,
		lua_ls = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "use", "require" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
})
