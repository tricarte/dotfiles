local va = vim.api
local env = vim.env

if env.TERM == "xterm-kitty" then
  va.nvim_create_user_command("GN", function(_)
    local current_buffer_parent = vim.fn.expand("%:h")
    -- TODO: Convert this to a background job
    -- TODO: Try to use vim.system instead of vim.fn.system.
    vim.fn.system("kitty @ --to unix:/tmp/mykitty launch --type window --cwd " .. current_buffer_parent)
  end, { nargs = 0 })
end

va.nvim_create_user_command("FixDos", "e ++ff=dos", { nargs = 0 })

-- Apply macro to current line or to selection.
va.nvim_create_user_command("Macro", "<line1>,<line2>:norm! @<args>", { nargs = 1, range = "%", bang = true })

-- Read any shell command's output into the current line
va.nvim_create_user_command("Read", ":r !<args>", { nargs = 1, bang = true })

-- FX json viewer
if vim.fn.executable("fx") and env.TERM == "xterm-kitty" then
  va.nvim_create_user_command("FX", function(_)
    if vim.bo.filetype == "json" then
      vim.fn.system(
        "kitty @ --to unix:/tmp/mykitty launch --type window --env FX_COLLAPSED=1 fx " .. vim.fn.expand("%")
      )
    else
      vim.notify("Filetype is not json!", vim.log.levels.WARN)
    end
  end, { nargs = 0 })
end

va.nvim_create_user_command("RM", function(_)
  remove_file_and_buffer()
end, { nargs = 0 })

va.nvim_create_user_command("LoadAvg", function()
  load_avg()
end, { nargs = 0 })
