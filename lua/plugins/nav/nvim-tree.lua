---@diagnostic disable: unused-local, unused-function
-- globle options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- no focus open file
	local function open_no_focus(node)
		local nt_api = require("nvim-tree.api")
		nt_api.node.open.edit(node)
		nt_api.tree.focus()
	end

	-- mark multiple file
	local mark_move_j = function()
		api.marks.toggle()
		vim.cmd("norm j")
	end
	local mark_move_k = function()
		api.marks.toggle()
		vim.cmd("norm k")
	end

	-- marked files operation
	local mark_trash = function()
		local marks = api.marks.list()
		if #marks == 0 then
			table.insert(marks, api.tree.get_node_under_cursor())
		end
		vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #marks) }, function(input)
			if input == "y" then
				for _, node in ipairs(marks) do
					api.fs.trash(node)
				end
				api.marks.clear()
				api.tree.reload()
			end
		end)
	end

	local mark_remove = function()
		local marks = api.marks.list()
		if #marks == 0 then
			table.insert(marks, api.tree.get_node_under_cursor())
		end
		vim.ui.input({ prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) }, function(input)
			if input == "y" then
				for _, node in ipairs(marks) do
					api.fs.remove(node)
				end
				api.marks.clear()
				api.tree.reload()
			end
		end)
	end

	local mark_copy = function()
		local marks = api.marks.list()
		if #marks == 0 then
			table.insert(marks, api.tree.get_node_under_cursor())
		end
		for _, node in pairs(marks) do
			api.fs.copy.node(node)
		end
		api.marks.clear()
		api.tree.reload()
	end
	local mark_cut = function()
		local marks = api.marks.list()
		if #marks == 0 then
			table.insert(marks, api.tree.get_node_under_cursor())
		end
		for _, node in pairs(marks) do
			api.fs.cut(node)
		end
		api.marks.clear()
		api.tree.reload()
	end

	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "l", api.node.open.preview, opts("Preview"))
	vim.keymap.set("n", "L", open_no_focus, opts("Open_no_focus"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "yr", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "ya", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	vim.keymap.set("n", "R", api.tree.collapse_all, opts("Collapse"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
	vim.keymap.set("n", "F", api.live_filter.clear, opts("Clear Filter"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", ">", ":NvimTreeResize +5<CR>", opts("Add Width"))
	vim.keymap.set("n", "<", ":NvimTreeResize -5<CR>", opts("Minus Width"))
	vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Previous Buffer"))
	vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Previous Buffer"))
	vim.keymap.set("n", "J", mark_move_j, opts("Toggle Bookmark Down"))
	vim.keymap.set("n", "K", mark_move_k, opts("Toggle Bookmark Up"))
	vim.keymap.set("n", "mx", mark_cut, opts("Cut File(s)"))
	vim.keymap.set("n", "md", mark_trash, opts("Trash File(s)"))
	vim.keymap.set("n", "my", mark_copy, opts("Copy File(s)"))
	vim.keymap.set("n", "mv", api.marks.bulk.move, opts("Move Bookmarked"))
	vim.keymap.set("n", "<C-x>", api.node.navigate.opened.next, opts("Next opened"))
	vim.keymap.set("n", "<C-z>", api.node.navigate.opened.prev, opts("Prev opened"))
end

require("nvim-tree").setup({
	view = {
		side = "left",
	},
	on_attach = on_attach,
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
	trash = {
		cmd = "trash",
	},
	-- use vim.ui.select api (for dressing.nvim beautifying)
	select_prompts = true,
	renderer = {
		highlight_opened_files = "name",
		highlight_modified = "icon",
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.WARN,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
})

-- nvim-tree
vim.keymap.set("n", "<leader>m", ":NvimTreeToggle<CR>") -- 开关文件树
