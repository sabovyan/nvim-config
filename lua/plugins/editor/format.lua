local Utils = require("utils")

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	dependancies = {
		"williamboman/mason.nvim",
	},
	keys = {
		{
			"<leader>ufd",
			function()
				vim.cmd.FormatDisable()
			end,
			mode = { "n", "v" },
			desc = "[A]uto [F]ormat [D]isable",
		},
		{
			"<leader>ufe",
			function()
				vim.cmd("FormatEnable")
			end,
			mode = { "n", "v" },
			desc = "[A]uto [F]ormat [E]nable",
		},
		{
			"<leader>cf",
			function()
				require("conform").format({
					timeout_ms = 3000,
					async = true,
					quiet = false,
					-- lsp_fallback = true,
				})
			end,
			mode = { "n", "v" },
			desc = "Format file or range",
		},
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },

				python = { "ruff_format" },
			},
			format_after_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {
					timeout_ms = 3000,
					async = true,
					quiet = false,
					-- lsp_fallback = true
				}
			end,
		})

		local packages = {
			"prettier",
			"stylua",
			"beautysh",
			"ruff",
		}

		Utils.install_LSP(packages)
	end,
}
