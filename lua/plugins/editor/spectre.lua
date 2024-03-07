return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	config = true,

	keys = {
		{
			"<leader>rr",
			'<cmd>lua require("spectre").toggle()<CR>',
			desc = "Toggle Spectre",
		},
		{
			"<leader>rw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
			desc = "Search current word",
		},
	},
}
