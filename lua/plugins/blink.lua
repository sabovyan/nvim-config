return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets'
    },

    version = '1.*',
    event = "VeryLazy",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { 
        preset = 'default',
        ["<Tab>"] = {
          function() -- sidekick next edit suggestion (check first)
            if require("sidekick").nes_jump_or_apply() then
              return true
            end
          end,
          "fallback",
        },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
        },
      },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning"
      }
    },
    opts_extend = { "sources.default" }
  }
}
