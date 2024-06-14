return {

	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},

			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

			-- NOTE alternative "monkoose/neocodeium",

			-- {
			-- 	"Exafunction/codeium.nvim",
			-- 	dependencies = {
			-- 		"nvim-lua/plenary.nvim",
			-- 		"hrsh7th/nvim-cmp",
			-- 	},
			-- 	config = function()
			-- 		require("codeium").setup({})
			-- 	end,
			-- },

			-- {
			-- 	"zbirenbaum/copilot-cmp",
			-- 	dependencies = {
			-- 		"zbirenbaum/copilot.lua",
			-- 		config = function()
			-- 			require("copilot").setup({
			-- 				suggestion = { enabled = false },
			-- 				panel = { enabled = false },
			-- 				filetypes = {
			-- 					markdown = true,
			-- 					help = true,
			-- 				},
			-- 			})
			-- 		end,
			-- 	},
			-- 	config = function()
			-- 		require("copilot_cmp").setup()
			-- 	end,
			-- },
		},
		config = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()

			require("configs.snippet").register_cmp_source()

			local lspkind = require("lspkind")

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				-- snippet = {
				-- 	expand = function(arg)
				-- 		print(arg)
				-- 		vim.snippet.expand(arg.body)
				-- 	end,
				-- },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-p>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),

				sources = cmp.config.sources({
					{ name = "snp" },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "luasnip", group_index = 1, max_item_count = 5 },
					{ name = "nvim_lua", group_index = 1, max_item_count = 5 },
					-- { name = "copilot", group_index = 2, max_item_count = 5 },
					-- { name = "codeium", group_index = 2, max_item_count = 5 },
					{ name = "path", gorud_index = 2, max_item_count = 5 },
					{ name = "emoji", group_index = 3, max_item_count = 2 },
				}, {
					{ name = "buffer", max_item_count = 5 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							ellipsis_char = "...",
							-- menu = {
							-- 	buffer = "[Buffer]",
							-- 	nvim_lsp = "[LSP]",
							-- 	luasnip = "[LuaSnip]",
							-- 	nvim_lua = "[Lua]",
							-- 	snp = "[Snippet]",
							-- 	-- codeium = "[Codeium]",
							-- 	-- copilot = "[Copilot]",
							-- },
							-- symbol_map = {
							-- 	Codeium = "",
							-- 	-- Copilot = ""
							-- },
						})(entry, vim_item)

						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			})
		end,
	},
}
