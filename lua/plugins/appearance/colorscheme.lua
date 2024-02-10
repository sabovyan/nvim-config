return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- lazy = true,
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
						base = "#161823",
					},
				},
				custom_highlights = function(c)
					return {

						-- tree-sitter
						["@variable"] = { fg = c.yellow },
						["@none"] = { fg = c.overlay2, style = { "italic" } },
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
	-- {
	--
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "storm",
	-- 			on_highlights = function(hl, c)
	-- 				local prompt = "#2d3149"
	-- 				hl.TelescopeNormal = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.fg_dark,
	-- 				}
	-- 				hl.TelescopeBorder = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 				hl.TelescopePromptNormal = {
	-- 					bg = prompt,
	-- 				}
	-- 				hl.TelescopePromptBorder = {
	-- 					bg = prompt,
	-- 					fg = prompt,
	-- 				}
	-- 				hl.TelescopePromptTitle = {
	-- 					bg = prompt,
	-- 					fg = prompt,
	-- 				}
	-- 				hl.TelescopePreviewTitle = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 				hl.TelescopeResultsTitle = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 			end,
	-- 		})
	-- 		-- load the colorscheme here
	-- 		-- vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
}
