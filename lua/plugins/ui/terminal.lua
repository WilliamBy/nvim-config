---@diagnostic disable: lowercase-global
-- toggleterm.nvim
require("toggleterm").setup({
	direction = "horizontal",
})

-- It can be helpful to add mappings to make moving in and out of a terminal easier once toggled, whilst still keeping it open.
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
	vim.keymap.set("n", "q", [[<Cmd>wincmd q<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- custom terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	count = 5,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<ESC>", "<ESC>", { noremap = true, silent = true })
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_create_user_command("LazyGit", "lua _lazygit_toggle()", {})
vim.api.nvim_set_keymap("n", "<leader>wg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-`>", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-\\>", "<cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
