vim.opt.termguicolors = true

require("core.options")
require("core.keymaps")
require("core.utils")
require("core.lazy")
require("core.filetype")
require("plugins.server.whichkey")

-- 配置
---------------
require("configures.mason-ls")
require("configures.jdtls-config")

-- 插件
---------------
-- 界面
require("plugins.ui.theme")
require("plugins.ui.nui")
require("plugins.ui.lualine")
require("plugins.ui.dressing")
require("plugins.ui.bufferline")
require("plugins.ui.gitsigns")
require("plugins.ui.terminal")
require("plugins.ui.rainbow")
require("plugins.ui.alpha")
require("plugins.ui.nvim-notify")
require("plugins.ui.noice")

-- 代码服务
require("plugins.server.treesitter")
require("plugins.server.lsp")
require("plugins.server.cmp")
require("plugins.server.generator")
require("plugins.server.dap")
require("plugins.server.formatter")
require("plugins.server.lint")
require("plugins.server.neodev")
require("plugins.server.task")
require("plugins.server.project")
require("plugins.server.translate")

-- 编辑功能
require("plugins.editor.comment")
require("plugins.editor.autopairs")
require("plugins.editor.hop")

-- 导航
require("plugins.nav.treeutils")
require("plugins.nav.nvim-tree")
require("plugins.nav.telescope")
require("plugins.nav.bufdelete")
require("plugins.nav.illuminate")

-- Neovide config
if vim.g.neovide then
    -- vim.o.guifont = "CodeNewRoman Nerd Font,Symbols Nerd Font,WenQuanYi Micro Hei:h13"
    vim.o.guifont = "Maple Mono SC NF,Symbols Nerd Font:h13"
    vim.g.neovide_scroll_animation_length = 0.2
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_refresh_rate = 75
    vim.g.neovide_padding_top = 3
    vim.g.neovide_padding_bottom = 3
    vim.g.neovide_padding_right = 3
    vim.g.neovide_padding_left = 3
    vim.g.neovide_hide_mouse_when_typing = true
    -- auto IME support
    local function set_ime(args)
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end

    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
    })

    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
    })

    -- scale hotkey
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)
end

-- Vscode config
if vim.g.vscode then
    -- do something
end
