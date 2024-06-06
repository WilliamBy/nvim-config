---@diagnostic disable: unused-local, undefined-field
vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		-- 使用 nvim 内置lsp
		diagnostics = "nvim_lsp",
		-- 左侧让出 nvim-tree 的位置
		offsets = {
			{
				filetype = "NvimTree",
				text = " Explorer ",
				highlight = "Directory",
				text_align = "center",
			},
		},
		name_formatter = function(buf)
			return buf.name
		end,
		themable = true,
		separator_style = "slant",
		--- count is an integer representing total count of errors
		--- level is a string "error" | "warning"
		--- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
		--- this should return a string
		--- Don't get too fancy as this function will be executed a lot
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and "󰃤" or (level:match("warning") and "" or "")
			return icon
		end,
		show_buffer_close_icons = false,
		hover = {
			enable = true,
			delay = 200,
			reveal = { "close" },
		},
		sort_by = "id",
		groups = {
			items = {
				require("bufferline.groups").builtin.pinned:with({ icon = "" }),
			},
		},
	},
})
