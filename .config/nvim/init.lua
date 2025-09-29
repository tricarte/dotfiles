-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.custom")
local vimconfig = vim.fn.stdpath("config")
vim.cmd("source " .. vimconfig .. "/vimrc/config.vimrc")
-- vim.cmd("source " .. vimconfig .. "/vimrc/run_buffer.vimrc")
