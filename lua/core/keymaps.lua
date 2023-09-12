vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")
keymap.set("i", "<C-S>", "<ESC>:w<CR>")
keymap.set("i", "<C-A>", "<ESC>A")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>wv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>wh", "<C-w>s") -- 垂直新增窗口
keymap.set("n", "<leader>wq", "<C-w>q") -- 删除窗口
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h")

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<C-X>", ":bnext<CR>", { desc = "next buffer" })
keymap.set("n", "<C-Z>", ":bprevious<CR>", { desc = "prev buffer" })
-- 保存buffer
keymap.set("n", "<leader>bw", ":w<CR>")
