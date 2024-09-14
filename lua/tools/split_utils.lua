local M = {}

function M.isSnakeCase(str)
	return str:find("_") ~= nil
end

return M
