require("conform").setup({
	format_on_save = function(bufnr)
		require("conform").format({
			bufnr = bufnr,
			async = false,
			lsp_fallback = true,
			stop_after_first = true,
		})
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		-- JSON/CSS/Markdown/TS/…: use LSP (oxfmt, etc.) via lsp_fallback when attached
	},
})
