# Neovim Config

### Package Manager

- [lazy.nvim]()

### LSP:

[x] keymaps - check out `plugins/lsp/on_attach.lua`

[x] supported LSP - check out `plugins/lsp/init.lua`

```lua
ensure_installed = {
    "lua_ls",
    "bashls",
    "cssls",
    "dockerls",
    "emmet_ls",
    "html",
    "intelephense",
    "svelte",
    "tailwindcss",
    "tsserver",
    "jsonls",
},

```

[x] additional dependencies - check out `plugins/lsp/init.lua`

```lua
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/SchemaStore.nvim",
		{ "folke/neodev.nvim", opts = {} },
	},
```

### AutoComplete / Snippets:

[x] `hrsh7th/nvim-cmp`

```lua
{
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "onsails/lspkind.nvim",
        {
            "Exafunction/codeium.nvim",
            config = function()
                require("codeium").setup({})
            end,
        },

        {
            "zbirenbaum/copilot-cmp",
            dependencies = {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                        filetypes = {
                            markdown = true,
                            help = true,
                        },
                    })
                end,
            },
            config = function()
                require("copilot_cmp").setup()
            end,
        },
    },
}
```

### Comments

- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [folke/todo-comments.nvim]()

### Format and Lint

- [stevearc/conform.nvim]()
- [nvim-lint]()

### Syntax Highlighting:

- [nvim-treesitter/nvim-treesitter]()

### Git:

- [lewis6991/gitsigns.nvim]()
- [kdheepak/lazygit.nvim]()

### Session manager:

- [folke/persistence.nvim]()

### Navigation:

- [nvim-telescope/telescope.nvim]()
- [nvim-telescope/telescope-live-grep-args.nvim]()
- [nvim-telescope/telescope-fzf-native.nvim]()
- [danielfalk/smart-open.nvim]()
- [Netrw]() - built in

### Colorscheme

- [catppuccin/nvim]()
- [folke/tokyonight.nvim]()

### Status line:

- [nvim-lualine/lualine.nvim]()

### Startup:

- [nvimdev/dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)

### Other Tools

- [ mini.bufremove ]()
- [todo-comments.nvim ]()
- [ mini.pairs ]()
- [ which-key.nvim ]()
- [ trouble.nvim ]()
