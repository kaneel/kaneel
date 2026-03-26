-- The LSP+copilot_active stuff is excerpt from Lunarvim
local function get_attached_clients()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return "LSP Inactive"
	end

	local buf_client_names = {}

	for _, client in pairs(buf_clients) do
		if client.name ~= "copilot" then
			table.insert(buf_client_names, client.name)
		end
	end

	-- This needs to be a string only table so we can use concat below
	local unique_client_names = {}
	for _, name in pairs(buf_client_names) do
		if not vim.tbl_contains(unique_client_names, name) then
			table.insert(unique_client_names, name)
		end
	end

	local client_names_str = table.concat(unique_client_names, ", ")
	local language_servers = string.format("[%s]", client_names_str)

	return language_servers
end

local attached_clients_component = {
	get_attached_clients,
	color = {
		gui = "bold",
	},
}

local spaces_component = {
	function()
		local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
		return "󰌒 " .. shiftwidth
	end,
	padding = 1,
}

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		refresh = {
			statusline = 200,
		},
	},

	sections = {
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
				source = nil, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			},
		},
		lualine_c = {
			{ "filename", file_status = false, path = 1 },
		},
		lualine_x = {
			"diagnostics",
			attached_clients_component,
			spaces_component,
			"filetype",
		},
	},
})
