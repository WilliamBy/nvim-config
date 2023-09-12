-- global settings
-- vim.o.exrc = true   -- enable local task config

-- 任务相关插件配置
-- require("overseer").setup({})

-- require("overseer").load_template("user.cpp_build")
-- 告诉 asyncrun 运行时自动打开高度为 6 的 quickfix 窗口，不然你看不到任何输出，除非你自己手动用 :copen 打开它。
vim.g.asyncrun_open = 6
vim.g.asynctasks_term_pos = 'right'

vim.keymap.set({'v', 'n', 'i'}, "<f5>", ":AsyncTask file-run")
vim.keymap.set({'v', 'n', 'i'}, "<f9>", ":AsyncTask file-build")
vim.keymap.set({'v', 'n', 'i'}, "<f6>", ":AsyncTask project-run")
vim.keymap.set({'v', 'n', 'i'}, "<f10>", ":AsyncTask project-build")
