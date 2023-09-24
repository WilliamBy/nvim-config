local telescope = require("telescope")
local builtin = require("telescope.builtin")

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

-- extensions
telescope.load_extension("fzf") -- 使用 fzf 模糊搜索
telescope.extensions.asynctasks.all()

-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

vim.keymap.set("n", "<leader>ff", builtin.find_files) -- 环境里要安装fd
vim.keymap.set("n", "<leader>fg", builtin.live_grep) -- 环境里要安装ripgrep
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fo", builtin.treesitter)
vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<CR>") -- 依赖nvim.notify
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>")
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope asynctasks all<CR>")
