return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    inlay_hints = { enabled = false },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
          },
        },
      },
      dartls = {},
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
