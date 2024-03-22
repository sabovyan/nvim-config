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
		local cwd = require("utils.cwd")

		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["c-c"] = actions.close,
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
					match_algorithm = "fzf",
					open_buffer_indicators = { previous = "👀", others = "🙈" },
					ignore_patterns = { "*.git/*", "*/tmp/*", "node_modules" },
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
				git_commits = {
					mappings = {
						i = {
							["<c-y>"] = function(prompt_bufnr)
								-- copy selected entry / hash to global register or clipboard
								vim.fn.setreg("+", action_state.get_selected_entry().value)

								actions.close(prompt_bufnr)
							end,
						},
					},
					git_command = {
						"git",
						"log",
						"--pretty=%Cred%h%Creset %C(bold blue)<%an>%Creset %s %Cgreen(%cr)",
						"--abbrev-commit",
					},
				},
				git_bcommits = {
					mappings = {
						i = {
							["<c-y>"] = function(prompt_bufnr)
								-- copy selected entry / hash to global register or clipboard
								vim.fn.setreg("+", action_state.get_selected_entry().value)

								actions.close(prompt_bufnr)
							end,
						},
					},
					git_command = {
						"git",
						"log",
						"--pretty=%Cred%h%Creset %C(bold blue)<%an>%Creset %s %Cgreen(%cr)",
						"--follow",
						"--abbrev-commit",
					},
				},
				colorscheme = {
					enable_preview = true,
					theme = "dropdown",
				},
				lsp_references = {
					show_line = false,
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
		nmap(
			"<leader><space>",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
			"Buffers"
		)

		nmap("<leader>:", "<cmd>Telescope command_history<cr>", "Command History")
		nmap("<leader>fF", builtin.find_files, "Find Files [R]oot [D]ir")
		-- smart open
		nmap("<leader>ff", function()
			require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
		end, "[S]mart [F]ile [S]earch")

		nmap("<leader>fr", "<cmd>Telescope oldfiles<cr>", "[O]pen [R]ecent [F]iles")

		-- Text Search
		local function search_text_in_workspace()
			local dir = cwd.get_cwd()

			-- builtin.live_grep({ cwd = dir })
		end

		nmap("<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, "fuzzy find in Current Buffer")

		nmap('<leader>s"', "<cmd>Telescope registers<cr>", "[R]egisters")
		nmap("<leader>sa", "<cmd>Telescope autocommands<cr>", "Auto Commands")
		nmap(
			"<leader>sb",
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			"[F]uzzy [F]ind in [B]uffer"
		)
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

		local function get_hilighted_text()
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

			local hilighted_text = get_hilighted_text()

			if #hilighted_text > 0 then
				return hilighted_text
			end

			return vim.fn.expand("<cword>")
		end

		local function grep_current_word_in_workspace()
			local opts = {}
			local word = get_current_text()

			opts.word_match = "-w"
			opts.search = word
			opts.cwd = cwd.get_cwd()

			builtin.grep_string(opts)
		end

		nmap("<leader>sw", grep_current_word_in_workspace, "[W]ord in [W]orkspace")

		local function grep_current_word_in_root()
			local opts = {}
			local word = get_current_text()
			opts.word_match = "-w"
			opts.search = word
			opts.cwd = cwd.get_root()
			builtin.grep_string(opts)
		end

		nmap("<leader>sW", grep_current_word_in_root, "[W]ord in [R]oot [D]ir", { "v", "n" })
		nmap(
			"<leader>sw",
			grep_current_word_in_workspace,
			"[W]ord in [C]urrent [W]orkspace",
			{ "v", "n" }
		)

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "fzf")

		pcall(telescope.load_extension("live_grep_args"))
		pcall(telescope.load_extension("smart_open"))
	end,
}
