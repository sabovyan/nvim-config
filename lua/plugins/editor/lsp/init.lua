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
				"cssls",
				"dockerls",
				"eslint",
				"emmet_ls",
				"html",
				"intelephense",
				"svelte",
				"tailwindcss",
				"tsserver",
				"jsonls",
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

			["eslint"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.eslint.setup({
					capabilities = capabilities,
					on_attach = function(_, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
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
