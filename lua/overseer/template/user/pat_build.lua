return {
	name = "[PAT] build & test",
	params = {},
	condition = {
		-- This makes the template only available in the current directory
		-- In case you :cd out later
		-- dir = vim.fn.getcwd(),
		filetype = { "cpp" },
	},
	builder = function()
		local file_basename = vim.fn.expand("%:p:r")
		return {
			name = "PAT test",
			cmd = { "bash" },
			args = {
				"g++",
				"-DONLINE_JUDEG",
				"-fno-tree-ch",
				"-Wall",
				"-std=c++17",
				"-g",
				"-pipe",
				file_basename .. ".cpp",
				"-lm",
				"-o",
				file_basename .. ".out",
			},
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
}
