-- nvim-lint
-- 如果lsp不满足的话可以添加linter
-- choose linter according to filetype
require("lint").linters_by_ft = {
	json = { "jsonlint" },
	shell = { "shellcheck" },
}
-- autocmd 写入buffer后自动触发lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
