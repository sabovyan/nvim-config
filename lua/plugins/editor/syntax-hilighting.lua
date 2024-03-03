return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- dependencies = {
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- },
		build = ":TSUpdate",

		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- NOTE: required by nvim-treesitter
					"lua",
					"vim",
					"vimdoc",
					"query",

					"tsx",
					"json",
					"jsdoc",
					"javascript",
					"typescript",
					"yaml",
					"html",
					"css",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"gitignore",
					"dockerfile",

					-- NOTE: project specific languages
					"php",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
	{
		"fladson/vim-kitty",
		ft = "kitty",
	},
}
