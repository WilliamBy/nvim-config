require("core.lazy")

require("core.options")
require("core.keymaps")
require("core.utils")
require("plugins.server.whichkey")

-- 插件
---------------
-- 界面
require("plugins.ui.lualine")
require("plugins.ui.dressing")
require("plugins.ui.nvim-notify")
require("plugins.ui.theme")
require("plugins.ui.bufferline")
require("plugins.ui.gitsigns")
require("plugins.ui.terminal")
require("plugins.ui.indent-scope")

-- 编辑功能
require("plugins.editor.comment")
require("plugins.editor.autopairs")
require("plugins.editor.hop")

-- 代码服务
require("plugins.server.treesitter")
require("plugins.server.lsp")
require("plugins.server.dap")
require("plugins.server.formatter")
require("plugins.server.lint")
require("plugins.server.neodev")
require("plugins.server.cmp")
require("plugins.server.task")

-- 导航
require("plugins.nav.nvim-tree")
require("plugins.nav.telescope")
require("plugins.nav.bufdelete")
