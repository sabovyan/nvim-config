return {
	"vuki656/package-info.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},

	lazy = true,
	ft = { "json" },

	-- cond = function()
	-- 	local file_name = vim.fn.expand("%:t")
	-- 	if file_name == "package.json" then
	-- 		return true
	-- 	end
	-- 	return false
	-- end,

	config = function()
		require("package-info").setup()

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
