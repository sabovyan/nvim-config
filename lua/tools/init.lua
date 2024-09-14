local utils = require("tools.split")

-- Function to check and highlight misspelled words using Tree-sitter
local function highlight_misspelled_words_with_treesitter()
	local ns_id = vim.api.nvim_create_namespace("spell_checker")
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

	local success, parser = pcall(vim.treesitter.get_parser, 0)
	if not success then
		print("Tree-sitter parser not available")
		return
	end

	local tree = parser:parse()[1]
	local root = tree:root()

	local query = vim.treesitter.query.parse(
		parser:lang(),
		[[
            (identifier) @identifier
            (variable) @variable
            ; (property_identifier) @property_identifier
            (string) @string
        ]]
	)

	for id, node in query:iter_captures(root, 0, 0, -1) do
		local name = query.captures[id]
		local text = vim.treesitter.get_node_text(node, 0)

		-- Skip keywords and built-in functions
		if name == "identifier" or name == "variable" or name == "property_identifier" then
			local parts = utils.split_text_to_words(text)

			if not parts then
				return
			end

			for _, part in ipairs(parts) do
				if vim.fn.spellbadword(part)[1] ~= "" then
					local row1, col1, row2, col2 = node:range()
					local part_start_pos = col1
					local part_end_pos = part_start_pos + #part
					vim.api.nvim_buf_add_highlight(
						0,
						ns_id,
						"SpellBad",
						row1,
						part_start_pos,
						part_end_pos
					)
				end
			end
		end
	end
end

-- vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
-- 	pattern = "*",
-- 	callback = highlight_misspelled_words_with_treesitter,
-- })

-- -- Debounced function call to avoid performance issues
-- local function debounced_highlight()
-- 	local timer = vim.uv.new_timer()
-- 	timer:stop()
-- 	timer:start(200, 0, vim.schedule_wrap(highlight_misspelled_words_with_treesitter))
-- end
--
-- -- Autocommand to run the highlighting function after specific events
-- vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
-- 	pattern = "*",
-- 	callback = debounced_highlight,
-- })
