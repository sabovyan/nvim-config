return {
	{
		"github/copilot.vim",
		-- keys = {
		-- 	{
		-- 		"<leader>kk",
		-- 		"<cmd>Copilot panel<CR>",
		-- 		mode = { "n", "v" },
		-- 		desc = "Copilot Panel",
		-- 	},
		-- },
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = true,
		event = "VeryLazy",
		enabled = true,
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false, -- Enable debugging
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)

			vim.keymap.set("n", "<leader>ki", function()
				require("CopilotChat").toggle()
			end, { desc = "Toggle Copilot Chat" })
		end,
	},
}
