vim.notify = require("notify") -- notify插件接管nvim原生通知api

local notify = require("notify")
notify.setup({
	background_colour = "NotifyBackground",
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	max_width = 80,
	max_height = 10,
	-- on_open = function() end,
	-- on_close = function() end,
	render = "default",
	stages = "static",
	timeout = 20000,
	top_down = true,
})
