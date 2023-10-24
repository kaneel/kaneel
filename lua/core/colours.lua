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
	indentblankline = true,
	notify = true,
	ts_rainbow = true,
	cmp = true,
	illuminate = true,
})

-- syntaxic coloration
cmd("syntax on")
