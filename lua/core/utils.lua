-- 工具 api
M = {
	-- 判断指针是否在当前窗口的下半边
	curor_lower_win = function()
		local top = vim.fn.line("w0", 0)
		local h = vim.api.nvim_win_get_height(0)
		local cur = vim.api.nvim_win_get_cursor(0)
		return (cur[1] - top) > (h / 2)
	end,
	-- 同步输入框 vim.ui.input() sync version
	sync_ui_input = function(prompt, default, completion)
		local file_path
		local co = coroutine.running() -- for sync vim.ui.input
		vim.ui.input({ prompt = prompt, default = default, completion = completion }, function(input)
			coroutine.resume(co, input)
		end)
		file_path = coroutine.yield()
		return (file_path == nil) and nil or file_path
	end,
}

return M
