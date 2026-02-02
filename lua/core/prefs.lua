vim.opt.mouse = "a"

vim.opt.swapfile = false
vim.opt.backup = false

local undodir = vim.env.HOME .. "/.config/undo-dir"
if vim.fn.isdirectory(undodir) == false then
	vim.fn.mkdir(undodir)
end
vim.opt.undodir = undodir
vim.opt.undofile = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.wrap = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.cursorline = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"

vim.opt.visualbell = true
vim.opt.signcolumn = "yes:1"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.scrolloff = 3

vim.opt.wildignore:append("*/.git/*,*/.svn/*")
vim.opt.listchars = { tab = "▸ ", eol = "¬" }
vim.opt.list = true

-- yep ep ep
vim.opt.exrc = true
vim.opt.secure = true

-- live search / replace
vim.opt.inccommand = "nosplit"

vim.opt.guifont = { "SauceCodePro Nerd Font", ":h12" }

-- python3 host prog lookup
local function system(command)
	local file = assert(io.popen(command, "r"))
	local output = file:read("*all"):gsub("%s+", "")
	file:close()
	return output
end
if vim.fn.executable("python3") > 0 then
	vim.g.python3_host_prog = system("which python3")
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.njk,*.webc",
	callback = function()
		vim.bo.filetype = "html"
	end,
})
