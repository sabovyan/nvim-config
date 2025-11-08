---@brief
---
--- [cspell language server](https://github.com/vlabo/cspell-lsp)
---

---@type vim.lsp.Config
return {
  cmd = { 'cspell-lsp', '--stdio' },
  filetypes = {
    "go",
    "rust",
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "js",
    "ts",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "gitcommit"
  },
  root_markers = {
    '.git',
    'cspell.json',
    '.cspell.json',
    'cspell.json',
    '.cSpell.json',
    'cSpell.json',
    'cspell.config.js',
    'cspell.config.cjs',
    'cspell.config.json',
    'cspell.config.yaml',
    'cspell.config.yml',
    'cspell.yaml',
    'cspell.yml',
  },
}
