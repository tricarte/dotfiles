-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local vk = vim.keymap

-- Pick buffer by numbers <Leader>1, <Leader>2, etc...
for i = 1, 9, 1 do
  vk.set("n", "<Leader>" .. i, "<Leader>bk" .. i, { desc = "Pick buffer " .. i, remap = true })
end

-- Write (save) file
vk.set("n", ",w", "<cmd>w!<CR>")

-- Find only home files.
vk.set("n", "<leader>fh", function()
  Snacks.picker.files({ cwd = "~", args = { "--exact-depth", "1" } })
end, { desc = "Find only home files" })

-- Find only sibling files.
vk.set("n", "<leader>fo", function()
  Snacks.picker.files({ cwd = vim.fn.expand("%:h"), args = { "--exact-depth", "1" } })
end, { desc = "Find sibling files" })

-- List some places on the filesystem to pick items from
vk.set("n", ",f", function()
  local source_list = {
    { text = "Notes", info = { type = "files", path = "~/Documents/notes" } },
    { text = "Etc", info = { type = "files", path = "/etc" } },
    { text = "Bin", info = { type = "files", path = "~/bin" } },
    { text = "Dotfiles", info = { type = "run", command = { source = "dfl" } } },
    { text = "Vimconfig", info = { type = "files", path = "~/.vim" } },
  }
  Snacks.picker.pick({
    items = source_list,
    format = function(item, picker)
      return { { item.text } }
    end,
    confirm = function(picker, item)
      if item then
        if item.info.type == "files" then
          Snacks.picker.files({ cwd = item.info.path })
        elseif item.info.type == "run" then
          Snacks.picker.pick({
            finder = function()
              local dotfiles = vim.fn.systemlist(item.info.command.source)
              local items = {}
              for _, v in ipairs(dotfiles) do
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
                  vim.cmd("e " .. item.text)
                end
              end)
            end,
          })
        end
      end
      picker:close()
    end,
    preview = function()
      return false
    end,
  })
end, { desc = "Find files from special places" })

-- Grep only sibling files.
vk.set("n", "<leader>so", function()
  Snacks.picker.grep({ cwd = vim.fn.expand("%:h"), args = { "--max-depth", "1" } })
end, { desc = "Grep only sibling files" })

-- Grep in dofiles.
-- vk.set("n", "<leader>df", function()
--   Snacks.picker.grep({ cwd = vim.fn.expand("%:h"), args = { "--max-depth", "1" } })
-- end, { desc = "Grep in dotfiles" })

vk.set("n", "<F4>", "<cmd>Outline<CR>", { desc = "Outliner (Tagbar)" })

vk.set("n", "25", "<cmd>vertical resize 40<CR>", { desc = "Resize window 25%" })
vk.set("n", "75", "<cmd>vertical resize 120<CR>", { desc = "Resize window 75%" })
vk.set("n", "50", "<c-w>=", { desc = "Resize window 75%" })

-- These are useful when exiting curly braces, quotes, parens, etc in insert mode.
-- jumps to the next position after the closest closing char
vk.set("i", ",e", [[<Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>a]], { desc = "Exit pair" })
vk.set("i", ",e,", [[<Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>a,<Space>]], { desc = "Exit pair and add comma" })
vk.set("i", ",ee", [[<Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>A;]], { desc = "Exit pair and add semicolon" })

-- Map Backspace and Enter to previous and next paragraphs
vk.set({ "n", "o", "v" }, "<BS>", "{", { desc = "Previous paragraph" })
-- TODO: Check &buftype variable
vk.set({ "n", "o", "v" }, "<CR>", "}", { desc = "Next paragraph" })

-- On each invoke, in insert mode, fix the last misspelled word
-- using the first result from correction list (z=)
-- Spell must be enabled using:
-- :set spell
vk.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Fix the last spelling error" })

vk.set("n", "<Leader>fq", "<cmd>e ~/.quick<CR>", { desc = "Open .quick notes" })
vk.set("n", "<Leader>rR", "@:", { desc = "Rerun the last command" })
