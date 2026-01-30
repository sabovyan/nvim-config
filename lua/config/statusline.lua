local M = {}

-- Create bold versions of diagnostic highlight groups
local function setup_bold_highlights()
	local error_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
	local warn_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
	local info_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })
	local hint_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })

	-- Copy all attributes and add bold
	vim.api.nvim_set_hl(0, "DiagnosticErrorBold", vim.tbl_extend("force", error_hl, { bold = true }))
	vim.api.nvim_set_hl(0, "DiagnosticWarnBold", vim.tbl_extend("force", warn_hl, { bold = true }))
	vim.api.nvim_set_hl(0, "DiagnosticInfoBold", vim.tbl_extend("force", info_hl, { bold = true }))
	vim.api.nvim_set_hl(0, "DiagnosticHintBold", vim.tbl_extend("force", hint_hl, { bold = true }))
end

-- Setup bold highlights after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = setup_bold_highlights,
})

-- Setup bold highlights now (in case colorscheme is already loaded)
setup_bold_highlights()

-- Get diagnostic counts and format with icons
local function get_diagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	local counts = vim.diagnostic.count(bufnr)

	if not counts or vim.tbl_isempty(counts) then
		return ""
	end

	local parts = {}

	-- Error (red, bold)
	if counts[vim.diagnostic.severity.ERROR] and counts[vim.diagnostic.severity.ERROR] > 0 then
		table.insert(parts, string.format("%%#DiagnosticErrorBold#󰅚 %d%%*", counts[vim.diagnostic.severity.ERROR]))
	end

	-- Warning (yellow/orange, bold)
	if counts[vim.diagnostic.severity.WARN] and counts[vim.diagnostic.severity.WARN] > 0 then
		table.insert(parts, string.format("%%#DiagnosticWarnBold#󰀪 %d%%*", counts[vim.diagnostic.severity.WARN]))
	end

	-- Info (blue, bold)
	if counts[vim.diagnostic.severity.INFO] and counts[vim.diagnostic.severity.INFO] > 0 then
		table.insert(parts, string.format("%%#DiagnosticInfoBold#󰋽 %d%%*", counts[vim.diagnostic.severity.INFO]))
	end

	-- Hint (cyan/teal, bold)
	if counts[vim.diagnostic.severity.HINT] and counts[vim.diagnostic.severity.HINT] > 0 then
		table.insert(parts, string.format("%%#DiagnosticHintBold#󰌶 %d%%*", counts[vim.diagnostic.severity.HINT]))
	end

	if #parts > 0 then
		return " " .. table.concat(parts, " ") .. " "
	end

	return ""
end

-- Build the complete statusline
function M.statusline()
	local diagnostics = get_diagnostics()

	return table.concat({
		" %f", -- filepath
		" %m", -- modified flag
		" %r", -- readonly flag
		"%=", -- right align
		diagnostics, -- diagnostic counts
		"%y", -- filetype
		" %l:%c", -- line:column
		" %p%% ", -- percentage through file
	})
end

-- Set the statusline
vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"

return M
