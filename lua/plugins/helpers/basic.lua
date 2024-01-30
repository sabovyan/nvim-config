return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function()
			local wk = require("which-key")

			wk.register({
				g = { name = "[G]it" },
				c = { name = "[C]ode [A]ction" },
				b = { name = "[B]uffer" },
				f = { name = "[F]ile" },
				s = { name = "[S]earch" },
			}, { prefix = "<leader>" })
		end,
	},

	-- NOTE:  plugin to handle adding/removing/replacing surroundings (e.g {}, [], "" ...)
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {},
	},

	-- INFO comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			highlight = {
				before = "fg", -- "fg" or "bg" or empty
				keyword = "wide",
				pattern = [[.*<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
			},
			search = {
				pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},

	-- INFO: auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	-- INFO: buffer remove
	{
		"echasnovski/mini.bufremove",

		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(
							("Save changes to %q?"):format(vim.fn.bufname()),
							"&Yes\n&No\n&Cancel"
						)
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },

		lazy = false,
		config = function()
			vim.g.skip_ts_context_commentstring_module = true

			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- INFO: show colors based on hex
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- INFO: a plugin to show
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}

-- INFO: Automatically highlights other instances of the word under your cursor.
-- {
-- 	"RRethy/vim-illuminate",
-- 	event = "VeryLazy",
-- 	opts = {
-- 		delay = 200,
-- 		large_file_cutoff = 2000,
-- 		large_file_overrides = {
-- 			providers = { "lsp" },
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		require("illuminate").configure(opts)

-- 		-- TODO: check keymaps and their need
-- 		--   local function map(key, dir, buffer)
-- 		--     vim.keymap.set("n", key, function()
-- 		--       require("illuminate")["goto_" .. dir .. "_reference"](false)
-- 		--     end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
-- 		--   end
-- 		--   map("]]", "next")
-- 		--   map("[[", "prev")
-- 		--   -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
-- 		--   vim.api.nvim_create_autocmd("FileType", {
-- 		--     callback = function()
-- 		--       local buffer = vim.api.nvim_get_current_buf()
-- 		--       map("]]", "next", buffer)
-- 		--       map("[[", "prev", buffer)
-- 		--     end,
-- 		--   })
-- 	end,
-- 	-- keys = {
-- 	--   { "]]", desc = "Next Reference" },
-- 	--   { "[[", desc = "Prev Reference" },
-- 	-- },
-- },
--
-- 	-- Better text-objects
-- 	{
-- 		"echasnovski/mini.ai",
-- 		-- keys = {
-- 		--   { "a", mode = { "x", "o" } },
-- 		--   { "i", mode = { "x", "o" } },
-- 		-- },
-- 		event = "VeryLazy",
-- 		opts = function()
-- 			local ai = require("mini.ai")
-- 			return {
-- 				n_lines = 500,
-- 				custom_textobjects = {
-- 					o = ai.gen_spec.treesitter({
-- 						a = {
-- 							"@block.outer",
-- 							"@conditional.outer",
-- 							"@loop.outer",
-- 						},
-- 						i = {
-- 							"@block.inner",
-- 							"@conditional.inner",
-- 							"@loop.inner",
-- 						},
-- 					}, {}),
-- 					f = ai.gen_spec.treesitter(
-- 						{ a = "@function.outer", i = "@function.inner" },
-- 						{}
-- 					),
-- 					c = ai.gen_spec.treesitter(
-- 						{ a = "@class.outer", i = "@class.inner" },
-- 						{}
-- 					),
-- 					t = {
-- 						"<([%p%w]-)%f[^<%w][^<>]->.-</%1>",
-- 						"^<.->().*()</[^/]->$",
-- 					},
-- 				},
-- 			}
-- 		end,
-- 		config = function(_, opts)
-- 			require("mini.ai").setup(opts)
-- 			-- register all text objects with which-key
-- 			require("lazyvim.util").on_load("which-key.nvim", function()
-- 				---@type table<string, string|table>
-- 				local i = {
-- 					[" "] = "Whitespace",
-- 					['"'] = 'Balanced "',
-- 					["'"] = "Balanced '",
-- 					["`"] = "Balanced `",
-- 					["("] = "Balanced (",
-- 					[")"] = "Balanced ) including white-space",
-- 					[">"] = "Balanced > including white-space",
-- 					["<lt>"] = "Balanced <",
-- 					["]"] = "Balanced ] including white-space",
-- 					["["] = "Balanced [",
-- 					["}"] = "Balanced } including white-space",
-- 					["{"] = "Balanced {",
-- 					["?"] = "User Prompt",
-- 					_ = "Underscore",
-- 					a = "Argument",
-- 					b = "Balanced ), ], }",
-- 					c = "Class",
-- 					f = "Function",
-- 					o = "Block, conditional, loop",
-- 					q = "Quote `, \", '",
-- 					t = "Tag",
-- 				}
-- 				local a = vim.deepcopy(i)
-- 				for k, v in pairs(a) do
-- 					a[k] = v:gsub(" including.*", "")
-- 				end
--
-- 				local ic = vim.deepcopy(i)
-- 				local ac = vim.deepcopy(a)
-- 				for key, name in pairs({ n = "Next", l = "Last" }) do
-- 					i[key] = vim.tbl_extend(
-- 						"force",
-- 						{ name = "Inside " .. name .. " textobject" },
-- 						ic
-- 					)
-- 					a[key] = vim.tbl_extend(
-- 						"force",
-- 						{ name = "Around " .. name .. " textobject" },
-- 						ac
-- 					)
-- 				end
-- 				require("which-key").register({
-- 					mode = { "o", "x" },
-- 					i = i,
-- 					a = a,
-- 				})
-- 			end)
-- 		end,
-- 	},
