-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- NOTE: this is for Conform.nvim
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
		print("Auto Format Disabled For This Buffer")
	else
		vim.g.disable_autoformat = true

		print("Auto Format Disabled Globally")
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
	print("Auto Format Enabled")
end, {
	desc = "Re-enable autoformat-on-save",
})

-- treat .swcrc as json to use json syntax highlighting and jsonls for autocompletion
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".swcrc",
	command = "set filetype=json",
})
