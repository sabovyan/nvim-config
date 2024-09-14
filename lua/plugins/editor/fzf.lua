return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		-- Places the floating window at the bottom left corner
		require("fzf-lua").setup({})

		local git_options = { winopts = { fullscreen = true } }

		-- TODO add c-p also for other modes
		vim.keymap.set("n", "<C-p>", function()
			fzf.files()
		end)

		vim.keymap.set("n", "<C-\\>", function()
			fzf.buffers({
				winopts = {
					preview = {
						hidden = "hidden",
					},
				},
			})
		end)

		vim.keymap.set("n", "<C-g>", function()
			fzf.live_grep()
		end)

		vim.keymap.set("n", "<leader>h", function()
			fzf.git_bcommits(git_options)
		end)

		vim.keymap.set("n", "<leader>H", function()
			fzf.git_commits(git_options)
		end)

		-- vim.keymap.set('n', '<leader>fw' function ()
		--   fzf.grep_cword()
		--
		-- end)
	end,
}
