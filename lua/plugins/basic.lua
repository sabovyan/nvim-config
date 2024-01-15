return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
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
}
