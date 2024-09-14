local utils = require("tools.split_utils")

local M = {}

---@param word string
function M.split_text_to_words(word)
	if not word then
		return
	end

	local words = {}

	local SNAKE_CASE = "[^_]+"
	local CAMEL_CASE = "[A-Z]?[a-z]*"

	local pattern = CAMEL_CASE

	if utils.isSnakeCase(word) then
		pattern = SNAKE_CASE
	end

	for found in word:gmatch(pattern) do
		local lowered = string.lower(found)
		table.insert(words, lowered)
	end

	return words
end

return M
