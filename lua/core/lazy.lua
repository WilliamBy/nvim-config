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
	"MunifTanjim/nui.nvim", -- UI库
	{
		"karb94/neoscroll.nvim",
		enabled = function()
			if vim.g.neovide then
				return false
			end
			return true
		end,
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
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
		"goolord/alpha-nvim", -- 启动页
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	"famiu/bufdelete.nvim", --优雅地删除buffer
	{
		"lewis6991/gitsigns.nvim", -- 左则git提示
		"stevearc/dressing.nvim", -- ui 美化（主要是 vim.input & vim.select）
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim", -- 诊断美化框架
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim", -- 缩进空间标注
		main = "ibl",
		event = "LspAttach",
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},
	{
		"norcalli/nvim-colorizer.lua", -- 颜色代码效果实时预览
		config = function()
			require("colorizer").setup({
				"*",
			}, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			"rcarriga/nvim-notify",
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		dependencies = { { "mfussenegger/nvim-dap" }, { "nvim-treesitter/nvim-treesitter" } },
	},
	{
		"RRethy/vim-illuminate",
		-- event = "LspAttach"
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
	-- lsp & mason
	"nvim-treesitter/nvim-treesitter", -- 语法高亮
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig", -- official lsp client config plugin
	{
		"williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
		dependencies = { { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } },
	},
	-- "mfussenegger/nvim-jdtls",
	{
		"onsails/lspkind.nvim", -- 自动补全列表项图标
		"mhartington/formatter.nvim",
		"mfussenegger/nvim-lint",
		"rshkarin/mason-nvim-lint",
		event = "LspAttach",
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" }, -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		event = "LspAttach", -- lazy load when lsp attach
	},
	{
		"aznhe21/actions-preview.nvim",
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
				"hrsh7th/cmp-nvim-lsp", -- cmp & lsp 桥梁
				{
					"saadparwaiz1/cmp_luasnip", -- luasnip & cmp 桥梁
					dependencies = {
						"L3MON4D3/LuaSnip",
						-- follow latest release.
						version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
						-- install jsregexp (optional!).
						build = "make install_jsregexp",
						dependencies = { "rafamadriz/friendly-snippets" },
					},
				},
				"hrsh7th/cmp-path", -- 补全源：路径
				"hrsh7th/cmp-cmdline", -- 补全源：命令行
				"hrsh7th/cmp-buffer",
				"davidsierradz/cmp-conventionalcommits",
				{
					"paopaol/cmp-doxygen",
					dependencies = {
						"nvim-treesitter/nvim-treesitter",
						"nvim-treesitter/nvim-treesitter-textobjects",
					},
				},
			},
		},
	},
	"windwp/nvim-autopairs", -- 自动补全括号
	-- 其他编辑功能
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	}, -- 基于 treesitter 的 textobjects 扩充
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
	"pocco81/auto-save.nvim",

	-- DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { { "williamboman/mason.nvim", "mfussenegger/nvim-dap" } },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" } },
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5", -- 文件检索
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- 基于 cmake 构建，确保系统拥有 Cmake 以及对应平台的编译工具链
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"skywind3000/asynctasks.vim", -- 异步任务插件
		dependencies = { { "skywind3000/asyncrun.vim" } },
	},
	{
		"GustavoKatel/telescope-asynctasks.nvim",
		dependencies = {
			{ "skywind3000/asynctasks.vim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
		},
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

	-- 代码生成相关
	{
		"danymat/neogen", -- 注释生成
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},

	{
		"ahmedkhalf/project.nvim",
		dependencies = { { "nvim-telescope/telescope.nvim" } }, -- 项目管理
	},

	{
		"folke/todo-comments.nvim", -- todo list
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	"wakatime/vim-wakatime",
	{ "niuiic/translate.nvim", dependencies = { "niuiic/core.nvim" } },

	-- language specific
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function(client, bufnr)
				-- your on_attach function
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	-- external integration
	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
		config = function()
			require("kitty-scrollback").setup()
		end,
	},
}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
