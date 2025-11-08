return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = { enabled = true },
      -- notifier = { enabled = true },
      -- scroll = { enabled = true },
      words = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      terminal = { enabled = true },
      lazygit = { enabled = true },
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      quickfile = { enabled = true },
      dim = { enabled = true },
      indent = {
        enabled = true,
        only_current = true,
      },
    },

    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete buffer",
      },
      {

        "<leader>cn",
        function()
          Snacks.words.jump(1, true)
        end,
        desc = "Next Usage",
      },
      {

        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Zen Mode",
      },
    },
  },
}
