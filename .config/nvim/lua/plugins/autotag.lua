-- Use this as an alternative
-- https://github.com/tronikelis/ts-autotag.nvim
return {
  "windwp/nvim-ts-autotag",
  opts = {
    per_filetype = {
      ["php"] = {
        enable_close = false,
      },
    },
  },
}
