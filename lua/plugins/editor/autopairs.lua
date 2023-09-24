local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
	return
end
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

npairs.setup({
	check_ts = true,
	-- will ignore alphanumeric and `.` symbol
	ts_config = {
		cpp = { "string" },
	},
	-- ignored_next_char = "[%w%.]",
	--Don't add pairs if it already has a close pair in the same line
	-- enable_check_bracket_line = false,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%)%>%]%)%}%,]]=],
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})

-- 配置这个使得自动补全会把括号带上

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
local handlers = require("nvim-autopairs.completion.handlers")
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		filetypes = {
			-- "*" is a alias to all filetypes
			["*"] = {
				["("] = {
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
					handler = handlers["*"],
				},
			},
			lua = {
				["("] = {
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
					---@param char string
					---@param item table item completion
					---@param bufnr number buffer number
					---@param rules table
					---@param commit_character table<string>
					handler = function(char, item, bufnr, rules, commit_character)
						-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
					end,
				},
			},
			-- Disable for tex
			tex = false,
		},
	})
)
