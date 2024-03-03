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

	-- Global mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions

	nmap("<leader>ci", "<cmd>LspInfo<cr>", "Lsp Info")
	nmap("gd", function()
		require("telescope.builtin").lsp_definitions({ reuse_win = true })
	end, "Goto Definition")

	nmap("gr", "<cmd>Telescope lsp_references<cr>", "References")
	nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
	nmap(
		"gI",
		vim.lsp.buf.implementation,
		-- function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
		"Goto Implementation"
	)
	nmap("gy", function()
		require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
	end, "Goto T[y]pe Definition")
	nmap("K", vim.lsp.buf.hover, "Hover")
	nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
	nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
	nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
	nmap("<leader>cA", function()
		vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
	end, "Source Action")
	nmap("<leader>cr", vim.lsp.buf.rename, "Rename")

	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

	-- diagnostic
	local diagnostic_goto = function(next, severity)
		local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
		severity = severity and vim.diagnostic.severity[severity] or nil
		return function()
			go({ severity = severity })
		end
	end
	nmap("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
	nmap("]d", diagnostic_goto(true), "Next Diagnostic")
	nmap("[d", diagnostic_goto(false), "Prev Diagnostic")
	nmap("]e", diagnostic_goto(true, "ERROR"), "Next Error")
	nmap("[e", diagnostic_goto(false, "ERROR"), "Prev Error")
	nmap("]w", diagnostic_goto(true, "WARN"), "Next Warning")
	nmap("[w", diagnostic_goto(false, "WARN"), "Prev Warning")

	nmap(
		"<leader>ws",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		"[W]orkspace [S]ymbols"
	)

	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = "Format current buffer with LSP" })
end

return M
