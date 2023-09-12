-- 工具 api
M = {
    -- 判断指针是否在当前窗口的下半边
	curor_lower_win = function()
		local top = vim.fn.line("w0", 0)
		local h = vim.api.nvim_win_get_height(0)
		local cur = vim.api.nvim_win_get_cursor(0)
		return (cur[1] - top) > (h / 2)
	end,
}

return M
