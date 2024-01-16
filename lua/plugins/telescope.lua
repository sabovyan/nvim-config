-- plugins/telescope.lua:
return {

	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		{
			"danielfalk/smart-open.nvim",
			branch = "0.2.x",
			config = function() end,
			dependencies = {
				"kkharji/sqlite.lua",
			},
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
				path_display = { "truncate" },
				prompt_prefix = " ",
				selection_caret = "󰽐 ",
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-j>"] = actions.move_selection_next,
						["<c-k>"] = actions.move_selection_previous,
						["<s-k>"] = actions.cycle_history_prev,
						["<s-j>"] = actions.cycle_history_next,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
						["<C-w>"] = function()
							vim.api.nvim_input("<c-s-w>")
						end,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				live_grep_args = {
					-- path_display = { "shorten" },
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = {
						i = {
							["<C-f>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({
								postfix = " --iglob ",
							}),
						},
					},
				},
				smart_open = {
					show_scores = true,
					match_algorithm = "fzy",
					open_buffer_indicators = { previous = "👀", others = "🙈" },
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
				oldfiles = {
					sort_lastused = true,
					cwd_only = true,
				},
				find_files = {
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--color",
						"never",
						"--ignore-file",
					},
				},
			},
		})

		local builtin = require("telescope.builtin")

		local nmap = function(keys, func, desc, mode)
			if desc then
				desc = "Telescope: " .. desc
			end

			vim.keymap.set(mode or "n", keys, func, { silent = true, desc = desc })
		end

		-- Git telescope
		nmap("<leader>gc", builtin.git_bcommits, "[C]urrent [B]uffer [H]istory")
		nmap("<leader>gC", builtin.git_commits, "[C]urrent [H]istory")
		nmap("<leader>gs", builtin.git_status, "[G]it [S]tatus")

		-- Files and buffers
		nmap("<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", "Buffers")

		local function find_files_by_workspace()
			-- get current buffer's root directory
			local b = vim.lsp.buf.list_workspace_folders()

			-- if we have a root dir, use it
			-- otherwise, use root directory
			local cwd = b and b[1] or vim.loop.cwd()

			builtin.find_files({ cwd = cwd })
		end

		nmap("<leader>:", "<cmd>Telescope command_history<cr>", "Command History")
		nmap("<leader>ff", find_files_by_workspace, "[F]ind Files [B]y [W]orkspace")
		nmap("<leader>fF", builtin.find_files, "Find Files [R]oot [D]ir")
		-- smart open
		vim.keymap.set("n", "<leader><leader>", function()
			require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
		end, { noremap = true, silent = true, desc = "[S]mart [F]ile [S]earch" })

		nmap("<leader>fr", "<cmd>Telescope oldfiles<cr>", "[O]pen [R]ecent [F]iles")

		-- Text Search
		local function search_text_in_workspace()
			local cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.loop.cwd()
			builtin.live_grep({ cwd = cwd })
		end

		nmap('<leader>s"', "<cmd>Telescope registers<cr>", "[R]egisters")
		nmap("<leader>sa", "<cmd>Telescope autocommands<cr>", "Auto Commands")
		nmap("<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer")
		nmap("<leader>sC", "<cmd>Telescope colorscheme<cr>", "Colorscheme with preview")
		nmap("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", "Document diagnostics")
		nmap("<leader>sD", "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics")
		nmap(
			"<leader>sf",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			"[A]dvanced [F]ind [G]rep [A]rgs"
		)

		nmap("<leader>sH", "<cmd>Telescope highlights<cr>", "Search Highlight Groups")
		nmap("<leader>sg", search_text_in_workspace, "[G]rep [W]orkspace")
		nmap("<leader>sG", builtin.live_grep, "[G]rep [R]oot [D]ir")

		nmap("<leader>sk", "<cmd>Telescope keymaps<cr>", "[S]earch [K]ey [M]aps")

		nmap("<leader>sm", "<cmd>Telescope marks<cr>", "Jump to Mark")
		nmap("<leader>so", "<cmd>Telescope vim_options<cr>", "Vim Options")

		local function grep_current_word_in_workspace()
			local opts = {}
			local word = vim.fn.expand("<cword>")

			opts.word_match = "-w"
			opts.search = word
			opts.cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.loop.cwd()

			builtin.grep_string(opts)
		end

		nmap("<leader>sw", grep_current_word_in_workspace, "[W]ord in [W]orkspace")

		local function grep_current_word_in_root()
			local opts = {}
			local word = vim.fn.expand("<cword>")
			opts.word_match = "-w"
			opts.search = word
			opts.cwd = vim.loop.cwd()
			builtin.grep_string(opts)
		end

		nmap("<leader>sW", grep_current_word_in_root, "[W]ord in [R]oot [D]ir")
		nmap("<leader>sw", grep_current_word_in_workspace, "[S]election [W]orkspace", "v")
		nmap("<leader>sW", grep_current_word_in_root, "[S]election [R]oot [D]ir", "v")

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "fzf")

		pcall(telescope.load_extension("live_grep_args"))
		pcall(telescope.load_extension("smart_open"))
	end,
}

-- path_display = function(_, path)
-- 	local filename = path:gsub(vim.pesc(vim.loop.cwd()) .. "/", "")
-- 		:gsub(vim.pesc(vim.fn.expand("$HOME")), "~")
-- 	local tail = require("telescope.utils").path_tail(filename)
-- 	return string.format("%s  —  %s", tail, filename)
-- end
