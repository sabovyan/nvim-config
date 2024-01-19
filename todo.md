# TODO

## Main Areas to work on:

| In Buffer / Coding | Outside Buffer / Editor | Comments                                                                                                        |
| ------------------ | ----------------------- | --------------------------------------------------------------------------------------------------------------- |
| LSP                | Treesitter              | _\*maybe treesitter should be part of LSP ?_ like each language should load/install its syntax witnin LSP setup |
| AutoComplete       | Colorscheme             |                                                                                                                 |
| Format             | Git                     | _\*find a good plugin to wok with commits PR's diff etc_                                                        |
| Lint               | Sessions                |                                                                                                                 |
| Comments           | Netrw                   |                                                                                                                 |
| Cursorline         | keymaps                 |                                                                                                                 |
|                    | startup                 |                                                                                                                 |
|                    | terminal                |                                                                                                                 |

## Inside buffer aka Coding

### Cursorline

- [ ] https://github.com/RRethy/vim-illuminate
- [ ] https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md

### LSP:

- [x] keymps for LSP
- [ ] setup eslint and prettier in a way that when eslint and prettier config is available in the project, it uses that config to format. And when it is not there it should use prettier as a formatter.
- [x] jsonls SchemaStore.nvim Note, this provides schemas for jsonls but still depends on lspconfig.
- [ ] addvanced Typescript setup
- [x] _(not possible)_ fix go to definition: it should go to definition of the symbol under the cursor and place that line in the middle of the screen
- [ ] think about restructuring of the lsp config in a way that every language server has it's own config file

### AutoComplete / Snippets:

- [x] order autocomplete groups
- [ ] **OPtional:** Add TailwindCSS colorizer CMP https://github.com/roobert/tailwindcss-colorizer-cmp.nvim

### Helpers:

- [ ] get count of highlighted text/words search (to be able to get info on that line)

  > **word** `(ghost text) 1/3`

- [ ] translate typescript errors

- [x] Comments
  - [x] https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  - [x] https://github.com/numToStr/Comment.nvim
  - [x] make sure that it will work with tsx files

### Format:

- [ ] make format work faster

## Outside buffer aka Editor

### Visual:

- [ ] https://github.com/folke/noice.nvim

### Startup:

- [x] https://github.com/nvimdev/dashboard-nvim

### Note Taking

- [ ] add not taking plugin
- [ ] https://github.com/vuki656/package-info.nvim - show packages updates in package.json file
      not sure where does this package belongs

### Treesitter:

- [x] setup treesitter
- [ ] _(optional)_ setup treesitter objects

### Colorscheme:

- [x] setup colorscheme
- [x] setup colorscheme for Telescope

### Git:

- [x] setup gitsigns
- [x] setkup lazygit
- [ ] check out gh.nvim https://github.com/ldelossa/gh.nvim?tab=readme-ov-file
- [ ] setup to show git commits for one file and view diffs

### Session manager:

- [ ] check out shada file
- [ ] check out how to save view
- [ ] // check out `:h Session`
      it could be better to save session every time on closing and have a shortcut that will open that session
      Also it's possible that the solution is in shada file
      more info here: https://neovim.io/doc/user/usr_21.html#21.3

### Navigation within the file:

- [ ] leap.nvim https://github.com/ggandor/leap.nvim **VS** https://github.com/folke/flash.nvim

### Status line:

- [x] should display file name
- [x] could be great to show it on top of the screen - _not possible_
- [x] should show current file saved/not save status

### Telescope:

- [x] add telescope
- [x] add keymaps
- [x] handle pathname that shows up in telescope
- [x] change coloescheme for Telescope
- [ ] add `.env.*` to be searched by telescope

### netrw:

- [x] setup file manipulation commands (copy, move, delete, **rename**) in netrw (won't do it)
- [x] setup netrw to opend in a prefered directory. you should find the closest directory that contains package.json

  - [x] also have option that will open the root directory
- [ ] fix netrw keymaps to be more intuitive

### Keymaps:

- [x] buffer management `<leader> + bd`
- [x] window management `ctrl + h/j/k/l`

### Terminal

- [ ] have basic terminal setup
- [ ] have keymaps for terminal to open it on the buttom of the screen and as floating window

# V2 - TODO

1. [ ] rearrange plugins in a way that they are grouped by their purpose

- [ ] _Optional:_ Replace nvim-lualine/lualine.nvim

