local M = {}

--- First absolute column from 'colorcolumn', e.g. `"80"` → 80.
--- Used for 'textwidth' and render-markdown layout so prose matches the ruler.
---@return integer
function M.readable_width()
	for _, c in ipairs(vim.opt.colorcolumn:get()) do
		local n = tonumber(c)
		if n then
			return n
		end
	end
	return 80
end

--- Left inset (columns) to center a field of width `readable_width()` in `win`.
---@param win? integer
---@return integer
function M.centered_left_margin(win)
	win = win or vim.api.nvim_get_current_win()
	local tw = M.readable_width()
	local infos = vim.fn.getwininfo(win)
	local textoff = #infos == 1 and infos[1].textoff or 0
	local ww = vim.api.nvim_win_get_width(win) - textoff
	return math.max(0, math.floor((ww - tw) / 2))
end

return M
