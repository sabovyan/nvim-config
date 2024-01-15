-- [[ Basic Keymaps ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- to keei the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- save file
vim.keymap.set(
	{ "i", "x", "n", "s" },
	"<C-s>",
	"<cmd>w<cr><esc>",
	{ silent = true, desc = "Save file" }
)

vim.keymap.set("n", "<leader>e", "<cmd>:Explore <CR>", { silent = true, desc = "[O]pen Netrw" })

vim.keymap.set("n", "<leader>cc", function()
	vim.cmd("let @+ = expand('%:p')")
end, { silent = true, desc = "[C]opy [F]ile [P]ath" })
