local split = require("split")

-- Function to print colored text using ANSI escape codes
local function coloredPrint(text, colorCode)
	local reset = "\27[0m"
	print(colorCode .. text .. reset)
end

-- Color codes
local colors = {
	black = "\27[30m",
	red = "\27[31m",
	green = "\27[32m",
	yellow = "\27[33m",
	blue = "\27[34m",
	magenta = "\27[35m",
	cyan = "\27[36m",
	white = "\27[37m",
	bold = "\27[1m",
	underline = "\27[4m",
}

---@param message string
---@param fn function
local function test(message, fn)
	local status, err = pcall(fn)
	if not status then
		coloredPrint("❌ " .. message .. " " .. err, colors.red)
	else
		coloredPrint("✅ " .. message .. " passed", colors.green)
	end
end

test("check snakecase", function()
	local res = split.split_word("spell_right")

	local expected = { "spell", "right" }

	for k, v in pairs(res) do
		assert(expected[k] == v, "not passed")
	end
end)

test("check camelcase", function()
	local res = split.split_word("spellRight")

	local expected = { "spell", "right" }

	for k, v in pairs(res) do
		assert(expected[k] == v, "\n Expected: " .. expected[k] .. "\n Actual " .. v)
	end
end)
