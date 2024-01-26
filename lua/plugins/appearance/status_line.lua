return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function branch_name()
			local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

			if branch ~= "" then
				if #branch > 10 then
					local shortened_branch = string.sub(branch, 1, 10)
					return " " .. shortened_branch .. "..."
				else
					return " " .. branch
				end
			else
				return ""
			end
		end

		local function get_file_type()
			local extension = vim.fn.expand("%:e")
			local filetype = vim.fn.expand("%:t")

			local icon = require("nvim-web-devicons").get_icon(filetype, extension)

			if icon == nil then
				icon = "[ICON NOT FOUND]"
			end

			return extension .. " " .. icon
		end
		require("lualine").setup({
			sections = {
				lualine_b = { branch_name },
				lualine_c = {
					{
						"filename",
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},

				lualine_x = { "location" },
				lualine_y = {
					{
						"diff",
						symbols = { added = " ", modified = "󰝤 ", removed = " " },
					},
					"diagnostics",
				},
				lualine_z = { get_file_type },
			},
		})
	end,
}
