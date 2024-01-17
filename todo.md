# TODO

## Main Areas to work on:

- Inside buffer aka Coding
- Outside buffer aka Editor

## Inside buffer aka Coding

- [ ] LSP

  - [x] !!!!! :warning: keymps for LSP (!!!! not working now)
  - [ ] setup eslint and prettier in a way that when eslint and prettier config is available in the project, it uses that config to format. And when it is not there it should use prettier as a formatter.
  - [ ] jsonls SchemaStore.nvim Note, this provides schemas for jsonls but still depends on lspconfig.
  - [ ] addvanced Typescript setup
  - [ ] fix go to definition: it should go to definition of the symbol under the cursor and place that line in the middle of the screen
  - [ ] think about restructuring of the lsp config in a way that every language server has it's own config file

- [ ] AutoComplete / Snippets

  - [ ] Add TailwindCSS colorizer CMP https://github.com/roobert/tailwindcss-colorizer-cmp.nvim

- [ ] Format

  - [ ] fix slow formatting

- [ ] Keymaps

## Outside buffer aka Editor

- [ ] Treesitter

  - [x] setup treesitter
  - [ ] setup treesitter objects

- [ ] Colorscheme

  - [ ] setup colorscheme
  - [ ] setup colorscheme for Telescope

- [ ] Git

  - [ ] setup git
  - [ ] setup git keymaps

- [ ] Session manager

  - [ ] check out shada file
  - [ ] check out how to save view
  - [ ] // check out `:h Session`
        it could be better to save session every time on closing and have a shortcut that will open that session
        Also it's possible that the solution is in shada file
        more info here: https://neovim.io/doc/user/usr_21.html#21.3

- [ ] Status line

  - [ ] should display file name
  - [ ] could be great to show it on top of the screen
  - [ ] should show current file saved/not save status

- [ ] Telescope

  - [x] add telescope
  - [x] add keymaps
  - [x] handle pathname that shows up in telescope
  - [x] change coloescheme for Telescope
  - [ ] add `.env.*` to be searched by telescope

- [ ] netrw
- [x] setup file manipulation commands (copy, move, delete, **rename**) in netrw (won't do it)
- [x] setup netrw to opend in a prefered directory. you should find the closest directory that contains package.json

  - [x] also have option that will open the root directory

- [x] Keymaps
  - [x] buffer management `<leader> + bd`
  - [x] window management `ctrl + h/j/k/l`

| In Buffer / Coding | Outside Buffer / Editor |
| ------------------ | ----------------------- |
| - [ ] LSP          | - [ ] Treesitter        |

- [x] !!!!! :warning: keymps for LSP (!!!! not working now)
- [ ] setup eslint and prettier in a way that when eslint and prettier config is available in the project, it uses that config to format. And when it is not there it should use prettier as a formatter.
- [ ] jsonls SchemaStore.nvim Note, this provides schemas for jsonls but still depends on lspconfig.
- [ ] addvanced Typescript setup
- [ ] fix go to definition: it should go to definition of the symbol under the cursor and place that line in the middle of the screen
- [ ] think about restructuring of the lsp config in a way that every language server has it's own config file
