local M = {}

function M.on_attach(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc, mode)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("grr", "<cmd>FzfLua lsp_references<cr>", "References")

	nmap("[e", function()
		vim.diagnostic.jump({
			count = -1,
			severity = vim.diagnostic.severity.ERROR,
			float = true,
		})
	end, "Previous Error")

	nmap("]e", function()
		vim.diagnostic.jump({
			count = 1,
			severity = vim.diagnostic.severity.ERROR,
			float = true,
		})
	end, "Next Error")

	nmap("[w", function()
		vim.diagnostic.jump({
			count = -1,
			severity = vim.diagnostic.severity.WARN,
			float = true,
		})
	end, "Previous Warning")

	nmap("]w", function()
		vim.diagnostic.jump({
			count = 1,
			severity = vim.diagnostic.severity.WARN,
			float = true,
		})
	end, "Next Warning")

	nmap("<leader>wd", function()
		require("fzf-lua").lsp_workspace_diagnostics()
	end, "[W]orkspace [D]iagnostic")

	nmap("<leader>ws", function()
		require("fzf-lua").lsp_live_workspace_symbols()
	end, "[W]orkspace [S]ymbols")

	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = "Format current buffer with LSP" })
end

return M
