-- Code Generation
local utils_ok, utils = pcall(require, "core.utils")
-- doc comments generate
local neogen_ok, neogen = pcall(require, "neogen")
if not neogen_ok then
    return
end
neogen.setup({ snippet_engine = "luasnip" })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogen<cr>", utils.opts("Neogen"))
