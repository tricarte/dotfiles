local va = vim.api
local fzf_lua = require("fzf-lua")

-- SnpNew command
va.nvim_create_user_command("SnpNew", function(_)
  local tmpfile = vim.fn.system("snpcl new")
  vim.cmd(string.format(
    [[
    edit %s
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

-- SnpCloneLast command
va.nvim_create_user_command("SnpCloneLast", function(_)
  local tmpfile = vim.fn.system("snpcl clone")
  vim.cmd(string.format(
    [[
    edit %s
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

-- SnpEditLast command
va.nvim_create_user_command("SnpEditLast", function(_)
  local tmpfile = vim.fn.system("snpcl read -s last")
  vim.cmd(string.format(
    [[
    edit %s
  ]],
    tmpfile
  ))
end, { nargs = 0, bang = true })

-- SnpSave command
-- TODO: when a snippet saved for the first time, return the whole toml file as a response
va.nvim_create_user_command("SnpSave", function(_)
  vim.cmd("silent! w")
  local obj = vim.system({ "snpcl", "save", "-f", vim.fn.expand("%") }, { text = true }):wait()
  if obj.stdout == "success\n" then
    remove_file_and_buffer(1)
    vim.notify("Snippet saved succesfully!", vim.log.levels.INFO)
  else
    vim.notify(obj.stderr, vim.log.levels.ERROR)
  end
end, { nargs = 0, bang = true })

-- SnpSyn command
va.nvim_create_user_command("SnpSyn", function(_)
  if vim.bo.filetype ~= "toml" then
    vim.notify("Filetype is not toml!", vim.log.levels.ERROR)
    return
  end
  -- local syntaxes = vim.fn.systemlist({ "snpcl", "syn" })
  -- format = function(item, picker)
  --   return { { string.upper(item.text) } }
  -- end,
  fzf_lua.fzf_exec("snpcl syn", {
    fzf_opts = {
      ["--multi"] = false,
    },
    fn_transform = function(x)
      return string.upper(x)
    end,
    actions = {
      ["default"] = function(selected, opts)
        local line = vim.fn.search("type=", "bw")
        vim.fn.setline(line, "type='" .. string.lower(selected[1]) .. "'")
      end,
    },
  })
end, { nargs = 0, bang = true })

-- SnpParent command
va.nvim_create_user_command("SnpParent", function(_)
  if vim.bo.filetype ~= "toml" then
    vim.notify("Filetype is not toml!", vim.log.levels.ERROR)
    return
  end
  fzf_lua.fzf_exec("snpcl categories", {
    fzf_opts = {
      ["--multi"] = false,
      ["--delimiter"] = "\t",
      ["--with-nth"] = "2",
    },
    actions = {
      ["default"] = function(selected, opts)
        local parent = {} -- {parent-id, parent-title}
        for item in selected[1]:gmatch("[^\t]+") do
          table.insert(parent, item)
        end
        local line = vim.fn.search("\\[parent\\]")
        vim.fn.setline(line + 1, "id='" .. parent[1] .. "' # " .. parent[2])
      end,
    },
  })
end, { nargs = 0, bang = true })

-- local on_exit = function(obj)
--   print(obj.code)
--   print(obj.signal)
--   print(obj.stdout)
--   print(obj.stderr)
-- end
--
-- -- Runs asynchronously:
-- vim.system({ "echo", "hello" }, { text = true }, on_exit)
--
-- -- Runs synchronously:
-- local obj = vim.system({ "echo", "hello" }, { text = true }):wait()
-- -- { code = 0, signal = 0, stdout = 'hello\n', stderr = '' }
