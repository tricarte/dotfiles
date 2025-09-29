---@diagnostic disable: unused-function
function remove_file_and_buffer(skipConfirm)
  if vim.fn.executable("rip") == 0 then
    vim.notify("rip executable does not exist!", vim.log.levels.ERROR)
    return
  end

  skipConfirm = skipConfirm or 0
  local choice = 0

  if skipConfirm == 0 then
    choice = vim.fn.confirm("Trash this file? Default: No", "Yes\nNo", 2)
  else
    choice = 1
  end

  if choice == 1 then
    local obj = vim
      .system({ "rip", "--graveyard", string.format("/home/%s/.local/share/Trash/rip", vim.env.USER), vim.fn.expand("%") })
      :wait()
    if obj.code == 0 then
      vim.notify("File trashed!", vim.log.levels.INFO)
      vim.cmd("bd!")
    else
      vim.notify("Trash failed!\nMaybe the file doesnot exist.", vim.log.levels.ERROR)
    end
  end
end

function load_avg()
  vim.notify(vim.fn.system("loadavg"))
end
