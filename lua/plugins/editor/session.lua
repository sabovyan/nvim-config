return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
		options = { "buffers", "curdir", "winsize" }, -- sessionoptions used for saving
	},
}
