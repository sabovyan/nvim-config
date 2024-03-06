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

-- treat .swcrc as json to use json syntax highlighting and jsonls for autocompletion
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=sh",
})

-- Jump to last edit position on opening file
-- NOTE: should be checked
-- vim.cmd([[
--   au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
-- ]])

vim.api.nvim_create_autocmd("BufReadPost", {

	pattern = "*",
	desc = "Open file at the last position it was edited earlier",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	desc = "Disable insert mode for readonly files",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		local is_readonly = vim.bo[bufnr].readonly

		if is_readonly then
			vim.cmd("setlocal nomodifiable")
		end
	end,
})
