local telescope = require("telescope")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local utils = require("core.utils")
local M = {}

-- multi_selection_open
function M._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
            actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end
function M.multi_selection_open_vsplit(prompt_bufnr)
    M._multiopen(prompt_bufnr, "vsplit")
end
function M.multi_selection_open_split(prompt_bufnr)
    M._multiopen(prompt_bufnr, "split")
end
function M.multi_selection_open_tab(prompt_bufnr)
    M._multiopen(prompt_bufnr, "tabe")
end
function M.multi_selection_open(prompt_bufnr)
    M._multiopen(prompt_bufnr, "edit")
end

return M
