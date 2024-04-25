return {
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local oil = require("oil")
			local cwd = require("utils.cwd")

			oil.setup({
				default_file_explorer = false,
				view_options = {
					is_hidden_file = function(name)
						return name == ".git"
					end,
				},
				win_options = {
					signcolumn = "yes:2",
				},
			})

			local function open_cwd()
				local dir = cwd.get_cwd()
				oil.open(dir)
			end

			local function open_root()
				oil.open(cwd.get_root())
			end

			vim.keymap.set("n", "<leader>e", open_cwd, { desc = "[Oil] Open CWD" })
			vim.keymap.set("n", "<leader>E", open_root, { desc = "[Oil] Open Root" })

			vim.keymap.set(
				"n",
				"<leader>o",
				"<CMD>Oil<CR>",
				{ desc = "[Oil] Open parent directory" }
			)
		end,
	},
	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			"stevearc/oil.nvim",
		},

		config = true,
	},
}
