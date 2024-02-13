return {
	"vuki656/package-info.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},

	lazy = true,
	ft = { "json" },

	config = function()
		require("package-info").setup({
			autostart = false,
			hide_up_to_date = true,
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>np",
			"<cmd>lua require('package-info').change_version()<cr>",
			{ silent = true, noremap = true }
		)

		-- Show dependency versions
		vim.keymap.set(
			{ "n" },
			"<LEADER>ns",
			require("package-info").show,
			{ silent = true, noremap = true, desc = "Package-info show outdated info" }
		)

		-- Hide dependency versions
		vim.keymap.set(
			{ "n" },
			"<LEADER>nh",
			require("package-info").hide,
			{ silent = true, noremap = true, desc = "package-info hide outdated info" }
		)

		-- Toggle dependency versions
		vim.keymap.set(
			{ "n" },
			"<LEADER>nt",
			require("package-info").toggle,
			{ silent = true, noremap = true, desc = "Toggle outdated Info" }
		)
	end,
}
