local lsp = require("lsp-zero").preset({})
local cmp = require("cmp")

lsp.preset("recommended")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

		vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
		vim.keymap.set("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
	end,
})

local cmp_select = { behaviour = cmp.SelectBehavior.Select }
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
