return {
	"stevearc/conform.nvim",
	dependancies = {
		"williamboman/mason.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
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
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		local registry = require("mason-registry")
		require("mason").setup()

		local packages = {
			"prettier",
			"stylua",
		}

		for i = 1, #packages do
			local installed = registry.is_installed(packages[i])
			if installed == false then
				print(string.format("%s is installing ......", packages[i]))
				registry.get_package(packages[i]):install()
				-- else
				-- 	print(string.format("%s is already installed!", packages[i]))
			end
		end

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
