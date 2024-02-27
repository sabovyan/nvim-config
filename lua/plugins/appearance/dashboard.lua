return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local function append_empty_string(icon, suffix)
			if suffix then
				return icon .. suffix
			end

			return icon .. "    "
		end

		local DESCRIPTION_NAME_SUFFIX = "            "

		local function find_files()
			require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
		end

		local function new_file()
			vim.cmd.enew()
		end

		local function live_grep()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end

		local function quit()
			vim.cmd("q")
		end

		local function open_last_session()
			require("persistence").load()
		end

		local function open_explorer()
			vim.cmd.Ex()
		end

		local function open_lazy_git()
			vim.cmd("LazyGit")
		end

		local function get_neovim_version()
			local version_info = vim.version()
			local version_state = string.format(
				"%s.%s.%s",
				version_info.major,
				version_info.minor,
				version_info.patch
			)

			return version_state
		end

		local get_footer_info = function()
			local stats = require("lazy").stats()
			local loaded_plugins = stats.loaded
			local total_plugins = stats.count
			local updates = require("lazy.status").updates()
			if updates ~= false then
				updates = "󰆔   updates - " .. updates
			else
				updates = ""
			end

			return {
				"󱐋   plugins Loaded - " .. loaded_plugins .. "                ",
				"󰚥   plugins averall - " .. total_plugins .. "                ",
				updates .. "                         ",
			}
		end

		require("dashboard").setup({
			theme = "doom",
			disable_move = true,
			config = {
				header = {
					"",
					"",
					"Srinivasa Ramanujan (/ˈsriːnɪvɑːsə rɑːˈmɑːnʊdʒən; 22 December 1887 – 26 April 1920)",
					"Though he had almost no formal training in pure mathematics,",
					"he made substantial contributions to mathematical analysis, number theory, infinite series, and continued fractions.",
					"",
					"   learning -                         " .. DESCRIPTION_NAME_SUFFIX,
					"",
					"󱃖   codeing  -                         " .. DESCRIPTION_NAME_SUFFIX,
					"",
					"   personal -                         " .. DESCRIPTION_NAME_SUFFIX,
					"",
					-- "██████╗    ██████╗    █████╗   ██████╗   ██████╗  ",
					-- "██╔══██╗  ██╔═══██╗  ██╔══██╗  ██╔══██╗  ██╔══██╗ ",
					-- "██████╔╝  ██║   ██║  ███████║  ██████╔╝  ██║  ██║ ",
					-- "██╔══██╗  ██║   ██║  ██╔══██║  ██╔══██╗  ██║  ██║ ",
					-- "██████╔╝  ╚██████╔╝  ██║  ██║  ██║  ██║  ██████╔╝ ",
					-- "╚═════╝    ╚═════╝   ╚═╝  ╚═╝  ╚═╝  ╚═╝  ╚═════╝  ",
					"",
					"                                  " .. get_neovim_version(),
					"",
					"",
					"",
				},
				center = {
					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("New File", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "n",
						key_hl = "group",
						key_format = " %s",
						action = new_file,
					},
					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("Smart File Search", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "f",
						key_hl = "group",
						key_format = " %s",
						action = find_files,
					},
					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("Live Grep", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "l",
						key_hl = "group",
						key_format = " %s",
						action = live_grep,
					},
					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("Explorer", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "e",
						key_hl = "group",
						key_format = " %s",
						action = open_explorer,
					},
					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("LazyGit", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "g",
						key_hl = "group",
						key_format = " %s",
						action = open_lazy_git,
					},

					{
						icon = append_empty_string(""),
						icon_hl = "group",
						desc = append_empty_string("Session", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "group",
						key = "s",
						key_hl = "group",
						key_format = " %s",
						action = open_last_session,
					},
					{
						icon = append_empty_string("󰟶"),
						icon_hl = "string",
						desc = append_empty_string("Notes", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "string",
						key = "t",
						key_hl = "string",
						key_format = " %s",
						action = "Note",
					},
					{
						icon = append_empty_string(""),
						icon_hl = "Title",
						desc = append_empty_string("Lazy Plugin Manager", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "Title",
						key = "m",
						key_hl = "Title",
						key_format = " %s",
						action = ":Lazy",
					},
					{
						icon = append_empty_string("󰩈"),
						icon_hl = "Number",
						desc = append_empty_string("Quit", DESCRIPTION_NAME_SUFFIX),
						desc_hl = "Number",
						key = "q",
						key_hl = "Number",
						key_format = " %s",
						action = quit,
					},
				},
				footer = get_footer_info(),
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
