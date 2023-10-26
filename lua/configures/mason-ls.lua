-- Tools installed and managed by Mason
M = {}
local lsp = {
	"lua_ls", -- lua
	"clangd", -- c/c++
	"bashls", -- shell
	"spectral", -- json & yaml
	"marksman", -- markdown
	"pylsp", -- python
	"jdtls", -- java
}
local dap = {
	"codelldb",
    "java-debug-adapter",
}
local linter = {
	"jsonlint",
	"shellcheck",
}
local formatter = {
	"clang-format",
	"shfmt",
	"stylua",
	"prettier",
	"pyment",
    "xmlformatter",
}
M.lsp = lsp
M.dap = dap
M.linter = linter
M.formatter = formatter
M.all = vim.tbl_extend("keep", lsp, dap, linter, formatter)
return M
