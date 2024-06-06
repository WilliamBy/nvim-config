local function symbol_bar()
	local winbar = require("lspsaga.symbol.winbar").get_bar()
	return winbar == nil and "" or winbar
end
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "onedark",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
		padding = 1,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "branch", separator = "" },
			{ "diff", padding = { left = 0, right = 1 }, separator = "" },
		},
		lualine_c = {
			{ "filename" },
			{ "diagnostics" },
			{
				function()
					return vim.diagnostic.is_disabled(0) and "󰛑" or ""
				end,
			},
			{
				function()
					return require("plugins.server.lint").lint_progress()
				end,
			},
		},
		lualine_x = {
			"encoding",
			function()
				local lspc_list = vim.lsp.get_active_clients({ bufnr = 0 })
				local fmtstr = ""
				for k, v in pairs(lspc_list) do
					if k == 1 then
						fmtstr = v.name
                    elseif v.name == "copilot" then
                        break
					else
						fmtstr = fmtstr .. "+" .. v.name
					end
				end
				return fmtstr == "" and "" or " " .. fmtstr
			end,
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {
		lualine_a = {
			{
				symbol_bar,
				separator = { right = "", left = "" },
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
	},
	extensions = { "quickfix", "lazy", "nvim-tree", "nvim-dap-ui", "trouble", "toggleterm" },
})
