local hop = require("hop")
hop.setup()
-- local directions = require("hop.hint").HintDirection
vim.keymap.set({"n", "v"}, "<leader>s", function()
	hop.hint_char1({ current_line_only = false })
end, { remap = false })
vim.keymap.set({"n", "v"}, "<C-s>", function()
	hop.hint_char1({ current_line_only = false })
end, { remap = false })

