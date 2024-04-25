return {
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	priority = 1000, -- Ensure it loads first
	-- 	config = function()
	-- 		local color = require("onedarkpro.helpers")
	--
	-- 		local colors = color.get_colors()
	--
	-- 		require("onedarkpro").setup({
	-- 			highlights = {
	-- 				Comment = { italic = true },
	-- 				Directory = { bold = true },
	-- 				ErrorMsg = { italic = true, bold = true },
	--
	-- 				CursorLineNr = { fg = colors.orange },
	-- 				Folded = { fg = colors.yellow },
	--
	-- 				-- tree-sitter
	-- 				["@none"] = { fg = colors.comment, italic = true, underline = true },
	--
	-- 				["@punctuation.special.markdown"] = { fg = colors.cyan },
	-- 				["@punctuation.special.checked"] = { fg = colors.green },
	-- 			},
	-- 		})
	--
	-- 		vim.cmd("colorscheme onedark")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = true,
				transparent_background = true,
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
						["@markup.list.unchecked.markdown"] = { fg = colors.red },
						["@markup.list.unchecked"] = { fg = colors.red },
						["@markup.list.checked.markdown"] = { fg = colors.green },
						["@markup.list.checked"] = { fg = colors.green },
						["@markup.raw.block.markdown"] = { bg = colors.crust },
						["@markup.raw.block"] = { bg = colors.crust },
						["@markup.raw.delimiter"] = { bg = colors.crust },
					}
				end,
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
