vim.g.mapleader = ","

-- init.lua is the real config; make $MYVIMRC and :vsp $MYVIMRC accurate
vim.env.MYVIMRC = vim.fn.stdpath("config") .. "/init.lua"

-- LAZY STUFF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ { import = "plugins" } })
require("core")
-- LAZY STUFF END
