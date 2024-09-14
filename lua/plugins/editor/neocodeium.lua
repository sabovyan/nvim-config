-- add this to the file where you setup your other plugins:
return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<A-f>", neocodeium.accept)
		vim.keymap.set("i", "<A-e>", function()
			require("neocodeium").cycle_or_complete()
		end)
		vim.keymap.set("i", "<A-r>", function()
			require("neocodeium").cycle_or_complete(-1)
		end)
	end,
}
