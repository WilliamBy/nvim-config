---@diagnostic disable: undefined-field
local dap = require("dap")
local utils = require("core.utils")

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = function()
			return utils.sync_ui_input("Program Path", vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:r"), "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		-- setupCommands = {
		-- 	{
		-- 		text = "-enable-pretty-printing",
		-- 		description = "enable pretty printing",
		-- 		ignoreFailures = false,
		-- 	},
		-- },
        runInTerminal = true,
	},
}

dap.configurations.c = dap["configurations"].cpp
dap.configurations.rust = dap["configurations"].cpp

-- keymap
vim.keymap.set("n", "<F1>", "<cmd>DapContinue<cr>")
vim.keymap.set("n", "<F2>", "<cmd>DapStepOver<cr>")
vim.keymap.set("n", "<F3>", "<cmd>DapStepInto<cr>")
vim.keymap.set("n", "<F4>", "<cmd>DapStepOut<cr>")
vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<cr>")
vim.keymap.set("n", "<Leader>dr", "<cmd>DapToggleRepl<cr>")
vim.keymap.set("n", "<Leader>dl", "<cmd>DapLoadLaunchJSON<cr>")
vim.keymap.set("n", "<Leader>dq", "<cmd>DapTerminate<cr>")
vim.keymap.set("n", "<Leader>dt", "<cmd>lua require('dapui').toggle()")
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

-- dap-ui
local dapui = require("dapui")
dapui.setup()
-- dap 自动触发 dap-ui
dap["listeners"].after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap["listeners"].before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap["listeners"].before.event_exited["dapui_config"] = function()
	dapui.close()
end
