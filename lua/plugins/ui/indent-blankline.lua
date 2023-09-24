vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = {
	"lspinfo",
	"packer",
	"checkhealth",
	"help",
	"man",
	"NvimTree",
	"",
}
vim.g.indent_blankline_buftype_exclude = {
	"terminal",
	"nofile",
	"quickfix",
	"prompt",
}
vim.opt.list = true
require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = false,
})
