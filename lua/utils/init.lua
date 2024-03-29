local M = {}

--- @param packages table
M.install_LSP = function(packages)
	local registry = require("mason-registry")
	require("mason").setup()

	for i = 1, #packages do
		local installed = registry.is_installed(packages[i])
		if installed == false then
			print(string.format("%s is installing ......", packages[i]))
			registry.get_package(packages[i]):install()
			-- else
			-- 	print(string.format("%s is already installed!", packages[i]))
		end
	end
end

---@param path string
---@return string
function M.get_path_last_part(path)
	-- get last part of path
	return path:match("^.+/(.+)$")
end

return M
