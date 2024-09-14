-- # NOTE: How to
-- First part of the snippet should be keywords - fn, for, while etc
-- then should come the description
-- @example `fnl` fn - function , l - local
--
--

local M = {}

-- Define a custom type for the table structure
---@class Snippet
---@field trigger string
---@field body string

---@param table1 Snippet The first table to merge
---@param table2 Snippet The second table to merge
---@return Snippet
local function merge_two_tables(table1, table2)
	-- Merge tables
	local merged_table = {}

	for k, v in pairs(table1) do
		merged_table[k] = v
	end

	for k, v in pairs(table2) do
		merged_table[k] = v
	end

	return merged_table
end

local function get_lua_snippets()
	return {
		{ trigger = "fnl", body = "local function ${1:name}(${2:args}) $0 end" },
	}
end

local function get_common_js_snippets()
	return {
		{ trigger = "fnf", body = "function $TM_FILENAME_BASE(${2:args}) {\n \t $0 \n}" },
		{ trigger = "while", body = "while(${1:condition}) {\n\t\n}" },
		{
			trigger = "for",
			body = "for (let ${1:i = 0}; ${2:i < length}; ${3: i+= 1}) {\n\t$0 \n\n}",
		},
	}
end

---@type Snippet
M.global_snippets = {
	{ trigger = "bang", body = "#!/bin sh" },
}

M.snippets_by_filetype = {
	---@type Snippet
	lua = get_lua_snippets(),

	---@type Snippet
	typescript = get_common_js_snippets(),
	---@type Snippet
	javascript = get_common_js_snippets(),
	---@type Snippet
	typescriptreact = {
		{
			trigger = "fc",
			body = "interface Props {\n}\nexport function $TM_FILENAME_BASE(${1:args}) {\n\t return ( \n\t\t<div>\n\t\t\t<h1>${2:hello}</h1>\n\t\t</div>\n\t)\n}",
		},
		{
			trigger = "npc",
			body = "interface Props {\n}\n\nexport default function $TM_DIRECTORY({}: Props) {\n return (\n\t\t<div>\n\t\t\t<h1>hello</h1>\n\t\t</div>\n\t)\n}",
		},
		{
			trigger = "rsh",
			body = "const [ ${1}, set${1/(.*)/capitalize} ] = useState${2}()",
		},
		{
			trigger = "fnf",
			body = "function ${TM_DIRECTORY:/(.*)/capitalize}(${2:args}) {\n \t $0 \n}",
		},
		{ trigger = "while", body = "while(${1:condition}) {\n\t\n}" },
		{
			trigger = "for",
			body = "for (let ${1:i = 0}; ${2:i < length}; ${3: i+= 1}) {\n\t$0 \n\n}",
		},
	},
}

return M
