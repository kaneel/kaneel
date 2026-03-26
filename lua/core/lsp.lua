local lsp = require("lsp-zero").preset({})
local cmp = require("cmp")
local ms = require("vim.lsp.protocol").Methods

-- Plaintext LSP hovers skip Treesitter injection; see |vim.lsp.util.open_floating_preview()|
-- (do_stylize) and |vim.lsp.buf.hover()|. We only patch when opts.focus_id is textDocument/hover
-- so |vim.diagnostic.open_float()| (plaintext + its own focus_id) stays unchanged.
do
	local util = vim.lsp.util
	local open = util.open_floating_preview

	--- Maps buffer filetype → markdown fenced-block language for TS highlighter injection.
	local fence_lang = {
		typescript = "typescript",
		typescriptreact = "tsx",
		javascript = "javascript",
		javascriptreact = "tsx",
		vue = "vue",
		svelte = "svelte",
		rust = "rust",
		lua = "lua",
		python = "python",
		go = "go",
		c = "c",
		cpp = "cpp",
	}

	function util.open_floating_preview(contents, syntax, opts)
		opts = opts or {}
		if opts.focus_id == ms.textDocument_hover and syntax == "plaintext" then
			local lang = fence_lang[vim.bo[vim.api.nvim_get_current_buf()].filetype]
			if lang then
				syntax = "markdown"
				local lines = { "```" .. lang }
				vim.list_extend(lines, contents)
				lines[#lines + 1] = "```"
				contents = lines
			end
		end
		return open(contents, syntax, opts)
	end
end

lsp.preset("recommended")

--- Constrain hover size; wrap_at aligns wrapping with width (fewer stray one-word lines).
local function lsp_hover()
	local max_w = math.min(88, math.max(40, vim.o.columns - 16))
	vim.lsp.buf.hover({
		border = "rounded",
		max_width = max_w,
		wrap_at = max_w,
		max_height = math.floor(vim.o.lines * 0.45),
	})
end

-- Softer line breaks inside ephemeral markdown floats (docs / code blocks).
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "markdown" and vim.bo[ev.buf].buftype == "nofile" then
			vim.wo.linebreak = true
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "K", lsp_hover, opts)
		vim.keymap.set("n", "gd", function()
			builtin.lsp_definitions({})
		end, opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", function()
			builtin.lsp_implementations({})
		end, opts)
		vim.keymap.set("n", "go", function()
			builtin.lsp_type_definitions({})
		end, opts)
		vim.keymap.set("n", "gr", function()
			builtin.lsp_references({})
		end, opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

		vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
		vim.keymap.set("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "<leader>vrr", function()
			builtin.lsp_references({})
		end, opts)
		vim.keymap.set("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	end,
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_format = lsp.cmp_format()

cmp.setup({
	formatting = cmp_format,
	mapping = cmp.mapping.preset.insert({
		-- scroll up and down the documentation window
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
	}),
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	signs = true,
	float = { border = "rounded" },
})

local function diagnostic_line_float()
	vim.diagnostic.open_float({ scope = "line", focus = true })
end
vim.keymap.set("n", "gl", diagnostic_line_float, { desc = "Diagnostic float (current line)" })
vim.keymap.set("n", "<leader>vd", diagnostic_line_float, { desc = "Diagnostic float (current line)" })
