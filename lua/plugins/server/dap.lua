---@diagnostic disable: undefined-field
local dap = require("dap")
local utils = require("core.utils")

-- mason-nvim-dap 自动配置
local mason_ls = require("configures.mason-ls")
local dapconfig = require("mason-nvim-dap")

dapconfig.setup({
	ensure_installed = mason_ls.dap,
	automatic_installation = mason_ls.auto_install,
	handlers = {
		-- automatic config by mason-nvim-dap.nvim
		function(config)
			-- all sources with no handler get passed here

			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
		-- custom config using dap.nvim
		python = function(config)
			config.adapters = {
				type = "executable",
				command = "/usr/bin/python3",
				args = {
					"-m",
					"debugpy.adapter",
				},
			}
			require("mason-nvim-dap").default_setup(config) -- don't forget this!
		end,
	},
})

-- keymap
vim.keymap.set("n", "<F1>", "<cmd>DapContinue<cr>", { silent = true })
vim.keymap.set("n", "<F2>", "<cmd>DapStepOver<cr>", { silent = true })
vim.keymap.set("n", "<F3>", "<cmd>DapStepInto<cr>", { silent = true })
vim.keymap.set("n", "<F4>", "<cmd>DapStepOut<cr>", { silent = true })
vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dr", "<cmd>DapToggleRepl<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dl", "<cmd>DapLoadLaunchJSON<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dq", "<cmd>DapTerminate<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dt", "<cmd>lua require('dapui').toggle()<cr>", { silent = true })
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
