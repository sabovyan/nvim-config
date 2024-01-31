local M = {}

function M.get_project_name()
	local root_dir = vim.fn.getcwd()

	-- get last part of path
	return root_dir:match("^.+/(.+)$")
end

function M.get_home_dir()
	return os.getenv("HOME") or os.getenv("USERPROFILE")
end

function M.create_nested_directory(path)
	local command = "mkdir -p " .. vim.fn.shellescape(path) .. " 2>&1"
	vim.fn.system(command)

	local error_message = vim.fn["systemlist"](command)

	if #error_message > 0 then
		print("Error creating directory:", path)
		print("Error message:", error_message[2])
	end
end

return M
