return {
  "rolv-apneseth/tfm.nvim",
  lazy = false,
  opts = {
    file_manager = "lf",
    replace_netrw = true,
    enable_cmds = true,
    ui = {
      border = "single",
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,
    },
  },
  keys = {
    -- Make sure to change these keybindings to your preference,
    -- and remove the ones you won't use
    {
      "<leader>tf",
      function()
        require("tfm").open()
      end,
      desc = "Pick file using lf",
    },
    {
      "<leader>tF",
      function()
        require("tfm").open(LazyVim.root())
      end,
      desc = "Pick file using lf (Root)",
    },
  },
}
