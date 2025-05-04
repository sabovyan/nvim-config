return {
	{
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
				files = {
					cwd_prompt = false,
					winopts = {
						height = 1,
						width = 1,
					},
				},
				oldfiles = {
					cwd_prompt = false,
					winopts = {
						preview = {
							hidden = "hidden",
						},
					},
				},
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
			end, { desc = "Open Files" })

			vim.keymap.set("n", "<C-p>", function()
				fzf.files()
			end, { desc = "Open Files" })

			vim.keymap.set("n", "<leader>fr", function()
				fzf.oldfiles({
					cwd = vim.fn.getcwd(),
				})
			end, { desc = "Open Recent Files" })

			vim.keymap.set("n", "<leader><space>", function()
				fzf.buffers()
			end, { desc = "Open Buffers" })

			-- Search
			vim.keymap.set({ "n", "v" }, "<leader>sw", function()
				local cwd = require("utils.cwd")

				local function get_highlighted_text()
					vim.cmd('noau normal! "vy"')

					local text = vim.fn.getreg("v")
					vim.fn.setreg("v", {})

					text = string.gsub(text, "\n", "")

					return text
				end

				local function get_current_text()
					local mode = vim.api.nvim_get_mode()["mode"]

					if mode == "n" then
						return vim.fn.expand("<cword>")
					end

					local highlighted_text = get_highlighted_text()

					if #highlighted_text > 0 then
						return highlighted_text
					end

					return vim.fn.expand("<cword>")
				end

				-- fzf.builtin({
				-- 	search = get_current_text(),
				-- 	word_match = "-w",
				-- 	cwd = cwd.get_cwd(),
				-- })

				-- local function grep_current_word_in_root()
				-- 	local opts = {}
				-- 	local word = get_current_text()
				-- 	opts.word_match = "-w"
				-- 	opts.search = word
				-- 	opts.cwd = cwd.get_root()
				-- 	-- builtin.grep_string(opts)
				-- end

				fzf.grep_cword({ winopts = { fullscreen = true } })
			end, { desc = "Grep Current Word" })

			vim.keymap.set("n", "<leader>sf", function()
				fzf.live_grep({
					rg_glob = true, -- enable glob parsing by default to all. grep providers? (default:false)
					glob_flag = "--iglob", -- for case sensitive globs use '--glob'
					glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
					winopts = {
						fullscreen = true,
					},
				})
			end, { desc = "Grep Current Working Directory" })

			vim.keymap.set("n", "<leader>sH", function()
				fzf.highlights()
			end, { desc = "Search Highlights" })

			vim.keymap.set("n", "<leader>sm", function()
				fzf.marks()
			end, { desc = "Jump to Mark" })

			-- Git
			local git_options = { winopts = { fullscreen = true } }

			vim.keymap.set("n", "<leader>gs", function()
				fzf.git_status(git_options)
			end, { desc = "Git Status" })

			vim.keymap.set("n", "<leader>gc", function()
				fzf.git_bcommits(git_options)
			end, { desc = "Current Buffer History" })

			vim.keymap.set("n", "<leader>gC", function()
				fzf.git_commits(git_options)
			end, { desc = "Current History" })

			-- others
			vim.keymap.set("n", "<leader>:", function()
				fzf.command_history()
			end, { desc = "Command History" })

			vim.keymap.set("n", "<leader>;", function()
				fzf.help_tags()
			end, { desc = "Help Tags" })

			vim.keymap.set("n", "<leader>/", function()
				fzf.grep_curbuf(common_files_options)
			end, { desc = "Fuzzy Find In Current Buffer" })
		end,
	},
}
