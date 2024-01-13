return {
	-- git signs highlights text that has changed since the list
	-- git commit, and also lets you interactively stage & unstage
	-- hunks in a commit.
	{
		"lewis6991/gitsigns.nvim",
		--		event = "LazyFile",
		config = function()
			local gc = require("gitsigns")
			gc.setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,

				-- on_attach = function(buffer)
				-- 	local gs = require("gitsigns")

				-- 	local function map(mode, l, r, desc)
				-- 		vim.keymap.set(
				-- 			mode,
				-- 			l,
				-- 			r,
				-- 			{ buffer = buffer, desc = desc }
				-- 		)
				-- 	end

				--  -- stylua: ignore start
				--  map("n", "]h", gs.next_hunk, "Next Hunk")
				--  map("n", "[h", gs.prev_hunk, "Prev Hunk")
				--  map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				--  map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				--  map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				--  map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				--  map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				--  map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				--  map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				--  map("n", "<leader>ghd", gs.diffthis, "Diff This")
				--  map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				--  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				-- end,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			vim.keymap.set(
				"n",
				"<leader>gg",
				"<cmd>LazyGit <CR>",
				{ desc = "Lazygit (root dir)" }
			)
		end,
	},
}
--
--  -- Automatically highlights other instances of the word under your cursor.
--   -- This works with LSP, Treesitter, and regexp matching to find the other
--   -- instances.
--  return {
--     "RRethy/vim-illuminate",
--     event = "LazyFile",
--     opts = {
--       delay = 200,
--       large_file_cutoff = 2000,
--       large_file_overrides = {
--         providers = { "lsp" },
--       },
--     },
--     config = function(_, opts)
--       require("illuminate").configure(opts)
--
--       local function map(key, dir, buffer)
--         vim.keymap.set("n", key, function()
--           require("illuminate")["goto_" .. dir .. "_reference"](false)
--         end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
--       end
--
--       map("]]", "next")
--       map("[[", "prev")
--
--       -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
--       vim.api.nvim_create_autocmd("FileType", {
--         callback = function()
--           local buffer = vim.api.nvim_get_current_buf()
--           map("]]", "next", buffer)
--           map("[[", "prev", buffer)
--         end,
--       })
--     end,
--     keys = {
--       { "]]", desc = "Next Reference" },
--       { "[[", desc = "Prev Reference" },
--     },
--   }
--
--
--   return  -- better diagnostics list and others
--   {
--     "folke/trouble.nvim",
--     cmd = { "TroubleToggle", "Trouble" },
--     opts = { use_diagnostic_signs = true },
--     keys = {
--       { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
--       { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
--       { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
--       { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
--       {
--         "[q",
--         function()
--           if require("trouble").is_open() then
--             require("trouble").previous({ skip_groups = true, jump = true })
--           else
--             local ok, err = pcall(vim.cmd.cprev)
--             if not ok then
--               vim.notify(err, vim.log.levels.ERROR)
--             end
--           end
--         end,
--         desc = "Previous trouble/quickfix item",
--       },
--       {
--         "]q",
--         function()
--           if require("trouble").is_open() then
--             require("trouble").next({ skip_groups = true, jump = true })
--           else
--             local ok, err = pcall(vim.cmd.cnext)
--             if not ok then
--               vim.notify(err, vim.log.levels.ERROR)
--             end
--           end
--         end,
--         desc = "Next trouble/quickfix item",
--       },
--     },
--   },
--
--   -- Finds and lists all of the TODO, HACK, BUG, etc comment
--   -- in your project and loads them into a browsable list.
--   {
--     "folke/todo-comments.nvim",
--     cmd = { "TodoTrouble", "TodoTelescope" },
--     event = "LazyFile",
--     config = true,
--     -- stylua: ignore
--     keys = {
--       { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
--       { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
--       { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
--       { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
--       { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
--       { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
--     },
--   },
-- }
