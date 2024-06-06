vim.g.mapleader = " "

local keymap = vim.keymap

local utils = require("core.utils")

keymap.set("i", "jk", "<ESC>")

-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- 窗口
keymap.set("n", "<leader>wv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>wh", "<C-w>s") -- 垂直新增窗口
keymap.set("n", "<leader>wq", "<C-w>q") -- 删除窗口
utils.keyset("n", "<C-H>", "<C-W>h", "left window")
utils.keyset("n", "<C-L>", "<C-W>l", "right window")
utils.keyset("n", "<C-J>", "<C-W>j", "down window")
utils.keyset("n", "<C-K>", "<C-W>k", "up window")
utils.keyset("n", "<C-S-H>", "<C-W>H", "move left window")
utils.keyset("n", "<C-S-L>", "<C-W>L", "move right window")
utils.keyset("n", "<C-S-J>", "<C-W>J", "move down window")
utils.keyset("n", "<C-S-K>", "<C-W>K", "move up window")

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "no highlight", silent = true, noremap = true })

-- 切换自动保存
utils.keyset("n", "<leader>na", "<cmd>ASToggle<cr>", "toggle autosave")

-- 切换buffer
keymap.set({ "n", "i" }, "<C-N>", "<cmd>BufferLineCycleNext<CR>", { desc = "next buffer", silent = true, noremap = true })
keymap.set({ "n", "i" }, "<C-P>", "<cmd>BufferLineCyclePrev<CR>", { desc = "prev buffer", silent = true, noremap = true })
keymap.set({ "n", "i" }, "<C-S-N>", "<cmd>BufferLineMoveNext<CR>", { desc = "move buffer right", silent = true, noremap = true })
keymap.set({ "n", "i" }, "<C-S-P>", "<cmd>BufferLineMovePrev<CR>", { desc = "move buffer left", silent = true, noremap = true })
-- 保存buffer
keymap.set("n", "<leader>bw", "<cmd>w<CR>", { desc = "save buffer", silent = true, noremap = true })


-- 导航
keymap.set("n", "zk", "H", { desc = "viewport top", noremap = true })
keymap.set("n", "zj", "L", { desc = "viewport bottom", noremap = true })
keymap.set({ "n", "v" }, "H", "0", { desc = "line head", noremap = true })
keymap.set({ "n", "v" }, "L", "$", { desc = "line tail", noremap = true })

-- 触发 diagnostic 可见性
keymap.set("n", "<leader>nd", function()
	utils.toggle_diagnostic(0)
end, utils.opts("toggle diagnostic"))
-- 清除 diagnostic 缓存
keymap.set("n", "<leader>nc", function()
	vim.diagnostic.reset()
end, utils.opts("reset diagnostic cache"))
-- 禁用/触发折行
keymap.set("n", "<leader>nw", function()
    vim.wo.wrap = not vim.wo.wrap
end, utils.opts("toggle wrap"))

-- 导航
keymap.set("n", "zk", "H", { desc = "viewport top", noremap = true })
keymap.set("n", "zj", "L", { desc = "viewport bottom", noremap = true })
keymap.set({ "n", "v" }, "H", "0", { desc = "line head", noremap = true })
keymap.set({ "n", "v" }, "L", "$", { desc = "line tail", noremap = true })

-- diagnostic 相关
keymap.set("n", "<leader>bd", function()
	utils.toggle_diagnostic(0)
end, utils.opts("toggle diagnostic"))
