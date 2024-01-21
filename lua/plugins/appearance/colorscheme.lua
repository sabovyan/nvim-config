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
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					dashboard = true,
					which_key = false,
					headlines = true,
					lsp_trouble = true,
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
				-- 		color_overrides = {
				-- 			mocha = {
				-- 				flamingo = "#EA6962",
				-- 				pink = "#D3869B",
				-- 				mauve = "#D3869B",
				-- 				red = "#EA6962",
				-- 				maroon = "#EA6962",
				-- 				peach = "#BD6F3E",
				-- 				yellow = "#D8A657",
				-- 				green = "#A9B665",
				-- 				teal = "#89B482",
				-- 				sky = "#89B482",
				-- 				sapphire = "#89B482",
				-- 				blue = "#7DAEA3",
				-- 				lavender = "#7DAEA3",
				-- 				text = "#D4BE98",
				-- 				subtext1 = "#BDAE8B",
				-- 				subtext0 = "#A69372",
				-- 				overlay2 = "#8C7A58",
				-- 				overlay1 = "#735F3F",
				-- 				overlay0 = "#958272",
				-- 				surface2 = "#4B4F51",
				-- 				surface1 = "#2A2D2E",
				-- 				surface0 = "#232728",
				-- 				base = "#1D2021",
				-- 				mantle = "#191C1D",
				-- 				crust = "#151819",
				-- 			},
				-- 			latte = {
				-- 				rosewater = "#c14a4a",
				-- 				flamingo = "#c14a4a",
				-- 				pink = "#945e80",
				-- 				mauve = "#945e80",
				-- 				red = "#c14a4a",
				-- 				maroon = "#c14a4a",
				-- 				peach = "#c35e0a",
				-- 				yellow = "#a96b2c",
				-- 				green = "#6c782e",
				-- 				teal = "#4c7a5d",
				-- 				sky = "#4c7a5d",
				-- 				sapphire = "#4c7a5d",
				-- 				blue = "#45707a",
				-- 				lavender = "#45707a",
				-- 				text = "#654735",
				-- 				subtext1 = "#7b5d44",
				-- 				subtext0 = "#8f6f56",
				-- 				overlay2 = "#a28368",
				-- 				overlay1 = "#b6977a",
				-- 				overlay0 = "#c9aa8c",
				-- 				-- surface2 = "#A79C86",
				-- 				-- surface1 = "#C9C19F",
				-- 				-- surface0 = "#DFD6B1",
				-- 				base = "#fbf1c7",
				-- 				mantle = "#F3EAC1",
				-- 				crust = "#E7DEB7",
				-- 			},
				-- 		},
			})
			--
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
