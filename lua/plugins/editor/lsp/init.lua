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
		{
			"yioneko/nvim-vtsls",
			lazy = true,
			config = function()
				require("vtsls").config({})
			end,
		},
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
				"vtsls",

				"intelephense", -- php

				"jsonls", -- json and yaml
				"taplo", -- toml files

				"pyright", -- python
				"ruff", -- pyton linter
			},
		})

		-- Add additional capabilities supported by nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("lspconfig.configs").vtsls = require("vtsls").lspconfig

		require("mason-lspconfig").setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = Util.on_attach,
				})
			end,

			pyright = function()
				require("lspconfig").pyright.setup({

					settings = {
						pyright = {
							-- Using Ruff's import organizer
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								-- Ignore all files for analysis to exclusively use Ruff for linting
								ignore = { "*" },
							},
						},
					},
				})
			end,

			ruff_lsp = function()
				local lspconfig = require("lspconfig")
				lspconfig.ruff_lsp.setup({
					on_attach = function(client)
						if client.name == "ruff_lsp" then
							-- Disable hover in favor of Pyright
							client.server_capabilities.hoverProvider = false
						end
					end,
					init_options = {
						settings = {
							args = {},
						},
					},
				})
			end,
			jsonls = function()
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
			lua_ls = function()
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

			-- INFO resourcces:
			-- https://github.com/LazyVim/LazyVim/commit/fba06ce9f522b91be8a342f9c028948c2733132d implementation in LazyVim
			-- https://github.com/yioneko/vtsls?tab=readme-ov-file#commands
			-- https://github.com/yioneko/nvim-vtsls?tab=readme-ov-file
			vtsls = function()
				local lspconfig = require("lspconfig")
				lspconfig.vtsls.setup({
					on_attach = function(_, bufnr)
						Util.on_attach(_, bufnr)

						local nmap = function(keys, func, desc, mode)
							if desc then
								desc = "VTSLS: " .. desc
							end

							vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = desc })
						end

						local vtsls = require("vtsls")

						nmap("gR", function()
							vtsls.commands.file_references(0)
						end, "File References")

						nmap("gD", function()
							vtsls.commands.goto_source_definition(0)
						end, "Goto Source Definition")

						nmap("<leader>co", function()
							vtsls.commands.organize_imports(0)
						end, "Organize Imports")

						nmap("<leader>cm", function()
							vtsls.commands.add_missing_imports(0)
						end, "Add missing imports")

						nmap("<leader>cD", function()
							vtsls.commands.fix_all(0)
						end, "Fix all diagnostics")
					end,
					capabilities = capabilities,
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
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
						end, { desc = "Format current buffer with ESlint" })

						vim.keymap.set("n", "<leader>cl", function()
							vim.cmd("EslintFixAll")
						end, {
							noremap = true,
							silent = true,
							buffer = true,
							expr = false,
							desc = "Format current buffer with ESlint",
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
