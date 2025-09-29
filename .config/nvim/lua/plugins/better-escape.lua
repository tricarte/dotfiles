return {
  "max397574/better-escape.nvim",
  lazy = true,
  event = { "VeryLazy" },
  -- event = { "InsertEnter" },
  opts = {
    config = function()
      require("better_escape").setup()
    end,
  },
}
