require("nvim-treesitter.configs").setup({
	-- 添加不同语言
	ensure_installed = {
		"vim",
		"vimdoc",
		"bash",
		"c",
		"cpp",
		"javascript",
		"json",
        "jsonc",
        "json5",
		"lua",
		"python",
		"typescript",
		"tsx",
		"css",
		"rust",
		"markdown",
		"markdown_inline",
        "java",
        "doxygen",
        "yaml",
        "toml",
        "html",
        "css",
        "sql",
        "comment",
        "go",
        "gomod",
        "gosum",
	}, -- one of "all" or a list of languages

	highlight = { enable = true },
	indent = { enable = true },

	-- 启用增量选择
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	-- 不同括号颜色区分
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

-- 开启 Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99

-- rainbow delimeter
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}
