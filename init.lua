require("config.options")
require("config.keymaps")
require("config.autocmd")
require("core.lazy")
require("core.lsp")

vim.cmd.colorscheme("rose-pine")

-- local function macos_appearance()
--   local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
--
--   if not handle then
--     return "light"
--   end
--
--
--   local result = handle:read("*a")
--   handle:close()
--
--   if result:match("Dark") then
--     return "dark"
--   else
--     return "light"
--   end
-- end
--
--
--
-- if macos_appearance() == "dark" then
--   vim.o.background = "dark"
--
--   vim.cmd.colorscheme("rose-pine")
-- else
--   vim.o.background = "light"
--   vim.o.cursorline = false
--
--   vim.cmd("colorscheme rose-pine")
--
--   -- NOTE this are needed for light mode default theme
--   vim.opt.guicursor = {
--     -- "n-v-c:block-Cursor/lCursor-blinkon500-blinkoff500",
--     "i-ci:ver25-CursorInsert-blinkon500-blinkoff500",
--     "r-cr:hor20-CursorReplace-blinkon500-blinkoff500",
--   }
--   -- local main_cursor_color='#BEFC65'
--   -- vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = main_cursor_color })
--   -- vim.api.nvim_set_hl(0, "CursorInsert", { fg = "black", bg = main_cursor_color })
--   -- vim.api.nvim_set_hl(0, "CursorReplace", { fg = "black", bg = main_cursor_color })
-- end

