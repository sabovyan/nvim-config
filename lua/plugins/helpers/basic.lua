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

			wk.register({
				g = { name = "[G]it" },
				c = { name = "[C]ode [A]ction" },
				b = { name = "[B]uffer" },
				f = { name = "[F]ile" },
				s = { name = "[S]earch" },
			}, { prefix = "<leader>" })
		end,
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

	-- INFO: buffer remove
	{
		"echasnovski/mini.bufremove",

		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(
							("Save changes to %q?"):format(vim.fn.bufname()),
							"&Yes\n&No\n&Cancel"
						)
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },

		lazy = false,
		config = function()
			vim.g.skip_ts_context_commentstring_module = true

			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
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
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	opts = {
	-- 		-- debug = true, -- Enable debugging
	-- 		-- See Configuration section for rest
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },
}
