return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    inlay_hints = { enabled = false },
    servers = {
      ruff = {
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git", "uv.lock" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
      },
      pyright = {
        -- Below cmd with bun does not work!
        -- Actually, it has started but completions did not work.
        -- cmd = { "bun", "/home/sagirbas/.local/share/nvim/mason/bin/pyright-langserver", "--stdio" },
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
          },
        },
      },
      -- Listing the lsp server like this below is enough to be installed.
      -- But, nvim-flutter/flutter-tools.nvim tells not to list dartls here.
      -- dartls = {},
      intelephense = {
        settings = {
          intelephense = {
            -- runtime = "/home/user/.bun/bin/bun",
            -- runtime = "/home/user/.volta/bin/node",
            -- runtime = vim.env.USER .. "/.volta/bin/node",
            -- format = { braces = "k&r" },
            -- environment = { phpVersion = "7.4.0" },
          },
        },
        -- root_dir = nil,
        -- root_dir = require("lspconfig").util.root_pattern(".git", "composer.json"),
        root_markers = { "composer.json", ".git" },
        -- cmd = { "/home/user/.bun/bin/bun", "/home/user/.npm-global/bin/intelephense", "--stdio" },
        cmd = { "intelephense", "--stdio" },
      },
    },
  },
}
