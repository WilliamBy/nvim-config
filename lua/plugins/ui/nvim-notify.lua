---@diagnostic disable: undefined-field
local _notify, notify = pcall(require, "notify")
if not _notify then
    return
end
vim.notify = notify -- notify插件接管nvim原生通知api

notify.setup({
	background_colour = "NotifyBackground",
	fps = 60,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	-- level = 1,
	-- minimum_width = 50,
	-- max_width = 80,
	-- max_height = 10,
	-- on_open = function() end,
	-- on_close = function() end,
	render = "default",
	stages = "fade_in_slide_out",
	timeout = 8000,
	top_down = true,
})

vim.api.nvim_set_keymap("n", "<leader>nn", "<cmd>lua require('notify').dismiss()<CR>", {desc = "hide notify", noremap = true, silent = true})
