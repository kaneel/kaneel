require("core.prefs")
require("core.remap")
require("core.colours")
require("core.commands")
require("core.lualine")
require("core.mason")
require("core.lsp")
require("core.rustaceanvim")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		require("core.gitsigns")
		require("core.telescope")
		require("core.oil")
	end,
})
