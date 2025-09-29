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
          -- intelephense = {
          --   runtime = "/home/user/.bun/bin/bun",
          -- },
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
