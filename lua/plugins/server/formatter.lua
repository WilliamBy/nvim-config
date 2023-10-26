-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
---@diagnostic disable-next-line: undefined-field
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
			function()
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
						"--style=file",
						-- "--fallback-style='{BasedOnStyle: llvm, IndentWidth: 4}'",
						"--fallback-style=LLVM",
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		java = {
			function()
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
						"--style=file",
						-- "--fallback-style='{BasedOnStyle: llvm, IndentWidth: 4}'",
						"--fallback-style=LLVM",
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettier,
		},
		shell = {
			require("formatter.filetypes.sh").shfmt,
		},
		python = {
			require("formatter.filetypes.python").pyment,
		},
        xml = {
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
