vim.g.rustaceanvim = {
	tools = {},
	server = {
		on_attach = function(_, bufnr)
			if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
			vim.keymap.set("n", "<Leader>ha", function()
				vim.cmd("RustLsp hover actions")
			end, { buffer = bufnr, desc = "Rust hover actions" })
			vim.keymap.set("n", "<Leader>a", function()
				vim.cmd("RustLsp codeAction")
			end, { buffer = bufnr, desc = "Rust code actions" })
			vim.keymap.set("n", "<Leader>r", function()
				vim.cmd("RustLsp runnables")
			end, { buffer = bufnr, desc = "Rust runnables" })
		end,
		default_settings = {
			["rust-analyzer"] = {},
		},
	},
}
