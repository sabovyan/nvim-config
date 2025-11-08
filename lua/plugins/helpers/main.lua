return {
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {
	--
	--    },
	-- 	ft = { "python", "yaml" },
	-- },
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {},
  },
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
  {
    "axelvc/template-string.nvim",
    config = true,
    opts = {},
    ft = {
      "html",
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "vue",
      "svelte",
      "python",
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      keywords = {
        -- TODO = { icon = " ", color = "#f29bf2" },
      },
      highlight = {
        before = "fg",             -- "fg" or "bg" or empty
        keyword = "wide_fg",
        pattern = [[.*<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
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
