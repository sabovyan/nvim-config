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
			"<leader>ufb",
			function()
				vim.cmd.FormatDisable({ bang = true })
			end,
			mode = { "n", "v" },
			desc = "[B]uffer [A]uto [F]ormat [D]isable",
		},
		{
			mode = { "n", "v" },
			"<leader>ufe",
			function()
				vim.cmd("FormatEnable")
			end,
			desc = "[A]uto [F]ormat [E]nable",
		},

		{

			mode = { "n", "v" },
			"<leader>cf",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = true,
					timeout_ms = 500,
				})
			end,
			{ desc = "Format file or range (in visual mode)" },
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
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		})

		local packages = {
			"prettier",
			"stylua",
		}

		Utils.install_LSP(packages)
	end,
}
