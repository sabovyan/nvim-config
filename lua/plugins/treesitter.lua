return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",

	config = function()
		-- [[ Configure Treesitter ]]
		-- See `:help nvim-treesitter`
		require("nvim-treesitter.configs").setup({

			ensure_installed = {
				"lua",
				"tsx",
				"json",
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
				"vim",
				"gitignore",
				"query",
				-- 'rust',
				"vimdoc",
				"dockerfile",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
		})
	end,
}
