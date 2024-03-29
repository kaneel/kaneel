return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	config = function()
		require("nvim-treesitter.configs").setup({
			additional_vim_regex_highlighting = true,
			auto_install = true,
			sync_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"cmake",
				"comment",
				"cpp",
				"css",
				"dockerfile",
				"gitattributes",
				"gitignore",
				"glsl",
				"graphql",
				"haskell",
				"html",
				"http",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"latex",
				"llvm",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"rust",
				"sql",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		})
	end,
}
