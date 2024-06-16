return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
				dim_inactive_windows = true,
				ui_contrast = "high",
				colours_override = function(palette)
					palette.bg0 = "#2a2e32"
				end,
			})

			vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = true,
				styles = {
					comments = { "italic" },
					keywords = { "italic" },
					strings = { "italic" },
				},
				dim_inactive = {
					enabled = true, -- dims the background color of inactive window
					shade = "light",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					mason = true,
					dashboard = true,
					which_key = false,
					headlines = true,
					lsp_trouble = true,
					notifier = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
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
			})

			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
}
