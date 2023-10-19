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
				"clojure",
				"cmake",
				"comment",
				"commonlisp",
				"cpp",
				"css",
				"dart",
				"dockerfile",
				"dot",
				"elixir",
				"elm",
				"elvish",
				"embedded_template",
				"erlang",
				"fennel",
				"fish",
				"gitattributes",
				"gitignore",
				"glsl",
				"go",
				"graphql",
				"haskell",
				"html",
				"http",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"kotlin",
				"latex",
				"llvm",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"ocaml",
				"ocaml_interface",
				"ocamllex",
				"perl",
				"php",
				"phpdoc",
				"prisma",
				"python",
				"qmljs",
				"regex",
				"ruby",
				"rust",
				"solidity",
				"sql",
				"svelte",
				"swift",
				"sxhkdrc",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vue",
				"yaml",
				"zig",
			},
		})
	end,
}
