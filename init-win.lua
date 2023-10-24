--[[ 
	Windows will look for the init.lua script in # ~./AppData/Local/nvim 
	so we need to be smort about it and send this init script to then
	AppData direction, append a RPT to ~./config/nvim and use dotfile function 
	to kick the real script, this should do the trick! 
]]

vim.opt.rtp:append(os.getenv("HOME") .. "/.config/nvim")
dofile(os.getenv("HOME") .. "/.config/nvim/init.lua")
