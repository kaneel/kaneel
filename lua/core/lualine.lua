-- The LSP+copilot_active stuff is excerpt from Lunarvim
local function get_attached_clients()
	local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return "LSP Inactive"
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		-- Ignore copilot and the actuall null-ls LSP names
		if client.name ~= "copilot" and client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	-- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.
	-- Add sources (from null-ls)
	-- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
	local null_ls_s, null_ls = pcall(require, "null-ls")
	if null_ls_s then
		local sources = null_ls.get_sources()
		for _, source in ipairs(sources) do
			if source._validated then
				for ft_name, ft_active in pairs(source.filetypes) do
					if ft_name == buf_ft and ft_active then
						table.insert(buf_client_names, source.name)
					end
				end
			end
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
		local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
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
		lualine_b = { "branch" },
		lualine_c = { "diff" },
		lualine_x = {
			"diagnostics",
			attached_clients_component,
			spaces_component,
			"filetype",
		},
	},
})
