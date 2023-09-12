local builtin = require('telescope.builtin')

-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

vim.keymap.set('n', '<leader>ff', builtin.find_files) -- 环境里要安装fd
vim.keymap.set('n', '<leader>fg', builtin.live_grep)  -- 环境里要安装ripgrep
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fo', builtin.treesitter)
vim.keymap.set('n', '<leader>fr', builtin.oldfiles)
vim.keymap.set('n', '<leader>fn', ":Telescope notify<CR>") -- 依赖nvim.notify
