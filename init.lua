local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("configs")

require("lazy").setup({
	{ import = "plugins.appearance" },
	{ import = "plugins.version_control" },
	{ import = "plugins.navigation" },
	{ import = "plugins.editor" },
	{ import = "plugins.helpers" },
}, {
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "catppuccin", "habamax" },
	},
})
