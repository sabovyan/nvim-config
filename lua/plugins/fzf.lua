return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")
			local files_command = [[sh -c '(fd --color=never --hidden --type f --type l --exclude .git .; fd --color=never --hidden --no-ignore --type f --type l --exclude .git --exclude node_modules "^\\.env.*$" .) | sort -u']]

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
					cmd = files_command,
					winopts = {
						height = 0.8,
						width = 0.8,
						preview = {
							layout = "vertical",
							vertical = "down:45%",
						},
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

			vim.keymap.set("n", "<leader>gp", function()
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

			vim.keymap.set("n", "grr", function()
				fzf.lsp_references({
					winopts = {
						preview = {
							layout = "vertical",
							vertical = "down:45%",
						},
					},
				})
			end, { desc = "Find LSP References" })
		end,
	},
}
