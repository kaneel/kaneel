-- nvim-treesitter `main` branch (the rewrite).
-- The old `master` branch is archived and is broken on Neovim 0.12 because
-- its query predicates assume the pre-0.11 single-node match table.
-- The `main` branch only ships parsers + queries; Neovim itself drives
-- highlighting / indent / folds / injections via the built-in API.
--
-- Requirements:
--   * Neovim >= 0.12
--   * `tree-sitter` CLI on $PATH (install with `brew install tree-sitter`,
--     NOT npm — see the upstream README).
--   * `tar`, `curl`, and a C compiler.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local parsers = {
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
			"vimdoc",
			"yaml",
		}

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf
				local ft = vim.bo[buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end
				if not pcall(vim.treesitter.start, buf, lang) then
					return
				end

				-- Replaces the old `additional_vim_regex_highlighting = true`
				-- by keeping classic syntax on alongside treesitter.
				vim.bo[buf].syntax = "ON"

				-- Old `indent = { enable = true }` equivalent (experimental upstream).
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Tiny incremental-selection replacement.
		-- The `main` branch removed nvim-treesitter's own incremental_selection,
		-- so this is a minimal built-in-API reimplementation of your old keymaps.
		local sel = { stack = {} }

		local function set_visual(node)
			local sr, sc, er, ec = node:range()
			vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
		end

		local function node_at_cursor()
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local ok, node = pcall(vim.treesitter.get_node, { pos = { row - 1, col } })
			return ok and node or nil
		end

		local function init_selection()
			local n = node_at_cursor()
			if not n then
				return
			end
			sel.stack = { n }
			set_visual(n)
		end

		local function node_inc()
			local top = sel.stack[#sel.stack]
			local n = top and top:parent() or node_at_cursor()
			if not n then
				return
			end
			table.insert(sel.stack, n)
			set_visual(n)
		end

		local function node_dec()
			if #sel.stack > 1 then
				table.remove(sel.stack)
			end
			local n = sel.stack[#sel.stack]
			if n then
				set_visual(n)
			end
		end

		-- Avoid gr* (`gr` is LSP references). If <C-space> is dead in tmux, forward it or change these.
		vim.keymap.set("n", "<C-space>", init_selection, { desc = "TS: init selection" })
		vim.keymap.set("x", "<C-space>", node_inc, { desc = "TS: expand to parent node" })
		vim.keymap.set("x", "<BS>", node_dec, { desc = "TS: shrink to child node" })
		-- scope_incremental is intentionally not reimplemented; ask if you want it back.
	end,
}
