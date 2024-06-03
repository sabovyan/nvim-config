-- NOTE:
-- checkout out RECOMMENDED LSP PLUgin:  https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
local Util = require("plugins.editor.lsp.on_attach")

return {
	"williamboman/mason-lspconfig.nvim",

	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/SchemaStore.nvim",
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"bashls",
				"dockerls",
				"eslint",
				"cssls",
				"emmet_ls",
				"html",
				"svelte",
				"stylelint_lsp",
				"tailwindcss",
				"tsserver",
				"intelephense", -- php
				"jsonls", -- json and yaml
				"taplo", -- toml files
			},
		})

		-- After setting up mason-lspconfig you may set up servejrs via lspconfig
		-- require("lspconfig").lua_ls.setup {}
		-- require("lspconfig").rust_analyzer.setup {}

		require("neodev").setup({})
		-- Add additional capabilities supported by nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason-lspconfig").setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = Util.on_attach,
				})
			end,
			["jsonls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.jsonls.setup({
					on_attach = Util.on_attach,
					capabilities = capabilities,

					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
						yaml = {
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				})
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
					on_attach = Util.on_attach,
					capabilities = capabilities,

					settings = {
						Lua = {
							hint = { enable = true },
							telemetry = { enable = false },
							workspace = { checkThirdParty = false },
							diagnostics = {
								globals = { "vim" },
								disable = { "missing-fields" },
							},
						},
					},
				})
			end,

			["tsserver"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.tsserver.setup({
					on_attach = Util.on_attach,
					capabilities = capabilities,
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
						typescript = {
							inlayHints = {
								-- You can set this to 'all' or 'literals' to enable more hints
								includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHints = false,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								-- You can set this to 'all' or 'literals' to enable more hints
								includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayVariableTypeHints = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,

			["eslint"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.eslint.setup({
					capabilities = capabilities,
					on_attach = function(_, bufnr)
						-- vim.api.nvim_create_autocmd("BufWritePre", {
						-- 	buffer = bufnr,
						-- 	command = "EslintFixAll",
						-- })

						vim.api.nvim_buf_create_user_command(bufnr, "Lint", function()
							vim.cmd("EslintFixAll")
						end, { desc = "Format current buffer with LSP" })

						vim.keymap.set("n", "<leader>cl", function()
							vim.cmd("EslintFixAll")
						end, { noremap = true, silent = true, buffer = true, expr = false })
					end,

					settings = {
						workingDirectory = { mode = "auto" },
						codeActionOnSave = {
							enable = true,
							mode = "all",
						},
						format = true,
					},
				})
			end,
		})
	end,
}
