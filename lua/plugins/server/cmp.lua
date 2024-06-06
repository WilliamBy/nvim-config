-- Auto Completion
local types_ok, types = pcall(require, "cmp.types")
local str_ok, str = pcall(require, "cmp.utils.str")
local cmp_ok, cmp = pcall(require, "cmp")
local neogen_ok, neogen = pcall(require, "neogen")
local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local lspkind_ok, lspkind = pcall(require, "lspkind")
if not (types_ok and str_ok and cmp_ok and neogen_ok and cmp_autopairs_ok and luasnip_ok and lspkind_ok) then
	return
end
local utils = require("core.utils")

--  Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lspkind init and highlight settings
lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- luasnip config
-- 从 runtimepath 加载预定义VSC风格的snippets库
-- （事实上加载了 friendly-snippets.nvim 定义的snippet）
require("luasnip.loaders.from_vscode").lazy_load()
-- 加载自定义snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

-- setup cmp
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
	window = {
		completion = {
			-- border = { "/", "-", "\\", "|", "/", "-", "\\", "|" },
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			scrollbar = false,
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:lualine_a_normal,Search:IncSearch",
		},
		documentation = {
			-- border = { "+", "~", "+", "|", "+", "~", "+", "|" },
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			scrollbar = true,
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:lualine_a_normal,Search:IncSearch",
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = {
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
		},
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 25,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-2),
		["<C-d>"] = cmp.mapping.scroll_docs(2),
		["<C-c>"] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.abort(), -- 取消补全，esc也可以退出
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif neogen.jumpable() then
				neogen.jump_next()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif neogen.jumpable(true) then
				neogen.jump_prev()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

	-- 补全项目来源
	sources = cmp.config.sources({ -- group_index = 1
		{ name = "luasnip", option = { use_show_condition = false } },
        { name = "nvim_lsp" },
	}, { -- group_index = 2
		{ name = "path" },
		{ name = "doxygen" },
	}, { -- group_index = 3
		{ name = "buffer", option = {
			get_bufnrs = utils.get_not_so_big_bufnrs,
		} },
	}),
})

-- 为vim命令行也配置自动补全
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer", option = {
			get_bufnrs = utils.get_not_so_big_bufnrs,
		} },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- 为不同的filetype设定自动补全
-- tip：查看当前buffer的filetype —— `:lua =vim.bo.filetype`
cmp.setup.filetype("DressingInput", {
	sources = {
		cmp.config.sources(
			{ { name = "path" } },
			{ { name = "buffer", option = {
				get_bufnrs = utils.get_not_so_big_bufnrs(),
			} } }
		),
	},
})
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})

-- autopairs after method or function
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

return M
