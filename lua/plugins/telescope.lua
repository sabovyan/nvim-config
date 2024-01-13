-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},

	keys = {
		{ "<leader>fR", "<cmd>Telescope lsp_references<cr>", desc = "find references" },
		{
			"<leader>fg",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			desc = "Find Text Pattern In All Files",
		},
		{
			"<leader>fs",
			"<cmd>Telescope spell_suggest<CR>",
			desc = "Spell",
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_bcommits<CR>",
			desc = "Current Buffer history",
		},
	},

	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		telescope.setup({
			defaults = {
				-- file_ignore_patterns = {
				-- 	"node_modules",
				-- 	"build",
				-- 	"dist",
				-- 	".next",
				-- 	"package-lock.json",
				-- 	"yarn.lock",
				-- 	".git",
				-- },
				selection_caret = "  ",
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-j>"] = actions.move_selection_next,
						["<c-k>"] = actions.move_selection_previous,
						["<s-k>"] = actions.cycle_history_prev,
						["<s-j>"] = actions.cycle_history_next,
						["<C-w>"] = function()
							vim.api.nvim_input("<c-s-w>")
						end,
					},
				},
				path_display = function(_, path)
					local filename = path:gsub(vim.pesc(vim.loop.cwd()) .. "/", "")
						:gsub(vim.pesc(vim.fn.expand("$HOME")), "~")
					local tail = require("telescope.utils").path_tail(filename)
					return string.format("%s  —  %s", tail, filename)
				end,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				live_grep_args = {
					-- path_display = { "shorten"},
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = {
						i = {
							["<C-f>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- theme = { }, -- use own theme spec
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
			},
			pickers = {
				oldfiles = {
					sort_lastused = true,
					cwd_only = true,
				},
				find_files = {
					theme = "dropdown",
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--color",
						"never",
						"--ignore-file",
						-- vim.env.XDG_CONFIG_HOME .. '/ripgrep/ignore',
					},
				},
				git_files = {
					theme = "dropdown",
				},
				-- git_bcommits = {
				--   theme = "dropdown",
				-- },
			},
			-- defaults = {
			--   mappings = {
			--     i = {
			--       ['<C-u>'] = false,
			--       ['<C-d>'] = false,
			--     },
			--   },
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>gd", builtin.git_bcommits, { silent = true, desc = "Shiiiz" })

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "fzf")

		pcall(telescope.load_extension("live_grep_args"))
	end,
}
