local CWD = {}

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

local function get_client_root_dir(client_name)
	local clients = vim.lsp.get_active_clients()

	if next(clients) == nil then
		return nil
	end

	for _, client in ipairs(clients) do
		if client.name == client_name then
			return client.config.root_dir
		end
	end

	return nil
end

--- Get the current working directory by filetype and lsp client.
--- If no client is found, return the current working directory
---@return string The current working directory
CWD.get_cwd = function()
	local ft_client_name = get_lsp_name_by_ft()

	if ft_client_name == nil then
		return vim.fn.getcwd()
	end

	local root_dir = get_client_root_dir(ft_client_name)

	return root_dir or vim.fn.getcwd()
end

CWD.get_root = function()
	return vim.fn.getcwd()
end

return CWD
