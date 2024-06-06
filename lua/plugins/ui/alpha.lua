-- alpha-config.lua

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local theme = require("alpha.themes.dashboard")
theme.section.header.val = {

	-- [[          ▀████▀▄▄              ▄█ ]],
	-- [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
	-- [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
	-- [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
	-- [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
	-- [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
	-- [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
	-- [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
	-- [[   █   █  █      ▄▄           ▄▀   ]],
    "                                                              ",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⡆⠀⠀⠀⢸⣿⣿⠿⠿⢿⣿⣿⣿⣿⡿⠿⠿⣿⣿⡇⠀⠀⠀⣾⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀",
	"⠀⠀⠀⠀⢿⣿⠿⠿⠿⠿⣿⣿⣿⡏⠀⠀⠀⢹⣿⡇⠀⠀⠀⢸⣿⢱⣶⣴⣶⢹⣿⣿⡏⣶⣦⣶⡎⣿⡇⠀⠀⠀⢿⣿⠁⠀⠀⠈⣿⣿⣿⡿⠟⣋⣽⣿⣿⠇⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠘⣿⣧⣄⣀⣴⣿⣿⣿⣷⣄⣀⣠⣾⣟⠀⠀⠀⠀⠈⣿⣦⣙⣛⣡⣾⡿⢿⣷⣌⣛⣋⣴⣿⠁⠀⠀⠀⠘⣿⣦⣄⣀⣴⣿⣿⣿⣿⣶⣶⣤⣿⡟⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣏⣼⣌⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣰⣆⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣏⣼⣌⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠉⠉⢿⣿⣿⣿⣿⣿⣿⡏⠉⠁⠀⠀⠀⠀⠀⠀⠀⠉⠉⢹⣿⣿⣿⣿⣿⣿⡏⠉⠉⠀⠀⠀⠀⠀⠀⠀⠉⠉⣿⣿⣿⣿⣿⣿⣿⡏⠉⠁⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠁⠁⠉⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠁⠉⠉⠈⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠁⠁⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "                 Fake It Until You Make It.                   ",
    "==============================================================",
}

local opts = { silent = true }

theme.section.buttons.val = {
	theme.button("p", "  Recent Projects", ":Telescope projects <CR>", opts),
	theme.button("f", "󰱼  Find file", ":Telescope find_files <CR>", opts),
	theme.button("e", "  New file", ":ene <BAR> startinsert <CR>", opts),
	theme.button("r", "  Recently used files", ":Telescope oldfiles <CR>", opts),
	theme.button("t", "󱘣  Find text", ":Telescope live_grep <CR>", opts),
	theme.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>", opts),
	theme.button("q", "  Quit Neovim", ":qa<CR>", opts),
}

local function lazy_plugins()
    local stats = require("lazy").stats()
    return stats.loaded .. "/" .. stats.count
end

local function footer()
	local plugins = "   " .. lazy_plugins()
	local datetime = os.date(" %d-%m-%Y")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return "- " .. datetime .. plugins .. nvim_version_info .. " -"
end
theme.section.footer.val = footer()

math.randomseed(os.time())

local function pick_color()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

theme.section.footer.opts.hl = "Constant"
theme.section.header.opts.hl = "AlphaHeader"
theme.section.buttons.opts.hl = "String"

theme.opts.opts.noautocmd = true
alpha.setup(theme.opts)
