---@param file_name string
---@return boolean
local function should_display_full_path(file_name)
	local exception_files = {
		"index.js",
		"index.tsx",
		"index.jsx",
		"index.ts",
		"init.lua",
	}

	return vim.tbl_contains(exception_files, file_name)
end

---@return string
local function get_file_modify_status()
	local modified = vim.fn.getbufvar(vim.fn.bufnr(), "&mod")
	local readonly = vim.fn.getbufvar(vim.fn.bufnr(), "&readonly")
	if modified == 1 then
		return ""
	elseif readonly == 1 then
		return ""
	else
		return ""
	end
end

local M = {}

--- @param branch string
function M.branch_name(branch)
	if branch ~= "" then
		if #branch > 10 then
			local shortened_branch = string.sub(branch, 1, 10)
			return shortened_branch .. "..."
		else
			return branch
		end
	else
		return ""
	end
end

local function get_file_icon()
	local extension = vim.fn.expand("%:e")
	local filetype = vim.bo.filetype

	local icon = require("nvim-web-devicons").get_icon(filetype, extension)
	if icon == nil then
		icon = "[ICON NOT FOUND]"
	end
	return icon
end

local function get_file_name_with_parent_dirs()
	local splitted_path = vim.fn.split(vim.fn.expand("%"), "/")
	local len = #splitted_path

	local short_path = ""

	for count = 1, len - 2 do
		local value = splitted_path[count]
		local letter = string.sub(value, 1, 1)
		short_path = short_path .. letter .. "/"
	end

	local asdf = short_path .. splitted_path[len - 1] .. "/" .. splitted_path[len]

	return asdf
end

function M.get_file_type()
	local extension = vim.fn.expand("%:e")

	local icon = get_file_icon()

	return extension .. " " .. icon
end

function M.get_file_name()
	local modifiedStatus = get_file_modify_status()

	local file_name = vim.fn.expand("%:t")

	if should_display_full_path(file_name) then
		local file_full_path = get_file_name_with_parent_dirs()
		file_name = file_full_path
	elseif file_name == "" then
		file_name = "[No Name]"
	end

	local icon = get_file_icon()

	return icon .. "  " .. file_name .. " " .. modifiedStatus
end

-- get vim mode
function M.get_vim_mode()
	local mode = vim.fn.mode()
	local modeMap = {
		n = " NORMAL",
		i = "  INSERT",
		c = " COMMAND",
		v = "󰒆 VISUAL",
		V = "󰒆 VISUAL LINE",
		[""] = "󰒆 VISUAL BLOCK",
		R = " REPLACE",
		s = "SELECT",
		S = "SELECT LINE",
		[""] = "SELECT BLOCK",
	}

	return modeMap[mode]
end

return M
