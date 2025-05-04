return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,

		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_cursor = "orange"
			vim.g.gruvbox_material_dim_inactive_windows = 1
			vim.g.gruvbox_material_ui_contrast = "high"
			vim.cmd("set background=dark")
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	-- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			term_colors = true,
			transparent_background = false,
			styles = {
				comments = { "italic" },
				keywords = { "italic" },
				strings = { "italic" },
			},
			dim_inactive = {
				enabled = true,
				shade = "light",
				percentage = 0.15,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				mason = true,
				dashboard = true,
				which_key = false,
				headlines = true,
				lsp_trouble = true,
				notifier = true,
				fzf = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
			custom_highlights = function(colors)
				return {
					CursorLineNr = { fg = colors.peach },
					Folded = { fg = colors.yellow },

					-- tree-sitter
					TSNone = { fg = colors.overlay2, style = { "italic", "underline" } },
					TSTagAttribute = { fg = colors.rosewater, style = { "italic" } },

					["@tag.attribute"] = { link = "TSTagAttribute" },
					["@tag.attribute.tsx"] = { link = "TSTagAttribute" },
					["@none"] = { link = "TSNone" },
				}
			end,
		},
	},
}
