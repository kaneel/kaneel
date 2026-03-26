return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			auto_install = true,
			sync_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					-- Avoid gr* (`gr` is LSP references). If <C-space> is dead in tmux, forward it or change these.
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<C-S-space>",
					node_decremental = "<BS>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>cx"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>cX"] = "@parameter.inner",
					},
				},
			},
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
