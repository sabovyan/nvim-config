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
