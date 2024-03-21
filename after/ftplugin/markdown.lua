vim.opt_local.conceallevel = 2

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre" }, {
	pattern = "blog/*.md",
	callback = function()
		vim.opt_local.wrap = true
	end,
})
