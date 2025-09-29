-- lazy.nvim
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
    styles = {
      custom_float = {
        width = 0.7,
        height = 0.7,
        border = "rounded",
        title = "Output",
        title_pos = "center",
      },
    },
    terminal = {
      -- your terminal configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      win = {
        style = "custom_float",
      },
    },
  },
}
