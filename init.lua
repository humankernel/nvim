require "config.options"
require "config.lazy"

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable({
  "luals",
  "gopls",
  "clangd",
  -- python
  "pyright",
  "ruff",
})

