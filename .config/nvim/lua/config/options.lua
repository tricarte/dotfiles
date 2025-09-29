-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.root_spec = { { ".git", "lua", "pubspec.yaml", "composer.json", "cargo.toml", "package.json", ".root" }, "cwd" }
vim.g.root_spec = {
  {
    ".git",
    "lua",
    "pubspec.yaml", -- dart
    "composer.json", -- php
    "cargo.toml", -- rust
    "package.json", -- javascript, typescript
    ".root", -- generic
    "v.mod", --vlang
    "go.mod", --golang
    "Gemfile", -- ruby
  },
  "cwd",
  "lsp",
}
-- vim.opt.sessionoptions = { "buffers", "tabpages", "folds", "curdir", "help" }
