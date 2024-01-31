local notes_utils = require("configs.notes.utils")

---
--- @param notes_dir? string - if not provided, it will be created in $HOME/notes
---@return string
local create_note_dir = function(notes_dir)
	local home_dir = notes_utils.get_home_dir()
	notes_dir = notes_dir or home_dir .. "/notes"

	local project_name = notes_utils.get_project_name()
	local path_to_notes = notes_dir .. "/" .. project_name

	notes_utils.create_nested_directory(path_to_notes)

	return path_to_notes
end

local open_todo_file = function(note_dir)
	local todo_file = note_dir .. "/todo.md"
	vim.cmd("e " .. todo_file)
end

--- Current user command is only responsible for opening tood file
vim.api.nvim_create_user_command("Notes", function()
	local note_dir = create_note_dir()

	open_todo_file(note_dir)
end, {})
