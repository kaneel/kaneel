local lint = require("lint")

lint.linters_by_ft = {
	-- JS/TS: rely on oxlint (LSP) or project tooling instead of eslint_d
	css = { "stylelint" },
	scss = { "stylelint" },
	less = { "stylelint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
	callback = function()
		lint.try_lint()
	end,
})
