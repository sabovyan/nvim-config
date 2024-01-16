return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			local wk = require("which-key")

			wk.register({
				g = { name = "[G]it" },
				c = { name = "[C]ode [A]ction" },
				b = { name = "[B]uffer" },
				f = { name = "[F]ile" },
				s = { name = "[S]earch" },
			}, { prefix = "<leader>" })
		end,
	},

	--- INFO: comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},

	-- INFO: auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	-- INFO: buffer remove
	{
		"echasnovski/mini.bufremove",

		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(
							("Save changes to %q?"):format(vim.fn.bufname()),
							"&Yes\n&No\n&Cancel"
						)
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},

	-- INFO: Automatically highlights other instances of the word under your cursor.
	-- {
	-- 	"RRethy/vim-illuminate",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		delay = 200,
	-- 		large_file_cutoff = 2000,
	-- 		large_file_overrides = {
	-- 			providers = { "lsp" },
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("illuminate").configure(opts)

	-- 		-- TODO: check keymaps and their need
	-- 		--   local function map(key, dir, buffer)
	-- 		--     vim.keymap.set("n", key, function()
	-- 		--       require("illuminate")["goto_" .. dir .. "_reference"](false)
	-- 		--     end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
	-- 		--   end
	-- 		--   map("]]", "next")
	-- 		--   map("[[", "prev")
	-- 		--   -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
	-- 		--   vim.api.nvim_create_autocmd("FileType", {
	-- 		--     callback = function()
	-- 		--       local buffer = vim.api.nvim_get_current_buf()
	-- 		--       map("]]", "next", buffer)
	-- 		--       map("[[", "prev", buffer)
	-- 		--     end,
	-- 		--   })
	-- 	end,
	-- 	-- keys = {
	-- 	--   { "]]", desc = "Next Reference" },
	-- 	--   { "[[", desc = "Prev Reference" },
	-- 	-- },
	-- },
}
