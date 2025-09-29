local va = vim.api
va.nvim_create_user_command("SnpNew", function(_)
  local tmpfile = vim.fn.system("snippet-writer-v new")
  vim.cmd(string.format(
    [[
    edit %s
    norm vin'
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

va.nvim_create_user_command("SnpCloneLast", function(_)
  local tmpfile = vim.fn.system("snippet-writer-v clone")
  vim.cmd(string.format(
    [[
    edit %s
    norm vin'
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

va.nvim_create_user_command("SnpEditLast", function(_)
  local tmpfile = vim.fn.system("snippet-writer-v read -s last")
  vim.cmd(string.format(
    [[
    edit %s
    norm vin'
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

-- TODO: when a snippet saved for the first time, return the whole toml file as a response
va.nvim_create_user_command("SnpSave", function(_)
  vim.cmd("silent! w")
  local obj = vim.system({ "snippet-writer-v", "save", "-f", vim.fn.expand("%") }, { text = true }):wait()
  if obj.stdout == "success\n" then
    remove_file_and_buffer(1)
    vim.notify("Snippet saved succesfully!", vim.log.levels.INFO)
  else
    vim.notify(obj.stderr, vim.log.levels.ERROR)
  end
end, { nargs = 0, bang = true })

va.nvim_create_user_command("SnpSyn", function(_)
  if vim.bo.filetype ~= "toml" then
    vim.notify("Filetype is not toml!", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.pick({
    finder = function()
      local syntaxes = vim.fn.systemlist({ "snippet-writer-v", "syn" })
      local items = {}
      for _, v in ipairs(syntaxes) do
        table.insert(items, {
          text = v,
        })
      end
      return items
    end,
    preview = function()
      return false
    end,
    format = function(item, picker)
      return { { item.text } }
    end,
    confirm = function(picker, item)
      picker:norm(function()
        if item then
          picker:close()
          local line = vim.fn.search("type=")
          vim.fn.setline(line, "type='" .. item.text .. "'")
        end
      end)
    end,
  })
end, { nargs = 0, bang = true })

va.nvim_create_user_command("SnpParent", function(_)
  if vim.bo.filetype ~= "toml" then
    vim.notify("Filetype is not toml!", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.pick({
    finder = function()
      local categories = vim.fn.systemlist({ "snippet-writer-v", "categories" })
      local items = {}
      for _, v in ipairs(categories) do
        table.insert(items, {
          text = v,
        })
      end
      return items
    end,
    preview = function()
      return false
    end,
    format = function(item, picker)
      local t = {} -- {parent-id, parent-title}
      for text in item.text:gmatch("[^\t]+") do
        table.insert(t, text)
      end
      return { { t[2] }, { " " }, { t[1], "SnacksPickerComment" } }
    end,
    confirm = function(picker, item)
      picker:norm(function()
        if item then
          picker:close()
          local parent = {} -- {parent-id, parent-title}
          for text in item.text:gmatch("[^\t]+") do
            table.insert(parent, text)
          end
          local line = vim.fn.search("\\[parent\\]")
          vim.fn.setline(line + 1, "id='" .. parent[1] .. "' # " .. parent[2])
        end
      end)
    end,
  })
end, { nargs = 0, bang = true })
