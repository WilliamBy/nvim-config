local telescope = require("telescope")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local utils = require("core.utils")
local custom_actions = require("configures.telescope-actions")
-- extensions
telescope.load_extension("fzf") -- 使用 fzf 模糊搜索
telescope.extensions.asynctasks.all()

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
			n = {
				["?"] = "which_key",
				["<C-h>"] = "which_key",
			},
		},
		borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
		multi_icon = "  ",
		prompt_prefix = "  ",
		selection_caret = "  ",
		entry_prefix = "  ",
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<C-d>"] = { actions.delete_buffer, type = "action", utils.opts("delete_buffer") },
				},
				n = {
					["d"] = { actions.delete_buffer, type = "action", utils.opts("delete_buffer") },
				},
			},
		},
		find_files = {
			mappings = {
				i = {
					["<C-o>"] = {
						custom_actions.multi_selection_open,
						type = "action",
						utils.opts("multi_selection_open"),
					},
				},
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

vim.keymap.set("n", "<leader>ff", builtin.find_files) -- 环境里要安装fd
vim.keymap.set("n", "<leader>fg", builtin.live_grep) -- 环境里要安装ripgrep
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fo", builtin.treesitter)
vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
vim.keymap.set("n", "<leader>fc", function()
	builtin.git_bcommits({ git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--", "." } })
end)
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<CR>", { silent = true }) -- 依赖nvim.notify
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { silent = true })
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope asynctasks all<CR>", { silent = true })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", silent = true })
