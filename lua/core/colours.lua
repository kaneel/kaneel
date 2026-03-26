local cmd = vim.cmd
local g = vim.g

-- All builtin colorschemes can be accessed with |:colorscheme|.
local current_theme_name = os.getenv("BASE16_THEME")

if current_theme_name and g.colors_name ~= "base16-" .. current_theme_name then
	cmd("let base16colorspace=256")
	cmd("colorscheme base16-" .. current_theme_name)
else
	cmd("let base16colorspace=256")
	cmd("colorscheme base16-ashes")
end

require("base16-colorscheme").with_config({
	telescope = true,
	cmp = true,
})

-- LSP hovers are `filetype=markdown` + Treesitter; base16 often leaves @markup.* unset → flat mush.
local function lsp_markdown_hover_highlights()
	local links = {
		["@markup.heading"] = "Title",
		["@markup.heading.1"] = "Title",
		["@markup.heading.2"] = "Title",
		["@markup.heading.3"] = "Title",
		["@markup.heading.4"] = "Title",
		["@markup.strong"] = "Special",
		["@markup.italic"] = "Identifier",
		["@markup.quote"] = "Comment",
		["@markup.list"] = "Type",
		["@markup.link"] = "Identifier",
		["@markup.link.label"] = "Identifier",
		["@markup.link.url"] = "Underlined",
		["@markup.raw"] = "String",
		["@markup.raw.block"] = "Special",
		["@markup.raw.markdown_inline"] = "String",
		["@conceal"] = "NonText",
	}
	for group, target in pairs(links) do
		vim.api.nvim_set_hl(0, group, { link = target })
	end
	-- Softer float chrome (default can be a harsh bright border)
	vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
	vim.api.nvim_set_hl(0, "FloatTitle", { link = "Title" })
end

lsp_markdown_hover_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = lsp_markdown_hover_highlights,
})

-- syntaxic coloration
cmd("syntax on")
