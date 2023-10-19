return {
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-repeat" },
	{ "lewis6991/gitsigns.nvim" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
