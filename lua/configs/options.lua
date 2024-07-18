-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.wrap = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Set highlight on search
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.colorcolumn = "80"

vim.cmd.colorscheme("habamax")

vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- to hilight current line
vim.o.cursorline = true

-- fold settings
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 20
