-- mason 体系插件配置
-- 建议按照 mason >> mason-lspconfig >> nvim-lspconfig >> lspsaga >> lsp_signature的顺序配置
-- 1. mason
local mason_ls = require("configures.mason-ls")
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- 2. mason-lspconfig
local lspconfig = require("lspconfig")
local lsputil = lspconfig.util
-- 对每个lsp都要指定capabilities
local sharedCap = require("plugins.server.cmp").capabilities
require("mason-lspconfig").setup({
	ensure_installed = mason_ls.lsp,
	automatic_installation = mason_ls.auto_install,
	handlers = {
		-- 自动配置
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({ capabilities = sharedCap })
		end,

		-- 独立配置
		["jdtls"] = function()
			if vim.bo.filetype ~= "java" then
				return
			end
			require("configures.jdtls-config").setup()
		end, -- use nvim-jdtls config instead
		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				capabilities = sharedCap,
				settings = { Lua = { completion = { callSnippet = "Replace" } } },
			})
		end,
		["clangd"] = function()
			lspconfig.clangd.setup({
				capabilities = sharedCap,
				-- exclude .proto file support
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			})
		end,
		["ltex"] = function()
			lspconfig.ltex.setup({
				capabilities = sharedCap,
				filetypes = { "markdown", "tex" },
                settings = {
                    ltex = {
                        language = "zh-CN"
                    }
                }
			})
		end,
	},
})

-- 3. nvim-lspconfig
-- mason-lspconfig 之外的lsp配置

-- 4. Lspsaga
local saga = require("lspsaga")
saga.setup({
	finder = {
		methods = {
			tyd = "textDocument/typeDefinition",
		},
	},
	ui = {
		code_action = "󱠂",
	},
	lightbulb = {
		virtual_text = false,
	},
	outline = {
		layout = "float",
		win_width = 40,
	},
})

-- 5. lsp_signature
require("lsp_signature").setup({
	debug = false, -- set to true to enable debug logging
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
	-- default is  ~/.cache/nvim/lsp_signature.log
	verbose = false, -- show debug line number

	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	max_height = 12, -- max height of signature floating_window
	max_width = 80, -- max_width of signature floating_window
	noice = false, -- set to true if you using noice to render markdown
	wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

	floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap

	floating_window_off_x = 1, -- adjust float windows x position.
	-- can be either a number or function
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	-- can be either number or function, see examples

	close_timeout = 4000, -- close floating window after ms when laster parameter is entered
	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = "󰙏 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
	hint_scheme = "String",
	hint_inline = function()
		return false
	end, -- should the hint be inline(nvim 0.10 only)?  default false
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = " ", -- character to pad on left and right of signature can be ' ', or '|'  etc

	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = "<C-k>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	toggle_key_flip_floatwin_setting = false, -- true: toggle float setting after toggle key pressed

	select_signature_key = "<C-S-K>", -- cycle to next signature, e.g. '<M-n>' function overloading
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
})

-- 6. trouble.nvim
local trouble = require("trouble")
trouble.setup({
	position = "bottom", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	cycle_results = true, -- cycle item list when reaching beginning or end of list
	action_keys = { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
		close_folds = { "zM", "zm" }, -- close all folds
		open_folds = { "zR", "zr" }, -- open all folds
		toggle_fold = { "zA", "za" }, -- toggle fold of current file
		previous = "k", -- previous item
		next = "j", -- next item
		help = "?", -- help menu
	},
	multiline = true, -- render multi-line messages
	indent_lines = true, -- add an indent guide below the fold icons
	win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
	include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "",
	},
	use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

-- 6. actions-preview
require("actions-preview").setup({
	telescope = {
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.9,
			prompt_position = "top",
			preview_cutoff = 20,
			preview_height = function(_, _, max_lines)
				return max_lines - 15
			end,
		},
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>ef", vim.diagnostic.open_float, { desc = "open float diagnostic" })
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "prev diagnostic" })
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "setloclist" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- 因为我们使用nvim-cmp插件接管了自动补全功能，故注释掉nvim原生的补全方式omnifunc
		-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { silent = true, buffer = ev.buf }
		vim.keymap.set("n", "<leader>wo", "<cmd>Lspsaga outline<CR>", opts)
		vim.keymap.set("n", "<leader>wr", "<cmd>Lspsaga finder ref+def+tyd+imp<CR>", opts)
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
		vim.keymap.set("n", "gD", "<cmd>Lspsaga finder tyd<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>Lspsaga finder def<CR>", opts)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
		vim.keymap.set("n", "gI", "<cmd>Lspsaga finder imp<CR>", opts)
		vim.keymap.set({ "i" }, "<C-k>", require("lsp_signature").toggle_float_win, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, opts) -- nvim-code-action-menu.nvim
		vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)
		vim.keymap.set("n", "<leader>ee", function()
			trouble.open()
		end, opts)
		vim.keymap.set("n", "<leader>ew", function()
			trouble.open("workspace_diagnostics")
		end, opts)
		vim.keymap.set("n", "<leader>ep", function()
			trouble.open("document_diagnostics")
		end, opts)
		vim.keymap.set("n", "<leader>eq", function()
			trouble.open("quickfix")
		end, opts)
		vim.keymap.set("n", "<leader>el", function()
			trouble.open("loclist")
		end, opts)
		vim.keymap.set("n", "<leader>er", function()
			trouble.open("lsp_references")
		end, opts)
		vim.keymap.set("n", "<leader>ed", function()
			trouble.open("lsp_type_definitions")
		end, opts)

		-- 我们不使用lsp来格式化而是采用formatter，因此注释掉下面的内容
		-- vim.keymap.set("n", "<space>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts)
		--
	end,
})
