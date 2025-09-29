vim.api.nvim_create_autocmd("FileType", {
  desc = "Set dictionary for text files",
  pattern = { "markdown", "text" },
  group = vim.api.nvim_create_augroup("setDictionary", {}),
  callback = function()
    vim.opt_local.dictionary:append("/usr/share/dict/words")
  end,
})

-- By default, nvim opens help and man pages in horizontal split
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
  desc = "Open help files in vertical split",
  pattern = { "*/doc/*", "man:/*" },
  group = vim.api.nvim_create_augroup("helpFiles", {}),
  callback = function()
    -- TODO: check the window width and act accordingly
    vim.cmd("wincmd L")
  end,
})
