-- Use this as an alternative
-- https://github.com/tronikelis/ts-autotag.nvim
return {
  "windwp/nvim-ts-autotag",
  -- url = "git@github.com:windwp/nvim-ts-autotag.git",
  opts = {
    per_filetype = {
      ["php"] = {
        enable_close = false,
      },
    },
  },
}
