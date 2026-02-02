local rt = require("rust-tools")
local dap = require("rust-tools.dap")

-- Update this path
HOME_PATH = os.getenv("HOME") .. "/"
MASON_PATH = HOME_PATH .. ".share/nvim/mason/packages/"
local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb.so"

rt.setup({
	tools = {
		autoSetHints = true,
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			show_parameter_hints = true,
			parameter_hints_prefix = " ",
			other_hints_prefix = " ",
		},
		type_inlay_hints = {
			-- wheter to show parameter hints with the inlay hints or not
			show_parameter_hints = true,
			-- prefix for parameter hints
			parameter_hints_prefix = " ",
			-- prefix for all the other hints (type, chaining)
			other_hints_prefix = " ",
		},
	},
	dap = {
		adapter = {
			type = "executable",
			command = "lldb-vscode",
			name = "rt_lldb",
		},
	},
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<Leader>ha", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>r", rt.runnables.runnables, { buffer = bufnr })
		end,
	},
})
