-- 自动补全相关（nvim-cmp, luasnip）
local types = require("cmp.types")
local str = require("cmp.utils.str")
local neogen = require("neogen")
-- 1. 补丁：Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = require("configures.mason-ls").lsp
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	})
end

-- 2. setup luasnip
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- 从 runtimepath 加载预定义VSC风格的snippets库
-- （事实上加载了 friendly-snippets.nvim 定义的snippet）
require("luasnip.loaders.from_vscode").lazy_load()
-- 加载自定义snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

-- 3. setup neogen
neogen.setup({ snippet_engine = "luasnip" })

-- 4. setup cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- 为编辑页面配置自动补全
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
	}),

	-- 补全项目来源
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

-- 为vim命令行也配置自动补全
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
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
		cmp.config.sources({ name = "path" }),
	},
})
