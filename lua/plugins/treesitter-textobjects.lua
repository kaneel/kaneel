-- nvim-treesitter-textobjects on its `main` branch.
-- Mirrors the keymaps that used to live inside the old
-- `nvim-treesitter` configs.setup({ textobjects = ... }) block.
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select").select_textobject
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		local function map_select(lhs, query)
			vim.keymap.set({ "x", "o" }, lhs, function()
				select(query, "textobjects")
			end, { desc = "TS select " .. query })
		end

		map_select("af", "@function.outer")
		map_select("if", "@function.inner")
		map_select("ac", "@class.outer")
		map_select("ic", "@class.inner")
		map_select("aa", "@parameter.outer")
		map_select("ia", "@parameter.inner")

		local function map_move(lhs, fn, query)
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				fn(query, "textobjects")
			end, { desc = "TS " .. lhs .. " " .. query })
		end

		map_move("]f", move.goto_next_start, "@function.outer")
		map_move("]c", move.goto_next_start, "@class.outer")
		map_move("]F", move.goto_next_end, "@function.outer")
		map_move("]C", move.goto_next_end, "@class.outer")
		map_move("[f", move.goto_previous_start, "@function.outer")
		map_move("[c", move.goto_previous_start, "@class.outer")
		map_move("[F", move.goto_previous_end, "@function.outer")
		map_move("[C", move.goto_previous_end, "@class.outer")

		vim.keymap.set("n", "<leader>cx", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "TS swap next parameter" })
		vim.keymap.set("n", "<leader>cX", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "TS swap previous parameter" })
	end,
}
