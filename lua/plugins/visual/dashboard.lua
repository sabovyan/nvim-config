return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local function find_files()
			require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
		end

		local function quit()
			vim.cmd("q")
		end

		local function open_last_session()
			print("in progress")
		end

		local function open_explorer()
			vim.cmd.Ex()
		end

		local function open_lazy_git()
			vim.cmd("LazyGit")
		end

		require("dashboard").setup({
			theme = "doom",
			disable_move = true,
			config = {
				header = {
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"██████╗    ██████╗    █████╗   ██████╗   ██████╗  ",
					"██╔══██╗  ██╔═══██╗  ██╔══██╗  ██╔══██╗  ██╔══██╗ ",
					"██████╔╝  ██║   ██║  ███████║  ██████╔╝  ██║  ██║ ",
					"██╔══██╗  ██║   ██║  ██╔══██║  ██╔══██╗  ██║  ██║ ",
					"██████╔╝  ╚██████╔╝  ██║  ██║  ██║  ██║  ██████╔╝ ",
					"╚═════╝    ╚═════╝   ╚═╝  ╚═╝  ╚═╝  ╚═╝  ╚═════╝  ",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				},
				center = {
					{
						icon = " ",
						icon_hl = "group",
						desc = "Find File    ",
						desc_hl = "group",
						key = " ",
						key_hl = "String",
						key_format = "<space>", -- remove default surrounding `[]`
						action = find_files,
					},
					{
						icon = " ",
						icon_hl = "group",
						desc = "Explorer    ",
						desc_hl = "group",
						key = "e",
						key_hl = "String",
						key_format = " %s", -- remove default surrounding `[]`
						action = open_explorer,
					},
					{
						icon = " ",
						icon_hl = "group",
						desc = "Git    ",
						desc_hl = "group",
						key = "g",
						key_hl = "String",
						key_format = " %s", -- remove default surrounding `[]`
						action = open_lazy_git,
					},

					{
						icon = " ",
						icon_hl = "group",
						desc = "Session   ",
						desc_hl = "group",
						key = "f",
						key_hl = "String",
						key_format = " %s", -- remove default surrounding `[]`
						action = open_last_session,
					},
					{
						icon = "󰩈 ",
						icon_hl = "Number",
						desc = "Quit",
						desc_hl = "Number",
						key = "q",
						key_hl = "String",
						key_format = " %s", -- remove default surrounding `[]`
						action = quit,
					},
				},
				footer = {}, --your footer
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
