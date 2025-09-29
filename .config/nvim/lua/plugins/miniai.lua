return {
  "nvim-mini/mini.ai",
  opts = function(_, opts)
    local line = function()
      vim.cmd("normal! ^")
      local head = vim.api.nvim_win_get_cursor(0)

      vim.cmd("normal! g_")
      local tail = vim.api.nvim_win_get_cursor(0)

      -- TODO: Match any non-whitespace character
      return { from = { line = head[1], col = head[2] + 1 }, to = { line = head[1], col = tail[2] + 1 } }
    end
    opts.custom_textobjects.L = line
    return opts
  end,
}
