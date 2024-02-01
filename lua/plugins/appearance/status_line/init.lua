return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local helpers = require("plugins.appearance.status_line.helpers")

		require("lualine").setup({
			sections = {
				lualine_b = { helpers.branch_name },
				lualine_c = { helpers.get_file_name },
				lualine_x = { "location" },
				lualine_y = {
					{
						"diff",
						symbols = { added = " ", modified = "󰝤 ", removed = " " },
					},
					"diagnostics",
				},
				lualine_z = { helpers.get_file_type },
			},
		})
	end,
}
