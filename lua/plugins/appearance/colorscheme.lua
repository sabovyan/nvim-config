return {
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
				color_overrides = {
					mocha = {
						base = "#181a1f",
					},
				},
				custom_highlights = function(colors)
					return {
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

			-- get catppuccin color style
			local function get_current_colorscheme()
				local colorscheme = vim.g.colors_name
				local splitted = {}

				for part in string.gmatch(colorscheme, "([^-]+)") do
					table.insert(splitted, part)
				end

				local style = splitted[2]
				local colors = require("catppuccin.palettes").get_palette(style)

				return colors
			end

			-- local insert_color = get_current_colorscheme().surface1
			--
			-- local reset_color = get_current_colorscheme().surface0
			--
			-- local change_cursorline_color = function(color)
			-- 	get_current_colorscheme()
			-- 	vim.cmd("highlight! CursorLine guibg=" .. color)
			-- end
			--
			-- vim.api.nvim_create_autocmd("InsertEnter", {
			-- 	callback = function()
			-- 		change_cursorline_color(insert_color)
			-- 	end,
			-- 	pattern = "*",
			-- })
			--
			-- vim.api.nvim_create_autocmd("InsertLeave", {
			-- 	callback = function()
			-- 		change_cursorline_color(reset_color)
			-- 	end,
			-- 	pattern = "*",
			-- })

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
