CWD = {}

local function get_lsp_name_by_ft()
	local ft = vim.api.nvim_buf_get_option(0, "filetype")

	local ftToServerMap = {
		typescript = "tsserver",
		javascript = "tsserver",
		typescriptreact = "tsserver",
		javascriptreact = "tsserver",
		lua = "lua_ls",
	}
	return ftToServerMap[ft]
end

---@param client_name string
-- TODO most probably client_name is useless
local function get_cwd_by_lsp(client_name)
	local roots = {} ---@type string[]

	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr })

	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	local buff_path = vim.loop.fs_realpath(buf_name)

	for _, client in pairs(clients) do
		if client.name == client_name then
			-- only check workspace folders, since we're not interested in clients
			-- running in single file mode
			local workspace = client.config.workspace_folders

			for _, ws in pairs(workspace or {}) do
				roots[#roots + 1] = vim.uri_to_fname(ws.uri)
			end
		end
	end

	local filtered = vim.tbl_filter(function(path)
		-- TODO make sure this is right solution
		return path and buff_path and buff_path:find(path, 1, true) == 1
	end, roots)

	return filtered
end

--- Get the current working directory by filetype and lsp client.
--- If no client is found, return the current working directory
---@return string The current working directory
CWD.get_cwd = function()
	local ft_client_name = get_lsp_name_by_ft()

	if ft_client_name == nil then
		return vim.fn.getcwd()
	end

	local dirs = get_cwd_by_lsp(ft_client_name)

	return dirs[1] or vim.fn.getcwd()
end

CWD.get_root = function()
	return vim.fn.getcwd()
end

return CWD
