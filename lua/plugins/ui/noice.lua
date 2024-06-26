---@diagnostic disable: undefined-doc-name
require("noice").setup({
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		-- opts = {}, -- global options for the cmdline. See section on views
		---@type table<string, CmdlineFormat>
		format = {
			-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			-- view: (default is cmdline view)
			-- opts: any options passed to the view
			-- icon_hl_group: optional hl_group for the icon
			-- title: set to anything or empty string to hide
			cmdline = {
				title = " VimCmd ",
				pattern = "^:",
				icon = "󰘳",
				lang = "vim",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "25%",
						col = "50%",
					},
					size = {
						width = "70%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
					},
				},
			},
			search_down = {
				title = " Search Down ",
				kind = "search_down",
				pattern = "^/",
				icon = "󰱼",
				lang = "regex",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "10%",
						col = "50%",
					},
					size = {
						width = "50%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:AlphaHeaderLabel,FloatBorder:AlphaHeaderLabel",
					},
				},
				icon_hl_group = "AlphaHeaderLabel",
			},
			search_up = {
				title = " Search Up ",
				kind = "search_up",
				pattern = "^%?",
				icon = "󰱼",
				lang = "regex",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "90%",
						col = "50%",
					},
					size = {
						width = "50%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:AlphaHeaderLabel,FloatBorder:AlphaHeaderLabel",
					},
				},
				icon_hl_group = "AlphaHeaderLabel",
			},
			filter = {
				title = " Filter ",
				pattern = "^:%s*!",
				icon = " ",
				lang = "bash",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "25%",
						col = "50%",
					},
					size = {
						width = "70%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:AlphaButtons,FloatBorder:AlphaButtons",
					},
				},
				icon_hl_group = "AlphaButtons",
			},
			lua = {
				title = " Lua ",
				pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
				icon = " ",
				lang = "lua",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "25%",
						col = "50%",
					},
					size = {
						width = "70%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:AlphaHeader,FloatBorder:AlphaHeader",
					},
				},
				icon_hl_group = "AlphaHeader",
			},
			help = {
				title = " Help ",
				pattern = "^:%s*he?l?p?%s+",
				icon = "",
				view = "cmdline_popup",
				opts = {
					position = {
						row = "25%",
						col = "50%",
					},
					size = {
						width = "70%",
						height = "auto",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 0,
						winhighlight = "Normal:AlphaHeader,FloatBorder:AlphaHeader",
					},
				},
				icon_hl_group = "AlphaHeader",
			},
			input = {}, -- Used by input()
			-- lua = false, -- to disable a format, set to `false`
		},
	},
	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatically.
		-- This is a current Neovim limitation.
		enabled = true, -- enables the Noice messages UI
		view = "notify", -- default view for messages
		view_error = "notify", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	popupmenu = {
		enabled = true, -- enables the Noice popupmenu UI
		---@type 'nui'|'cmp'
		backend = "nui", -- backend to use to show regular cmdline completions
		---@type NoicePopupmenuItemKind|false
		-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
		kind_icons = {}, -- set to `false` to disable icons
	},
	-- default options for require('noice').redirect
	-- see the section on Command Redirection
	---@type NoiceRouteConfig
	redirect = {
		view = "popup",
		filter = { event = "msg_show" },
	},
	-- You can add any custom commands below that will be available with `:Noice command`
	---@type table<string, NoiceCommand>
	commands = {
		history = {
			-- options for the message history that you get with `:Noice`
			view = "split",
			opts = { enter = true, format = "details" },
			filter = {
				any = {
					{ event = "notify" },
					{ error = true },
					{ warning = true },
					{ event = "msg_show", kind = { "" } },
					{ event = "lsp", kind = "message" },
				},
			},
		},
		-- :Noice last
		last = {
			view = "popup",
			opts = { enter = true, format = "details" },
			filter = {
				any = {
					{ event = "notify" },
					{ error = true },
					{ warning = true },
					{ event = "msg_show", kind = { "" } },
					{ event = "lsp", kind = "message" },
				},
			},
			filter_opts = { count = 1 },
		},
		-- :Noice errors
		errors = {
			-- options for the message history that you get with `:Noice`
			view = "popup",
			opts = { enter = true, format = "details" },
			filter = { error = true },
			filter_opts = { reverse = true },
		},
	},
	notify = {
		-- Noice can be used as `vim.notify` so you can route any notification like other messages
		-- Notification messages have their level and other properties set.
		-- event is always "notify" and kind can be any log level as a string
		-- The default routes will forward notifications to nvim-notify
		-- Benefit of using Noice for this is the routing and consistent history view
		enabled = true,
		view = "notify",
	},
	lsp = {
		progress = {
			enabled = true,
			-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
			-- See the section on formatting for more details on how to customize.
			--- @type NoiceFormat|string
			format = "lsp_progress",
			--- @type NoiceFormat|string
			format_done = "lsp_progress_done",
			throttle = 1000 / 30, -- frequency to update lsp progress message
			view = "mini",
		},
		override = {
			-- override the default lsp markdown formatter with Noice
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			-- override the lsp markdown formatter with Noice
			["vim.lsp.util.stylize_markdown"] = true,
			-- override cmp documentation with Noice (needs the other options to work)
			["cmp.entry.get_documentation"] = true,
		},
		hover = {
			enabled = true,
			silent = false, -- set to true to not show a message if hover is not available
			view = nil, -- when nil, use defaults from documentation
			---@type NoiceViewOptions
			opts = {}, -- merged with defaults from documentation
		},
		signature = {
			enabled = false,
			auto_open = {
				enabled = true,
				trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
				luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
				throttle = 50, -- Debounce lsp signature help request by 50ms
			},
			view = nil, -- when nil, use defaults from documentation
			---@type NoiceViewOptions
			opts = {}, -- merged with defaults from documentation
		},
		message = {
			enabled = true,
			view = "notify",
			opts = {},
		},
		documentation = {
			view = "hover",
			---@type NoiceViewOptions
			opts = {
				lang = "markdown",
				replace = true,
				render = "plain",
				format = { "{message}" },
				win_options = { concealcursor = "n", conceallevel = 3 },
			},
		},
	},
	markdown = {
		hover = {
			["|(%S-)|"] = vim.cmd.help, -- vim help links
			["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
		},
		highlights = {
			["|%S-|"] = "@text.reference",
			["@%S+"] = "@parameter",
			["^%s*(Parameters:)"] = "@text.title",
			["^%s*(Return:)"] = "@text.title",
			["^%s*(See also:)"] = "@text.title",
			["{%S-}"] = "@parameter",
		},
	},
	health = {
		checker = true, -- Disable if you don't want health checks to run
	},
	smart_move = {
		-- noice tries to move out of the way of existing floating windows.
		enabled = true, -- you can disable this behaviour here
		-- add any filetypes here, that shouldn't trigger smart move.
		excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
	},
	---@type NoicePresets
	presets = {
		-- you can enable a preset by setting it to true, or a table that will override the preset config
		-- you can also add custom presets that you can enable/disable with enabled=true
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
	---@type NoiceConfigViews
	views = {
		split = {
			enter = true, -- enter split window when open
		},
		popup = {
			position = {
				row = "40%",
				col = "50%",
			},
			size = {
				width = "70%",
				height = "auto",
			},
			border = {
				style = "rounded",
			},
			win_options = {
				winblend = 0,
				winhighlight = "Normal:BufferCurrentHint,FloatBorder:BufferCurrentHint",
			},
		},
	}, ---@see section on views
	---@type NoiceRouteConfig[]
	routes = {
		{
			view = "split",
			filter = {
				any = {
					{ cmdline = "^:%s*!" },
					{ event = "msg_show", min_height = 5 },
					{ event = "msg_show", min_width = 80 },
					{ kind = { "return_prompt" } },
					{ kind = { "quickfix" } },
					{ kind = { "lua_error" } },
					{ kind = { "rpc_error" } },
				},
			},
		},
		{
			filter = {
				any = {
					{ event = "msg_showmode" },
					{ event = "msg_show", find = "AutoSave" },
					{ event = "msg_show", find = "lines moved" },
					{ event = "msg_show", find = "lines indented" },
				},
			},
			opts = { skip = true },
		},
		{
			view = "mini",
			filter = {
				any = {
					{ event = "msg_show", find = "yanked" },
					{ event = "msg_show", find = "fewer line" },
					{ event = "msg_show", find = "more line" },
					{ event = "msg_show", find = "Hop " },
					{ event = "msg_show", find = "change; before" },
					{ event = "msg_show", find = "Pattern not found" },
					{ event = "msg_show", find = "[w]" },
				},
			},
		},
	}, --- @see section on routes
	---@type table<string, NoiceFilter>
	status = {}, --- @see section on statusline components
	---@type NoiceFormatOptions
	format = {}, --- @see section on formatting
})

--- 短消息 refer to ":h shortmess"
vim.o.shortmess = "filnxtToOFsIwc"

vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", { silent = true, noremap = true, desc = "last noice" })
-- redirect messages generated by cmdline
vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline(), { view = "split" })
end, { desc = "Redirect Cmdline" })
