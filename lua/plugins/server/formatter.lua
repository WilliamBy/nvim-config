-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        cpp = {
            -- require("formatter.filetypes.cpp").clangformat,
            function ()
                return {
                    exe = "clang-format",
                    args = {
                        "-assume-filename",
                        util.escape_path(util.get_current_buffer_file_name()),
                        "--style='{BasedOnStyle: llvm, IndentWidth: 4}'",
                    },
                    stdin = true,
                    try_node_modules = true,
                }
            end
        },
        json = {
            require("formatter.filetypes.json").prettier
        },
        shell = {
            require("formatter.filetypes.sh").shfmt
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})

-- keymap
vim.keymap.set("n", "<leader>bf", ":FormatLock<CR>") -- 格式化
