local CWD = {}

CWD.get_cwd = function()
	return vim.lsp.buf.list_workspace_folders()[1] or vim.loop.cwd()
end

CWD.get_root = function()
	return vim.fn.getcwd()
end

return CWD
