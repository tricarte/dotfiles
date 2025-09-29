return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>bk", "<cmd>BufferLinePick<cr>", desc = "Pick buffer by letters" },
  },
  opts = {
    options = {
      always_show_bufferline = false,
      numbers = "ordinal",
      pick = {
        -- alphabet = "abcdefghijklmopqrstuvwxyz",
        alphabet = "1234567890",
      },
      separator_style = "slope",
      -- indicator = {
      --   style = "underline",
      -- },
    },
  },
  -- init = function()
  --   local bufline = require("catppuccin.groups.integrations.bufferline")
  --   function bufline.get()
  --     return bufline.get_theme()
  --   end
  -- end,
}
