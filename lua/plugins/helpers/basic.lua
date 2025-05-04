return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function()
			local wk = require("which-key")

			wk.add({
				{ "<leader>g", group = "Git" },
				{ "<leader>c", group = "Code Action" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>f", group = "File" },
				{ "<leader>s", group = "Search" },
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		ft = { "python", "yaml" },
	},

	-- NOTE:  plugin to handle adding/removing/replacing surroundings (e.g {}, [], "" ...)
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {},
	},

	-- INFO comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			keywords = {
				-- TODO = { icon = " ", color = "#f29bf2" },
			},
			highlight = {
				before = "fg", -- "fg" or "bg" or empty
				keyword = "wide_fg",
				pattern = [[.*<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
			},
			search = {
				pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},

	-- INFO: auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},

	-- INFO: show colors based on hex
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
				enable_tailwind = true,
			})
		end,
	},
}
