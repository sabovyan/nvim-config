return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local helpers = require("plugins.appearance.status_line.helpers")

		require("nvim-web-devicons").set_icon({
			oil = {
				icon = "󰍜",
				color = "#428850",
				cterm_color = "65",
				name = "Oil",
			},
		})

		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { helpers.get_vim_mode },
				lualine_b = { helpers.get_file_name },
				lualine_c = {
					{
						"branch",
						fmt = helpers.branch_name,
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						"diff",
						symbols = { added = " ", modified = "󰝤 ", removed = " " },
					},
					"diagnostics",
				},
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
