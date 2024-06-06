-- Tools installed and managed by Mason
M = {}
local lsp = {
	"lua_ls", -- lua
	"clangd", -- c/c++
	"bashls", -- shell
	"spectral", -- json & yaml
	"pyright", -- python
	"jdtls", -- java
	"gopls", -- golang
	"ltex", -- markdown, latex
    "denols", -- deno (js, ts, json...)
    "sqls", -- sql
    "taplo", -- toml
}
local dap = {
	"codelldb",
	"java-debug-adapter",
	"delve",
	"js-debug-adapter",
}
local linter = {
	"jsonlint",
	"shellcheck",
	"alex",
    "eslint_d",
    "commitlint"
}
local formatter = {
	"clang-format",
	"shfmt",
	"stylua",
	"prettier",
	"pyment",
	"xmlformatter",
	"gofumpt",
	"golines",
}
M.lsp = lsp
M.dap = dap
M.linter = linter
M.formatter = formatter
M.all = vim.tbl_extend("keep", lsp, dap, linter, formatter)
M.auto_install = false -- 自动安装Mason工具
return M
