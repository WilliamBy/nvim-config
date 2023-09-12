local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"folke/neodev.nvim", --为 nvim lua 插件提供lsp支持

	-- UI
	-- "navarasu/onedark.nvim", -- 主题
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-tree/nvim-web-devicons", -- 文档树图标
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim", -- 状态栏
		"akinsho/bufferline.nvim", -- buffer分割线
		"nvim-tree/nvim-tree.lua", -- 文档树
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	"famiu/bufdelete.nvim", --优雅地删除buffer
	{
		"lewis6991/gitsigns.nvim", -- 左则git提示
		"stevearc/dressing.nvim", -- ui 美化（主要是 vim.input & vim.select）
		"rcarriga/nvim-notify", -- 通知美化框架
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim", -- 诊断美化框架
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"echasnovski/mini.indentscope", -- 缩进空间标注
		version = "*",
		event = "LspAttach",
	},
	-- "christoomey/vim-tmux-navigator",
	-- "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- lsp & mason
	"nvim-treesitter/nvim-treesitter", -- 语法高亮
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig", -- official lsp client config plugin
	{
		"williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
		dependencies = { { "williamboman/mason.nvim" } },
	},
	{
		"onsails/lspkind.nvim", -- 自动补全列表项图标
		"mhartington/formatter.nvim",
		"mfussenegger/nvim-lint",
		event = "LspAttach",
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		event = "LspAttach", -- lazy load when lsp attach
	},
	{
		"weilbith/nvim-code-action-menu",
		event = "LspAttach",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
	},

	-- 自动补全相关
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"onsails/lspkind.nvim",
				"hrsh7th/cmp-path", -- 补全源：路径
				"hrsh7th/cmp-cmdline", -- 补全源：命令行
				"hrsh7th/cmp-nvim-lsp", -- cmp & lsp 桥梁
				{
					"L3MON4D3/LuaSnip", -- snippets引擎，nvim-cmp依赖
					dependencies = { { "rafamadriz/friendly-snippets" } },
				},
				"saadparwaiz1/cmp_luasnip", -- luasnip & cmp 桥梁
			},
		},
	},

	"windwp/nvim-autopairs", -- 自动补全括号
	-- 其他编辑功能
	"numToStr/Comment.nvim", -- gcc和gc注释
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	"phaazon/hop.nvim", -- nvim easy motion

	-- DAP
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { { "mfussenegger/nvim-dap" } },
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1", -- 文件检索
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	-- {
	-- 	"stevearc/overseer.nvim", -- 任务插件
	-- 	opts = {},
	-- },
	{
		"skywind3000/asynctasks.vim", -- 异步任务插件
		dependencies = { { "skywind3000/asyncrun.vim" } },
	},

	{
		"folke/which-key.nvim", -- 按键映射管理插件，内置marks、register查看功能
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},

	{ "akinsho/toggleterm.nvim", version = "*", opts = {} },
}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
