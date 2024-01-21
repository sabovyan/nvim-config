# TODO - NeoVim Setup

## General

[ ] rearrange plugins in a way that they are grouped by their purpose

## Thing to check out

- [ ] [Dropbar](https://github.com/Bekaboo/dropbar.nvim)
- [ ] [neotest](https://github.com/nvim-neotest/neotest)
- [ ] [noice](https://github.com/folke/noice.nvim)
- [ ] [leap.nvim](https://github.com/ggandor/leap.nvim) **VS** [flash.nvim](https://github.com/folke/flash.nvim)
- [ ] [vim-illuminate](https://github.com/RRethy/vim-illuminate) **VS** [mini.cursorword](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md)

### netrw:

- [ ] fix netrw keymaps to be more intuitive especially for keymaps that are used for file management and shortcut for `A` to add file not the built in behavior

### Helpers:

- [ ] get count of highlighted text/words search (to be able to get info on that line)

> **word** `(ghost text) 1/3`

### Note Taking

- [ ] add not taking plugin

### Git:

- [ ] check out gh.nvim https://github.com/ldelossa/gh.nvim?tab=readme-ov-file
- [ ] setup to show git commits for one file and view diffs

### Navigation within the file:

- [ ] add `.env.*` to be searched by telescope

### Terminal

- [ ] have basic terminal setup
- [ ] have keymaps for terminal to open it on the buttom of the screen and as floating window

### hlpers:

- [ ] [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)

### Treesitter:

- [ ] _(optional)_ setup treesitter objects

### AutoComplete / Snippets:

[ ] **OPtional:** Add TailwindCSS colorizer CMP https://github.com/roobert/tailwindcss-colorizer-cmp.nvim

## LSP

- [ ] _(optional)_ think about restructuring of the lsp config in a way that every language server has it's own config file
- [ ] _(optional)_ addvanced Typescript setup

### Status line:

[ ] _Optional:_ Replace nvim-lualine/lualine.nvim

### Homemade Plugins:

1. [ ] Spell checker as it is done in VS Code

2. [ ] git commit diff view
       For an open buffer show the list of commits and on selection show the diff for that commit

3. [ ] translate typescript errors. references:

   - https://github.com/mattpocock/ts-error-translator
   - https://github.com/yoavbls/pretty-ts-errors

- [ ] create a plugin to do a code review in the editor
