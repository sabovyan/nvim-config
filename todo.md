# TODO - NeoVim Setup

## Main Areas to work on:

| In Buffer / Coding | Outside Buffer / Editor | Comments                                                                                         |
| ------------------ | ----------------------- | ------------------------------------------------------------------------------------------------ |
| LSP                | Treesitter              | _maybe treesitter should be part of LSP ? Each language should load its syntax witnin LSP setup_ |
| AutoComplete       | Colorscheme             |                                                                                                  |
| Format             | Git                     | _find a good plugin to wok with commits PR's diff etc_                                           |
| Lint               | Sessions                |                                                                                                  |
| Comments           | Netrw                   |                                                                                                  |
| Cursorline         | keymaps                 |                                                                                                  |
|                    | startup                 |                                                                                                  |
|                    | terminal                |                                                                                                  |

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

### Format:

- [stevearc/conform.nvim]()

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

# V2 - TODO

1. [ ] rearrange plugins in a way that they are grouped by their purpose

- [ ] _Optional:_ Replace nvim-lualine/lualine.nvim

## Thing to check out

- [ ] [Dropbar](https://github.com/Bekaboo/dropbar.nvim)
- [ ] [eotest](https://github.com/nvim-neotest/neotest)
- [ ] [noice](https://github.com/folke/noice.nvim)
- [ ] [leap.nvim](https://github.com/ggandor/leap.nvim) **VS** [flash.nvim](https://github.com/folke/flash.nvim)
- [ ] [vim-illuminate](https://github.com/RRethy/vim-illuminate) **VS** [mini.cursorword](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md)

### LSP

- [ ] think about restructuring of the lsp config in a way that every language server has it's own config file
- [ ] addvanced Typescript setup

### AutoComplete / Snippets:

- [ ] **OPtional:** Add TailwindCSS colorizer CMP https://github.com/roobert/tailwindcss-colorizer-cmp.nvim

### Helpers:

- [ ] get count of highlighted text/words search (to be able to get info on that line)

  > **word** `(ghost text) 1/3`

- [ ] translate typescript errors

### Note Taking

- [ ] add not taking plugin
- [ ] https://github.com/vuki656/package-info.nvim - show packages updates in package.json file
      not sure where does this package belongs

### Treesitter:

- [ ] _(optional)_ setup treesitter objects

### Git:

- [ ] check out gh.nvim https://github.com/ldelossa/gh.nvim?tab=readme-ov-file
- [ ] setup to show git commits for one file and view diffs

### Navigation within the file:

- [ ] add `.env.*` to be searched by telescope

### netrw:

- [ ] fix netrw keymaps to be more intuitive especially for keymaps that are used for file management and shortcut for `A` to add file not the built in behavior

### Terminal

- [ ] have basic terminal setup
- [ ] have keymaps for terminal to open it on the buttom of the screen and as floating window
