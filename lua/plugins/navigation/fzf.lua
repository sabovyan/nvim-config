return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		local common_files_options = {
			cwd_prompt = false,
			winopts = {
				preview = {
					hidden = "hidden",
				},
			},
		}

		fzf.setup({
			formatter = "path.filename_first",
			winopts = { preview = { title = false } },
			files = common_files_options,
			oldfiles = common_files_options,
			buffers = {
				winopts = {
					preview = {
						hidden = "hidden",
					},
				},
			},
		})

		-- Files
		vim.keymap.set("n", "<leader>ff", function()
			fzf.files()
		end, { desc = "[Open] [F]iles" })

		vim.keymap.set("n", "<leader>fr", function()
			fzf.oldfiles()
		end, { desc = "[Open] [R]ecent Files" })

		vim.keymap.set("n", "<leader><space>", function()
			fzf.buffers()
		end, { desc = "[Open] [B]uffers" })

		-- Search
		vim.keymap.set({ "n", "v" }, "<leader>sw", function()
			local function get_current_text()
				local mode = vim.api.nvim_get_mode()["mode"]

				if mode == "n" then
					return vim.fn.expand("<cword>")
				end

				local hilighted_text = get_hilighted_text()

				if #hilighted_text > 0 then
					return hilighted_text
				end

				return vim.fn.expand("<cword>")
			end

			fzf.builtin.grep_string({
				search = get_current_text(),
				word_match = "-w",
				cwd = cwd.get_cwd(),
			})

			-- local function grep_current_word_in_root()
			-- 	local opts = {}
			-- 	local word = get_current_text()
			-- 	opts.word_match = "-w"
			-- 	opts.search = word
			-- 	opts.cwd = cwd.get_root()
			-- 	-- builtin.grep_string(opts)
			-- end

			fzf.grep_cword()
		end, { desc = "[G]rep [C]urrent [W]ord" })

		vim.keymap.set("n", "<leader>sf", function()
			fzf.live_grep({
				rg_glob = true, -- enable glob parsing by default to all. grep providers? (default:false)
				glob_flag = "--iglob", -- for case sensitive globs use '--glob'
				glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
				winopts = {
					fullscreen = true,
				},
			})
		end, { desc = "[G]rep [C]urrent [W]orking [D]irectory" })

		vim.keymap.set("n", "<leader>sH", function()
			fzf.highlights()
		end, { desc = "[S]earch [H]ighlights" })

		vim.keymap.set("n", "<leader>sm", function()
			fzf.marks()
		end, { desc = "Jump to Mark" })

		-- Git
		local git_options = { winopts = { fullscreen = true } }

		vim.keymap.set("n", "<leader>gs", function()
			fzf.git_status(git_options)
		end, { desc = "[G]it [S]tatus" })

		vim.keymap.set("n", "<leader>gc", function()
			fzf.git_bcommits(git_options)
		end, { desc = "[C]urrent [B]uffer [H]istory" })

		vim.keymap.set("n", "<leader>gC", function()
			fzf.git_commits(git_options)
		end, { desc = "[C]urrent [H]istory" })

		-- others
		vim.keymap.set("n", "<leader>:", function()
			fzf.command_history()
		end, { desc = "[C]ommand [H]istory" })

		vim.keymap.set("n", "<leader>;", function()
			fzf.help_tags()
		end, { desc = "[H]elp [T]ags" })

		vim.keymap.set("n", "<leader>/", function()
			fzf.grep_curbuf(common_files_options)
		end, { desc = "[F]uzzy [F]ind [I]n [C]urrent [B]uffer" })
	end,
}
