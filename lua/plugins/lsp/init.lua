local Util = require("plugins.lsp.on_attach")

return {
  "williamboman/mason-lspconfig.nvim",

  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "bashls",
        "cssls",
        "dockerls",
        "eslint",
        "emmet_ls",
        "html",
        "intelephense",
        "svelte",
        "tailwindcss",
        "tsserver",

      },
    })

    -- After setting up mason-lspconfig you may set up servejrs via lspconfig
    -- require("lspconfig").lua_ls.setup {}
    -- require("lspconfig").rust_analyzer.setup {}
    -- ...
    --
    --

    require("mason-lspconfig").setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
          on_attach = Util.on_attach,
        })
      end,
      ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          on_attach = Util.on_attach,

          settings = {
            Lua = {
              telemetry = { enable = false },
              workspace = { checkThirdParty = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    })
  end,
}
