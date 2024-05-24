vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	else
		return "<Tab>"
	end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if vim.snippet.active({ direction = -1 }) then
		return "<cmd>lua vim.snippet.jump(-1)<cr>"
	else
		return "<Tab>"
	end
end, { expr = true })

local snippets = require("configs.snippet.mapping")
local global_snippets = snippets.global_snippets
local snippets_by_filetype = snippets.snippets_by_filetype

local function get_buf_snips()
	local ft = vim.bo.filetype
	local snips = vim.list_slice(global_snippets)

	if ft and snippets_by_filetype[ft] then
		vim.list_extend(snips, snippets_by_filetype[ft])
	end

	return snips
end

local M = {}

-- cmp source for snippets to show up in completion menu
function M.register_cmp_source()
	local cmp_source = {}
	local cache = {}
	function cmp_source.complete(_, _, callback)
		local bufnr = vim.api.nvim_get_current_buf()

		if not cache[bufnr] then
			local completion_items = vim.tbl_map(function(s)
				---@type lsp.CompletionItem
				local item = {
					word = s.trigger,
					label = s.trigger,
					kind = vim.lsp.protocol.CompletionItemKind.Snippet,
					insertText = s.body,
					insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
				}

				return item
			end, get_buf_snips())

			cache[bufnr] = completion_items
		end

		print(cache)

		callback(cache[bufnr])
	end

	require("cmp").register_source("snp", cmp_source)
end

return M
