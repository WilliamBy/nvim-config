-- 工具 api
M = {
	--- 判断指针是否在当前窗口的下半边
	---@return boolean
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

	--- 生成vim.keymap opts 选项
	---@param descripton string 描述
	opts = function(descripton)
		return { desc = descripton, silent = true, noremap = true }
	end,

    --- 常用keymap
    ---@param mode string | string[]
    ---@param lhs string
    ---@param rhs string | function
    ---@param descripton string
    keyset = function (mode, lhs, rhs, descripton)
        vim.keymap.set(mode, lhs, rhs, { desc = descripton, silent = true, noremap = true })
    end,

	--- 触发诊断
	---@param bufrn integer buffer order: 0 for current buffer, nil for all buffers
	toggle_diagnostic = function(bufrn)
		if vim.diagnostic.is_disabled(bufrn, nil) then
			vim.diagnostic.enable(bufrn, nil)
		else
			vim.diagnostic.disable(bufrn, nil)
		end
	end,

	--- 判断是否为大文件
	is_big_buf = function(bufnr)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
		if ok and stats and stats.size > max_filesize then
			return true
		else
			return false
		end
	end,

	get_not_so_big_bufnrs = function()
		local buf = vim.api.nvim_get_current_buf()
		local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
		if byte_size > 1024 * 1024 then -- 1 Megabyte max
			return {}
		end
		return { buf }
	end,

	--- buf toggle lsp
	toggle_lsp_client = function()
		local buf = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_active_clients({ bufnr = buf })
		if not vim.tbl_isempty(clients) then
			vim.cmd("LspStop")
		else
			vim.cmd("LspStart")
		end
	end,
}

return M
