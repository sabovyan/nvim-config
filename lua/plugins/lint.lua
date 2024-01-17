local Utils = require("utils")

return {
	"mfussenegger/nvim-lint",
	dependancies = {
		"williamboman/mason.nvim",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			-- svelte = { "eslint" },
		}

		local packages = {
			"eslint-lsp",
			"vale",
		}

		Utils.install_LSP(packages)

		local lspconfig = require("lspconfig")

		lspconfig.eslint.setup({
			settings = {
				workingDirectory = { mode = "auto" },
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
				format = true,
			},
			on_attach = function(_, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}

-- ["eslint"] = function()
-- 	local lspconfig = require("lspconfig")
-- 	lspconfig.eslint.setup({

-- 		on_attach = function(client, bufnr)
-- 			print("eslint on_attach")
-- 			Util.set_Lsp_keymap()

-- 			-- Use EslintFixAll on Neovim < 0.10.0
-- 			local diag = vim.diagnostic.get(
-- 				bufnr,
-- 				{ namespace = vim.lsp.diagnostic.get_namespace(client.id) }
-- 			)
-- 			if #diag > 0 then
-- 				vim.cmd("EslintFixAll")
-- 			end

-- 			-- activate formatting
-- 			--  if client.resolved_capabilities.document_formatting then
-- 			--    vim.cmd("autocmd BufWritePre <buffer> eslint --fix <buffer>")
-- 			--  end

-- 			--	if client.name == "eslint" then
-- 			--		client.server_capabilities.documentFormattingProvider = true
-- 			--	elseif client.name == "tsserver" then
-- 			--		client.server_capabilities.documentFormattingProvider = false
-- 			--	end

-- 			--	local diag = vim.diagnostic.get(
-- 			--		bufnr,
-- 			--		{ namespace = vim.lsp.diagnostic.get_namespace(client.id) }
-- 			--	)

-- 			--	if #diag > 0 then
-- 			--		vim.cmd("EslintFixAll")
-- 			--	end

-- 			--	vim.api.nvim_create_autocmd("BufWritePre", {
-- 			--		pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
-- 			--		command = "silent! EslintFixAll",
-- 			--		group = vim.api.nvim_create_augroup(
-- 			--			"MyAutocmdsJavaScripFormatting",
-- 			--			{}
-- 			--		),
-- 			--	})
-- 		end,
-- 		capabilities = capabilities,
-- 		settings = {

-- 			-- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
-- 			workingDirectory = { mode = "auto" },
-- 			codeActionOnSave = {
-- 				enable = true,
-- 				mode = "all",
-- 			},
-- 			format = true,
-- 		},
-- 	})
-- end,
