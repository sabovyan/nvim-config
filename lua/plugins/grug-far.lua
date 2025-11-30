return {
  'MagicDuck/grug-far.nvim',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
  keys = {
    {
      '<leader>rr',
      function()
        require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = 'Open grug-far',
      mode = 'n',
    },
    {
      '<leader>rr',
      function()
        require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = 'Open grug-far',
      mode = 'v',
    },
  },
  
  opts = {},

  -- -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- -- additional lazy config to defer loading is not really needed...
  -- config = function()
  --   -- optional setup call to override plugin options
  --   -- alternatively you can set options with vim.g.grug_far = { ... }
  --   require('grug-far').setup({
  --     -- options, see Configuration section below
  --     -- there are no required options atm
  --   });
  -- end
}
