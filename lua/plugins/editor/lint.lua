return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPre" }, {
			pattern = { "*.ts", "*.tsx", "*.lua" },
			callback = function()
				require("lint").try_lint("cspell")
			end,
		})

		--- turns raw suggestions text into table
		--- format that we receive
		--- [word]:
		--- - version 1
		--- - version 2
		--- - version 3
		---@param text string
		---@return table<string> | string
		local function format_raw_suggestions(text)
			if not text or text == "" then
				return {}
			end

			local suggestions = {}

			for line in text:gmatch("[^\r\n]+") do
				-- Check if line starts with '- ' for a suggestion
				local suggestion = line:match("^%s*-%s+(.+)")

				-- should return the suggestion and break the loop if suggestion is like "version 1 *"
				-- the return value should be without "*"
				if suggestion and suggestion:match("(.+)%s+%*$") then
					return suggestion:match("(.+)%s+%*$")
				end

				if suggestion then
					table.insert(suggestions, suggestion)
				end
			end

			return suggestions
		end

		---@param word string
		local function get_suggestions_by_word(word)
			local handle = io.popen(string.format("cspell sug --num-suggestions=5 %s", word))

			if handle then
				local result = handle:read("*a")
				handle:close()

				return format_raw_suggestions(result)
			end
			return {}
		end

		local function show_suggestions()
			local word = vim.fn.expand("<cword>")

			local suggestions = get_suggestions_by_word(word)

			if #suggestions <= 0 then
				vim.notify("No suggestions found", vim.log.levels.INFO)
				return
			end

			if type(suggestions) == "string" then
				vim.cmd("normal! ciw" .. suggestions)
				return
			end

			vim.ui.select(suggestions, {
				prompt = "Select spelling suggestion",
				format_item = function(item)
					return item
				end,
			}, function(choice)
				if choice then
					vim.cmd("normal! ciw" .. choice)
				end
			end)
		end

		vim.keymap.set("n", "<leader>cs", show_suggestions, { desc = "Show spelling suggestions" })
	end,
}
