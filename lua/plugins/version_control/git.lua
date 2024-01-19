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
				current_line_blame = true,
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
					map("n", "<leader>ghs", gs.stage_hunk, { desc = "[G]itsigns [S]tage hunk" })
					map("n", "<leader>ghr", gs.reset_hunk, { desc = "[G]itsigns [R]eset hunk" })
					map("n", "<leader>ghS", gs.stage_buffer)
					map("n", "<leader>ghu", gs.undo_stage_hunk)
					map("n", "<leader>ghp", gs.preview_hunk, { desc = "[G]itsigns [P]review hunk" })
					map("n", "<leader>ghb", function()
						gs.blame_line({ full = true })
					end, { desc = "[G]itsigns [P]review [B]uffer" })
					map(
						"n",
						"<leader>gtd",
						gs.toggle_deleted,
						{ desc = "[G]itsigns [T]oggle [D]eleted" }
					)
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
					-- map("n", "<leader>ghR", gs.reset_buffer)
					-- map("n", "<leader>gtb", gs.toggle_current_line_blame)
					-- map("n", "<leader>ghd", gs.diffthis, { desc = "[G]itsigns [D]iff [T]his" })
					-- map("n", "<leader>ghD", function()
					-- 	gs.diffthis("~")
					-- end)

					-- Text object
				end,
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
			vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit <CR>", { desc = "Lazygit (root dir)" })
		end,
	},
}
